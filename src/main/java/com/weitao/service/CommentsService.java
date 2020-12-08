package com.weitao.service;

import com.weitao.domain.Comments;

import java.util.List;

public interface CommentsService {
     List<Comments> selectByCidAndPageNum(Integer pageNum,Integer cid);
     boolean hasComment(Integer uid,Integer cid);
     int addComment(Integer uid,Integer cid,Integer star,String text);
     Comments selectByCidAndUid(Integer uid,Integer cid);
}
