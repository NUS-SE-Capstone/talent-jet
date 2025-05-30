package edu.nus.iss.course.utils;

import edu.nus.iss.common.utils.TreeDataUtils;
import edu.nus.iss.course.domain.po.Category;
import edu.nus.iss.course.domain.vo.SimpleCategoryVO;

import java.util.List;

/**
 * @ClassName CategoryDataWrapper
 * @Author wusongsong
 * @Date 2022/9/21 17:45
 * @Version
 **/
public class CategoryDataWrapper implements TreeDataUtils.DataProcessor<SimpleCategoryVO, Category> {

    @Override
    public Object getParentKey(Category category) {
        return category.getParentId();
    }

    @Override
    public Object getKey(Category category) {
        return category.getId();
    }

    @Override
    public Object getRootKey() {
        return 0L;
    }

    @Override
    public List<SimpleCategoryVO> getChild(SimpleCategoryVO simpleCategoryVO) {
        return simpleCategoryVO.getChildren();
    }

    @Override
    public void setChild(SimpleCategoryVO parent, List<SimpleCategoryVO> child) {
        parent.setChildren(child);
    }
}
