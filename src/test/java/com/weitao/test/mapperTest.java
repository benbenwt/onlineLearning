package com.weitao.test;


import com.weitao.dao.CommentsMapper;
import com.weitao.dao.CourseMapper;
import com.weitao.dao.LessonMapper;
import com.weitao.dao.UserinfMapper;

import com.weitao.domain.Comments;
import com.weitao.domain.Course;
import com.weitao.domain.Lesson;
import com.weitao.domain.Userinf;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;
import java.util.UUID;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:applicationContext.xml")
public class mapperTest {
    @Autowired
    private CommentsMapper mapper;
    @Test
    public void testCRUD()
    {
//        for(int i=1;i<20;i++)
//        {
//            int uid=Integer.parseInt(UUID.randomUUID().toString().substring(0,6));
            Comments comments=new Comments();
            comments.setStar(1);
            comments.setText("333");
            comments.setUid(1);
            comments.setCid(1);
            mapper.insert(comments);
//        }
//        List<Lesson> list=mapper.selectByExample(null);
//        for (Lesson course:
//             list) {
//            System.out.println(course);
//        }
    }
}
