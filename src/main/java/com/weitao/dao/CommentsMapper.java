package com.weitao.dao;

import com.weitao.domain.Comments;
import com.weitao.domain.CommentsExample;
import com.weitao.domain.CommentsKey;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface CommentsMapper {
    long countByExample(CommentsExample example);

    int deleteByExample(CommentsExample example);

    int deleteByPrimaryKey(CommentsKey key);

    int insert(Comments record);

    int insertSelective(Comments record);

    List<Comments> selectByExample(CommentsExample example);

    List<Comments> selectByExampleWithUser(CommentsExample example);

    Comments selectByPrimaryKey(CommentsKey key);

    int updateByExampleSelective(@Param("record") Comments record, @Param("example") CommentsExample example);

    int updateByExample(@Param("record") Comments record, @Param("example") CommentsExample example);

    int updateByPrimaryKeySelective(Comments record);

    int updateByPrimaryKey(Comments record);
}