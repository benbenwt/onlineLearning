package com.weitao.dao;

import com.weitao.domain.Userlabel;
import com.weitao.domain.UserlabelExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface UserlabelMapper {
    long countByExample(UserlabelExample example);

    int deleteByExample(UserlabelExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(Userlabel record);

    int insertSelective(Userlabel record);

    List<Userlabel> selectByExample(UserlabelExample example);

    Userlabel selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") Userlabel record, @Param("example") UserlabelExample example);

    int updateByExample(@Param("record") Userlabel record, @Param("example") UserlabelExample example);

    int updateByPrimaryKeySelective(Userlabel record);

    int updateByPrimaryKey(Userlabel record);
}