package edu.nus.iss.trade.handler;

import edu.nus.iss.common.constants.MqConstants;
import edu.nus.iss.pay.sdk.dto.PayResultDTO;
import edu.nus.iss.pay.sdk.dto.RefundResultDTO;
import edu.nus.iss.trade.domain.dto.OrderDelayQueryDTO;
import edu.nus.iss.trade.service.IOrderService;
import edu.nus.iss.trade.service.IPayService;
import edu.nus.iss.trade.service.IRefundApplyService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.amqp.core.ExchangeTypes;
import org.springframework.amqp.rabbit.annotation.Exchange;
import org.springframework.amqp.rabbit.annotation.Queue;
import org.springframework.amqp.rabbit.annotation.QueueBinding;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.stereotype.Component;

@Slf4j
@Component
@RequiredArgsConstructor
public class PayMessageHandler {

    private final IOrderService orderService;
    private final IRefundApplyService refundApplyService;
    private final IPayService payService;

    @RabbitListener(bindings = @QueueBinding(
            value = @Queue(name = "trade.pay.success.queue", durable = "true"),
            exchange = @Exchange(name = MqConstants.Exchange.PAY_EXCHANGE, type = ExchangeTypes.TOPIC),
            key = MqConstants.Key.PAY_SUCCESS
    ))
    public void listenPaySuccess(PayResultDTO payResult){
        log.debug("收到支付成功通知：{}", payResult);
        orderService.handlePaySuccess(payResult);
    }

    @RabbitListener(bindings = @QueueBinding(
            value = @Queue(name = "trade.refund.result.queue", durable = "true"),
            exchange = @Exchange(name = MqConstants.Exchange.PAY_EXCHANGE, type = ExchangeTypes.TOPIC),
            key = MqConstants.Key.REFUND_CHANGE
    ))
    public void listenRefundResult(RefundResultDTO refundResult){
        log.debug("收到退款变更成功通知：{}", refundResult);
        refundApplyService.handleRefundResult(refundResult);
    }

    @RabbitListener(bindings = @QueueBinding(
            value = @Queue(name = "trade.delay.order.query", durable = "true"),
            exchange = @Exchange(name = MqConstants.Exchange.TRADE_DELAY_EXCHANGE, delayed = "true", type = ExchangeTypes.TOPIC),
            key = MqConstants.Key.ORDER_DELAY_KEY
    ))
    public void listenOrderDelayQueryMessage(OrderDelayQueryDTO message){
        log.debug("收到订单延迟查询通知：{}", message);
        payService.queryPayResult(message);
    }
}
