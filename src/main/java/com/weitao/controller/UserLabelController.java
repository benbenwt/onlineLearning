package com.weitao.controller;

import com.weitao.domain.Msg;
import com.weitao.service.UserLabelService;
import com.weitao.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

@Controller
public class UserLabelController {
    @Autowired
    UserLabelService userLabelService;
    @Autowired
    UserService userService;
    @RequestMapping(value = "/userLabel")
    public String userLabel()
    {
        return "/front/userLabel";
    }
    @RequestMapping(value = "/addLabel")
    @ResponseBody
    public Msg addLabel(HttpServletRequest request,String[] labels)
    {
        Integer uId=(Integer) request.getSession().getAttribute("uId");
        userLabelService.addLabels(uId,labels);
        userService.setUserActive(uId);
        return Msg.success();
    }
}
