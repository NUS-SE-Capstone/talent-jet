package edu.nus.iss.learning.service;

import com.baomidou.mybatisplus.extension.service.IService;
import edu.nus.iss.common.domain.dto.PageDTO;
import edu.nus.iss.learning.domain.dto.NoteFormDTO;
import edu.nus.iss.learning.domain.po.Note;
import edu.nus.iss.learning.domain.query.NoteAdminPageQuery;
import edu.nus.iss.learning.domain.query.NotePageQuery;
import edu.nus.iss.learning.domain.vo.NoteAdminDetailVO;
import edu.nus.iss.learning.domain.vo.NoteAdminVO;
import edu.nus.iss.learning.domain.vo.NoteVO;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author 虎哥
 */
public interface INoteService extends IService<Note> {

    void saveNote(NoteFormDTO noteDTO);

    void gatherNote(Long id);

    void removeGatherNote(Long id);

    void updateNote(NoteFormDTO noteDTO);

    PageDTO<NoteVO> queryNotePage(NotePageQuery query);

    PageDTO<NoteAdminVO> queryNotePageForAdmin(NoteAdminPageQuery query);

    NoteAdminDetailVO queryNoteDetailForAdmin(Long id);

    void hiddenNote(Long id, boolean hidden);

    void removeMyNote(Long id);
}
