package com.weitao.dao;

import com.weitao.domain.Userinf;
import com.weitao.domain.UserinfExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface UserinfMapper {
    long countByExample(UserinfExample example);

    int deleteByExample(UserinfExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(Userinf record);

    int insertSelective(Userinf record);

    List<Userinf> selectByExample(UserinfExample example);

    Userinf selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") Userinf record, @Param("example") UserinfExample example);

    int updateByExample(@Param("record") Userinf record, @Param("example") UserinfExample example);

    int updateByPrimaryKeySelective(Userinf record);

    int updateByPrimaryKey(Userinf record);
}