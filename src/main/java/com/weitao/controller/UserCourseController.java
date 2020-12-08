package com.weitao.controller;

import com.weitao.domain.Usercourse;
import com.weitao.service.UserCourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@Controller
public class UserCourseController {
    @Autowired
    UserCourseService userCourseService;
    @RequestMapping(value ="/subscribe")
    public void subscribe(Integer cId, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session=request.getSession();
        if(session.getAttribute("uId")==null)
        {
            request.setAttribute("message","未登录，请登录后订阅");
            request.getRequestDispatcher("/index.jsp").forward(request,response);
        }
        else{
            Usercourse usercourse=new Usercourse();
            usercourse.setCid(cId);
            usercourse.setUid((Integer) session.getAttribute("uId"));
            userCourseService.subscribe(usercourse);
            request.setAttribute("message","订阅成功");
            request.getRequestDispatcher("/singleCourse?id="+cId).forward(request,response);

        }

    }
    @RequestMapping(value = "/isSubscribe")
    @ResponseBody
    public boolean isSubscribe(Integer cid,HttpServletRequest request)
    {
        HttpSession session=request.getSession();
        if(session.getAttribute("uId")==null)
        {
            return false;
        }
        return userCourseService.isSubscribe((Integer) session.getAttribute("uId"),cid);

    }
    @RequestMapping(value = "/unSubscribe")
    public void unSubscribe(HttpServletRequest request,HttpServletResponse response,Integer cid) throws ServletException, IOException {
        userCourseService.unSubscribe(cid);
        request.getRequestDispatcher("/singleCourse?id="+cid).forward(request,response);
    }
}
