package edu.nus.iss.trade.service;

import edu.nus.iss.trade.domain.dto.OrderDelayQueryDTO;
import edu.nus.iss.trade.domain.dto.PayApplyFormDTO;
import edu.nus.iss.trade.domain.vo.PayChannelVO;

import java.util.List;

public interface IPayService {
    List<PayChannelVO> queryPayChannels();

    String applyPayOrder(PayApplyFormDTO payApply);

    void queryPayResult(OrderDelayQueryDTO message);
}
