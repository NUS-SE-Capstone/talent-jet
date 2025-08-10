package edu.nus.iss.learning.service;

import com.baomidou.mybatisplus.extension.service.IService;
import edu.nus.iss.common.domain.dto.PageDTO;
import edu.nus.iss.learning.domain.dto.QuestionFormDTO;
import edu.nus.iss.learning.domain.po.InteractionQuestion;
import edu.nus.iss.learning.domain.query.QuestionAdminPageQuery;
import edu.nus.iss.learning.domain.query.QuestionPageQuery;
import edu.nus.iss.learning.domain.vo.QuestionAdminVO;
import edu.nus.iss.learning.domain.vo.QuestionVO;

/**
 * <p>
 * 互动提问的问题表 服务类
 * </p>
 *
 * @author 虎哥
 */
public interface IInteractionQuestionService extends IService<InteractionQuestion> {

    void saveQuestion(QuestionFormDTO questionDTO);

    PageDTO<QuestionVO> queryQuestionPage(QuestionPageQuery query);

    QuestionVO queryQuestionById(Long id);

    PageDTO<QuestionAdminVO> queryQuestionPageAdmin(QuestionAdminPageQuery query);

    QuestionAdminVO queryQuestionByIdAdmin(Long id);

    void hiddenQuestion(Long id, Boolean hidden);

    void updateQuestion(Long id, QuestionFormDTO questionDTO);

    void deleteById(Long id);
}
