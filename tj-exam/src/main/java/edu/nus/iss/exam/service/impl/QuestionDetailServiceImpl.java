package edu.nus.iss.exam.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import edu.nus.iss.exam.domain.po.QuestionDetail;
import edu.nus.iss.exam.mapper.QuestionDetailMapper;
import edu.nus.iss.exam.service.IQuestionDetailService;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 题目 服务实现类
 * </p>
 *
 * @author 虎哥
 * @since 2022-09-02
 */
@Service
public class QuestionDetailServiceImpl extends ServiceImpl<QuestionDetailMapper, QuestionDetail> implements IQuestionDetailService {

}
