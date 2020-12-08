package com.weitao.dao;

import com.weitao.domain.Usercourse;
import com.weitao.domain.UsercourseExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface UsercourseMapper {
    long countByExample(UsercourseExample example);

    int deleteByExample(UsercourseExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(Usercourse record);

    int insertSelective(Usercourse record);

    List<Usercourse> selectByExample(UsercourseExample example);

    Usercourse selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") Usercourse record, @Param("example") UsercourseExample example);

    int updateByExample(@Param("record") Usercourse record, @Param("example") UsercourseExample example);

    int updateByPrimaryKeySelective(Usercourse record);

    int updateByPrimaryKey(Usercourse record);
}