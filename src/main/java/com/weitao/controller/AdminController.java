package com.weitao.controller;

import com.weitao.domain.Msg;
import com.weitao.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Enumeration;

@Controller
public class AdminController {
    @Autowired
    AdminService adminService;
    @RequestMapping(value = "/adminLogin")
    @ResponseBody
    public Msg login(HttpServletRequest request, String username, String password)
    {
        HttpSession session=request.getSession();
        session.setAttribute("AdminUsername",username);
        session.setAttribute("AdminPassword",password);
        if(adminService.login(username,password))
        {
            return Msg.success();
        }
        return Msg.fail();
    }
    @RequestMapping(value = "/adminLogout")
    public void adminLogout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session=request.getSession();
        Enumeration<String> enumeration=session.getAttributeNames();
        while (enumeration.hasMoreElements())
        {
            String name=enumeration.nextElement();
            session.removeAttribute(name);
            System.out.println(name);
        }
        request.getRequestDispatcher("/admin.jsp").forward(request,response);
    }
}
