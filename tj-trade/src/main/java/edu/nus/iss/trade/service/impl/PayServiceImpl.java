package edu.nus.iss.trade.service.impl;

import com.google.common.collect.Lists;
import edu.nus.iss.common.autoconfigure.mq.RabbitMqHelper;
import edu.nus.iss.common.exceptions.BadRequestException;
import edu.nus.iss.common.exceptions.BizIllegalException;
import edu.nus.iss.common.utils.AssertUtils;
import edu.nus.iss.common.utils.BeanUtils;
import edu.nus.iss.common.utils.CollUtils;
//import edu.nus.iss.pay.sdk.client.PayClient;
import edu.nus.iss.pay.sdk.constants.PayType;
import edu.nus.iss.pay.sdk.dto.PayApplyDTO;
import edu.nus.iss.pay.sdk.dto.PayChannelDTO;
import edu.nus.iss.pay.sdk.dto.PayResultDTO;
import edu.nus.iss.trade.config.TradeProperties;
import edu.nus.iss.trade.constants.OrderCancelReason;
import edu.nus.iss.trade.constants.OrderStatus;
import edu.nus.iss.trade.constants.TradeErrorInfo;
import edu.nus.iss.trade.domain.dto.OrderDelayQueryDTO;
import edu.nus.iss.trade.domain.dto.PayApplyFormDTO;
import edu.nus.iss.trade.domain.po.Order;
import edu.nus.iss.trade.domain.po.OrderDetail;
import edu.nus.iss.trade.domain.vo.PayChannelVO;
import edu.nus.iss.trade.service.IOrderDetailService;
import edu.nus.iss.trade.service.IOrderService;
import edu.nus.iss.trade.service.IPayService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.time.Duration;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

import static edu.nus.iss.common.constants.MqConstants.Exchange.TRADE_DELAY_EXCHANGE;
import static edu.nus.iss.common.constants.MqConstants.Key.ORDER_DELAY_KEY;
import static edu.nus.iss.trade.constants.TradeErrorInfo.ORDER_NOT_EXISTS;

@Slf4j
@Service
@RequiredArgsConstructor
public class PayServiceImpl implements IPayService {

    //    private final PayClient payClient;
    private final IOrderService orderService;
    private final IOrderDetailService detailService;
    private final TradeProperties tradeProperties;
    private final RabbitMqHelper mqHelper;

    @Override
    public List<PayChannelVO> queryPayChannels() {
//        List<PayChannelDTO> list = payClient.listAllPayChannels();
        List<PayChannelDTO> list = Lists.newArrayList();
        if (list == null) {
            return CollUtils.emptyList();
        }
        return list.stream()
                .filter(p -> p.getStatus() == 1)
                .map(p -> BeanUtils.copyBean(p, PayChannelVO.class))
                .collect(Collectors.toList());
    }

    @Override
    public String applyPayOrder(PayApplyFormDTO payApply) {
        Long orderId = payApply.getOrderId();
        // 1.查询订单信息
        Order order = orderService.getById(orderId);
        if (order == null) {
            throw new BadRequestException(ORDER_NOT_EXISTS);
        }
        // 2.判断订单状态
        if (!OrderStatus.NO_PAY.equalsValue(order.getStatus())) {
            // 订单已经支付或关闭
            throw new BizIllegalException(TradeErrorInfo.ORDER_ALREADY_FINISH);
        }
        // 3.判断订单是否已经超时
        if (order.getCreateTime().plusMinutes(tradeProperties.getPayOrderTTLMinutes()).isBefore(LocalDateTime.now())) {
            // 订单已经超时，无法支付
            throw new BizIllegalException(TradeErrorInfo.ORDER_OVER_TIME);
        }
        // 4.查询订单详情
        List<OrderDetail> details = detailService.queryByOrderId(orderId);
        AssertUtils.isNotEmpty(details, ORDER_NOT_EXISTS);

        // 5.封装下单参数
        PayApplyDTO payApplyDTO = PayApplyDTO.builder()
                .bizOrderNo(orderId)
                .amount(order.getRealAmount())
                .orderInfo(details.get(0).getName())
                .bizUserId(order.getUserId())
                .payType(PayType.NATIVE.getValue())
                .payChannelCode(payApply.getPayChannelCode())
                .build();
//        String url = payClient.applyPayOrder(payApplyDTO);
        String url="";
        // 6.通过延迟队列，异步查询支付结果
        sendDelayQueryMessage(OrderDelayQueryDTO.init(orderId));
        return url;
    }

    private void sendDelayQueryMessage(OrderDelayQueryDTO message) {
        mqHelper.sendDelayMessage(
                TRADE_DELAY_EXCHANGE,
                ORDER_DELAY_KEY,
                message, Duration.ofMillis(message.removeFirst()));
    }

    @Override
    public void queryPayResult(OrderDelayQueryDTO message) {
        // 1.获取订单信息
        Long orderId = message.getOrderId();
        Order order = orderService.getById(orderId);
        if (order == null) {
            log.error("要查询状态的订单：{}不存在", orderId);
            return;
        }
        // 2.判断订单状态
        if (!OrderStatus.NO_PAY.equalsValue(order.getStatus())) {
            // 订单已经支付或关闭，任务结束
            return;
        }
        // 3.查询支付状态
//        PayResultDTO payResult = payClient.queryPayResult(orderId);
//        TODO
        PayResultDTO payResult= PayResultDTO.builder()
                .status(PayResultDTO.FAILED)
                .build();
        int status = payResult.getStatus();
        if (PayResultDTO.SUCCESS != status) {
            // 3.1.支付中或支付失败，需要重试查询
            if (message.getDelayMillis().size() == 0) {
                // 重试次数用尽，如果依然未支付，则取消订单
                orderService.cancelOrder(orderId, OrderCancelReason.TIME_OUT);
                return;
            }
            // 发送延迟查询消息，再次查询支付状态
            sendDelayQueryMessage(message);
        }
        // 3.2.支付成功
        orderService.handlePaySuccess(payResult);
    }
}
