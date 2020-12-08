package com.weitao.dao;

import com.weitao.domain.Lesson;
import com.weitao.domain.LessonExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface LessonMapper {
    long countByExample(LessonExample example);

    int deleteByExample(LessonExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(Lesson record);

    int insertSelective(Lesson record);

    List<Lesson> selectByExample(LessonExample example);

    Lesson selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") Lesson record, @Param("example") LessonExample example);

    int updateByExample(@Param("record") Lesson record, @Param("example") LessonExample example);

    int updateByPrimaryKeySelective(Lesson record);

    int updateByPrimaryKey(Lesson record);
}