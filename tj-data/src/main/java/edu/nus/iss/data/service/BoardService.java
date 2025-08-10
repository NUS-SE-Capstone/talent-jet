package edu.nus.iss.data.service;


import edu.nus.iss.data.model.dto.BoardDataSetDTO;
import edu.nus.iss.data.model.vo.EchartsVO;

import java.util.List;

/**
 * @ClassName BoardService
 * @Author wusongsong
 * @Date 2022/10/10 16:30
 * @Version
 **/
public interface BoardService {

    /**
     * 看板数据获取
     *
     * @param types 数据类型
     * @return
     */
    EchartsVO boardData(List<Integer> types);

    /**
     * 设置看板数据
     *
     * @param boardDataSetDTO
     */
    void setBoardData(BoardDataSetDTO boardDataSetDTO);
}