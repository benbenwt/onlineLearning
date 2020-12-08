package com.weitao.service;

import com.weitao.domain.Course;
import org.apache.mahout.cf.taste.common.TasteException;
import java.util.List;

public interface CourseService {
     List<Course> selectByPageNumAndCategory(Integer pageNum,String category);
     Course selectByCid(Integer cid);
     List<Course> selectByPageNumAndUid(Integer pageNum,Integer uid);
     List<Course> recommend(Integer uid,Integer pageNum) throws TasteException;
     List<Course> recommendByItem(Integer cid,Integer pageNum) throws TasteException;
     List<Course> getAllCourse(Integer pageNum);
     void deleteCourse(Integer cid);
     void addCourse(String name,String category,Integer tid,String img);
}
