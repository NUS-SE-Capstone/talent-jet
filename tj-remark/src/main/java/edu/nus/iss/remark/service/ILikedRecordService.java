package edu.nus.iss.remark.service;

import com.baomidou.mybatisplus.extension.service.IService;
import edu.nus.iss.remark.domain.dto.LikeRecordFormDTO;
import edu.nus.iss.remark.domain.po.LikedRecord;

import java.util.List;
import java.util.Set;

/**
 * <p>
 * 点赞记录表 服务类
 * </p>
 *
 * @author 虎哥
 */
public interface ILikedRecordService extends IService<LikedRecord> {

    void addLikeRecord(LikeRecordFormDTO recordDTO);

    Set<Long> isBizLiked(List<Long> bizIds);

    void readLikedTimesAndSendMessage(String bizType, int maxBizSize);
}
