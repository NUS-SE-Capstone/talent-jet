package edu.nus.iss.trade.service;

import com.baomidou.mybatisplus.extension.service.IService;
import edu.nus.iss.common.domain.dto.PageDTO;
import edu.nus.iss.pay.sdk.dto.PayResultDTO;
import edu.nus.iss.trade.constants.OrderCancelReason;
import edu.nus.iss.trade.domain.dto.PlaceOrderDTO;
import edu.nus.iss.trade.domain.po.Order;
import edu.nus.iss.trade.domain.po.OrderDetail;
import edu.nus.iss.trade.domain.query.OrderPageQuery;
import edu.nus.iss.trade.domain.vo.OrderConfirmVO;
import edu.nus.iss.trade.domain.vo.OrderPageVO;
import edu.nus.iss.trade.domain.vo.OrderVO;
import edu.nus.iss.trade.domain.vo.PlaceOrderResultVO;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * <p>
 * 订单 服务类
 * </p>
 *
 * @author 虎哥
 * @since 2022-08-29
 */
public interface IOrderService extends IService<Order> {

    PlaceOrderResultVO placeOrder(PlaceOrderDTO placeOrderDTO);

    @Transactional
    void saveOrderAndDetails(Order order, List<OrderDetail> orderDetails);

    void cancelOrder(Long orderId, OrderCancelReason cancelReason);

    void deleteOrder(Long id);

    PageDTO<OrderPageVO> queryMyOrderPage(OrderPageQuery pageQuery);

    OrderVO queryOrderById(Long id);

    PlaceOrderResultVO queryOrderStatus(Long orderId);

    void handlePaySuccess(PayResultDTO payResult);

    PlaceOrderResultVO enrolledFreeCourse(Long courseId);

    OrderConfirmVO prePlaceOrder(List<Long> courseIds);

}
