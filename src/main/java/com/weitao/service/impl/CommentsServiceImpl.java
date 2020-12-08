package com.weitao.service.impl;

import com.github.pagehelper.PageHelper;
import com.weitao.dao.CommentsMapper;
import com.weitao.domain.Comments;
import com.weitao.domain.CommentsExample;
import com.weitao.service.CommentsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import java.util.List;
@Service
public class CommentsServiceImpl implements CommentsService {
    @Autowired
    CommentsMapper commentsMapper;
    @Override
    public List<Comments> selectByCidAndPageNum(Integer pageNum,Integer cid) {
        CommentsExample example=new CommentsExample();
        example.createCriteria().andCidEqualTo(cid);
        PageHelper.startPage(pageNum,10);
        List<Comments> commentsList=commentsMapper.selectByExampleWithUser(example);
        return commentsList;
    }

    @Override
    public boolean hasComment(Integer uid, Integer cid) {
        CommentsExample example=new CommentsExample();
        example.createCriteria().andUidEqualTo(uid).andCidEqualTo(cid);
        if(commentsMapper.countByExample(example)>0)
        {
            return true;
        }
        return false;
    }

    @Override
    public int addComment(Integer uid, Integer cid, Integer star, String text) {
        Comments comments=new Comments();
        comments.setCid(cid);
        comments.setUid(uid);
        comments.setStar(star);
        comments.setText(text);
        return  commentsMapper.insert(comments);
    }

    @Override
    public Comments selectByCidAndUid(Integer uid, Integer cid) {
        CommentsExample example=new CommentsExample();
        example.createCriteria().andUidEqualTo(uid).andCidEqualTo(cid);
        List<Comments> commentsList=commentsMapper.selectByExample(example);
        if(commentsList!=null&&commentsList.size()>0)
        {
            return commentsList.get(0);
        }
        return null;
    }


}
