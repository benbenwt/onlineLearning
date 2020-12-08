package com.weitao.controller;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageInfo;
import com.weitao.domain.Comments;
import com.weitao.domain.Msg;
import com.weitao.service.CommentsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class CommentController {
    @Autowired
    CommentsService commentsService;
    @RequestMapping(value = "/comments")
    @ResponseBody
    public Msg comments(@RequestParam(defaultValue = "1") Integer pageNum, Integer cid)
    {
        List<Comments> commentsList=commentsService.selectByCidAndPageNum(pageNum,cid);
        PageInfo pageInfo=new PageInfo(commentsList,5);
        return Msg.success().add("pageinfo",pageInfo);
    }
    @RequestMapping(value = "/hasComment")
    @ResponseBody
    public boolean hasComment(Integer cid, HttpServletRequest request)
    {
        Integer uid= (Integer) request.getSession().getAttribute("uId");
        if(uid==null) return false;
        return  commentsService.hasComment(uid,cid);

    }
    @RequestMapping(value = "/myComment")
    @ResponseBody
    public Comments myComment(Integer cid,HttpServletRequest request)
    {
        Integer uid=(Integer)request.getSession().getAttribute("uId");
        if(uid==null)
        {
            throw new RuntimeException("未登录");
        }
        return commentsService.selectByCidAndUid(uid,cid);
    }

    @RequestMapping(value = "/addComment")
    public Msg addComment(HttpServletRequest request,Integer cid,Integer star,String text)
    {
        System.out.println(cid);
        System.out.println(star);
        System.out.println(text);
        commentsService.addComment((Integer) request.getSession().getAttribute("uId"),cid,star,text);
        return Msg.success();
    }
}
