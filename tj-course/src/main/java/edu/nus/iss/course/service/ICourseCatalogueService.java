package edu.nus.iss.course.service;

import com.baomidou.mybatisplus.extension.service.IService;
import edu.nus.iss.api.dto.course.CatalogueDTO;
import edu.nus.iss.api.dto.course.MediaQuoteDTO;
import edu.nus.iss.api.dto.course.SectionInfoDTO;
import edu.nus.iss.course.domain.po.CourseCatalogue;
import edu.nus.iss.course.domain.vo.CataSimpleInfoVO;
import edu.nus.iss.course.domain.vo.CataVO;

import java.util.List;

/**
 * <p>
 * 目录草稿 服务类
 * </p>
 *
 * @author wusongsong
 * @since 2022-07-19
 */
public interface ICourseCatalogueService extends IService<CourseCatalogue> {

    /**
     * 查询线上课程目录
     *
     * @param courseId 课程id
     * @return 课程目录
     */
    List<CatalogueDTO> queryCourseCatalogues(Long courseId, Boolean withPractice);

    /**
     * 批量统计媒资id引用次数
     *
     * @param mediaIds 媒资id
     * @return 媒资引用次数
     */
    List<MediaQuoteDTO> countMediaUserInfo(List<Long> mediaIds);

    /**
     * 获取简单的小节信息，
     *
     * @param sectionId 小节id
     * @return 课程id，媒资id，是否支持免费试看，免费试看时长
     */
    SectionInfoDTO getSimpleSectionInfo(Long sectionId);

    /**
     * 根据课程id获取课程的目录列表
     *
     * @param courseId 课程id
     * @return 课程的目录列表
     */
    List<CataSimpleInfoVO> getCatasIndexList(Long courseId);

    List<CataSimpleInfoVO> getManyCataSimpleInfo(List<Long> ids);

    CataSimpleInfoVO querySectionInfoById(Long id);

    List<CataVO> queryCourseCataloguesVO(Long courseId, Boolean withPractice);
}
