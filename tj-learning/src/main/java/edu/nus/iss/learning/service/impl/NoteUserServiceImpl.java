package edu.nus.iss.learning.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import edu.nus.iss.learning.domain.po.NoteUser;
import edu.nus.iss.learning.mapper.NoteUserMapper;
import edu.nus.iss.learning.service.INoteUserService;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author 虎哥
 */
@Service
public class NoteUserServiceImpl extends ServiceImpl<NoteUserMapper, NoteUser> implements INoteUserService {

}
