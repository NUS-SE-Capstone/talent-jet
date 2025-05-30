package edu.nus.iss.search.impl;

import edu.nus.iss.api.client.course.CourseClient;
import edu.nus.iss.api.dto.course.CourseSearchDTO;
import edu.nus.iss.common.utils.BeanUtils;
import edu.nus.iss.common.utils.RandomUtils;
import edu.nus.iss.search.domain.po.Course;
import edu.nus.iss.search.domain.vo.CourseVO;
import edu.nus.iss.search.repository.CourseRepository;
import edu.nus.iss.search.service.ICourseService;
import edu.nus.iss.search.service.ISearchService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@SpringBootTest
class CourseServiceImplTest {

    @Autowired
    private ISearchService searchService;

    @Autowired
    private CourseRepository repository;

    @Autowired
    private CourseClient courseClient;

    @Autowired
    private ICourseService courseService;

    @Test
    void testTop5Best() {
        List<CourseVO> courseVOS = searchService.queryBestTopN();
        for (CourseVO courseVO : courseVOS) {
            System.out.println("courseVO = " + courseVO);
        }
    }

    @Test
    void testTop5New() {
        List<CourseVO> courseVOS = searchService.queryNewTopN();
        for (CourseVO courseVO : courseVOS) {
            System.out.println("courseVO = " + courseVO);
        }
    }

    @Test
    void testTop5Free() {
        List<CourseVO> courseVOS = searchService.queryFreeTopN();
        for (CourseVO courseVO : courseVOS) {
            System.out.println("courseVO = " + courseVO);
        }
    }

    static List<Long> teachers = List.of(
            1548889371405492225L, 1548940676303970306L,
            1548940777449611265L, 1548940921662365698L,
            1548941239125041153L, 1548941336596471809L
    );

    @Test
    void testLoadCourse() {
        for (long i = 1549025085494521857L; i <= 1549025085494521857L; i++) {
            // 1.根据id查询课程信息
            CourseSearchDTO courseSearchDTO = courseClient.getSearchInfo(i);
            if (courseSearchDTO == null) {
                return;
            }
            // 2.数据转换
            Course course = BeanUtils.toBean(courseSearchDTO, Course.class);
            course.setType(courseSearchDTO.getCourseType());
            course.setScore(41 + RandomUtils.randomInt(10));
            course.setSold(0);
            // 3.写入索引库
            repository.save(course);
        }
    }

    @Test
    void testRepository() {
        List<Course> list = new ArrayList<>();
        List<String> courses=new ArrayList<>();
        Map<String,String> courseCoverUrls=new HashMap<>();
        courses.add("Java");
        courseCoverUrls.put("Java","https://wisehub-1361028219.cos.ap-singapore.myqcloud.com/java.jpeg");
        courses.add("Go");
        courseCoverUrls.put("Go","https://wisehub-1361028219.cos.ap-singapore.myqcloud.com/go.png");
        courses.add("C++");
        courseCoverUrls.put("C++","https://wisehub-1361028219.cos.ap-singapore.myqcloud.com/c%2B%2B.png");
        courses.add("Kubernetes");
        courseCoverUrls.put("Kubernetes","https://wisehub-1361028219.cos.ap-singapore.myqcloud.com/k8s.jpeg");
        courses.add("Javascript");
        courseCoverUrls.put("Javascript","https://wisehub-1361028219.cos.ap-singapore.myqcloud.com/js.png");
        courses.add("React");
        courseCoverUrls.put("react","https://wisehub-1361028219.cos.ap-singapore.myqcloud.com/react.png");
        courses.add("Vue");
        courseCoverUrls.put("Vue","https://wisehub-1361028219.cos.ap-singapore.myqcloud.com/vue.png");

        for (int i = 0; i < 20; i++) {
            LocalDateTime time = LocalDateTime.now().minusDays(RandomUtils.randomInt(20));
            Course course = new Course();
            course.setName(courses.get(i%7));
            course.setId(1L + i);
            course.setCategoryIdLv1(1001L);
            course.setCategoryIdLv2(2000L + RandomUtils.randomInt(1,9));
            course.setCategoryIdLv3(3007L);
            course.setCoverUrl(courseCoverUrls.get(course.getName()));
            course.setFree(RandomUtils.randomBoolean());
            course.setPublishTime(time);
            course.setScore(30 + RandomUtils.randomInt(20));
            course.setSections(10 + RandomUtils.randomInt(10));
            course.setSold(200 + RandomUtils.randomInt(1000));
            course.setTeacher(teachers.get(RandomUtils.randomInt(5)));
            course.setType(2);
            list.add(course);
        }

        repository.saveAll(list);
    }
}