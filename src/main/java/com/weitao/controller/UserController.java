package com.weitao.controller;

import com.github.pagehelper.PageInfo;
import com.weitao.domain.Msg;
import com.weitao.domain.Userinf;
import com.weitao.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.Enumeration;
import java.util.List;
import java.util.UUID;

@Controller
public class UserController {
    @Autowired
    UserService userService;

    @RequestMapping(value = "/login")
    @ResponseBody
    public Msg login(String username, String password,HttpServletRequest request)
    {

        String regName="^[a-zA-Z0-9_-]{6,16}$";
        if(!username.matches(regName))
        {
            return Msg.fail().add("inf","用户名必须为6-16位字符");
        }
        Msg m=userService.login(username,password);
        if(m.getCode()==200)
        {
            return Msg.fail().add("inf","用户名或密码不正确");
        }
        HttpSession session=request.getSession();
        session.setAttribute("username",username);
        session.setAttribute("password",password);
        session.setAttribute("uId",m.getExtend().get("uId"));
        return Msg.success().add("inf","登录成功").add("active",m.getExtend().get("active"));
    }
    @RequestMapping(value = "/logout")
    public void logout(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
        HttpSession session=request.getSession();
        Enumeration enumeration=session.getAttributeNames();
        while (enumeration.hasMoreElements())
        {
            session.removeAttribute(enumeration.nextElement().toString());
        }
        request.getRequestDispatcher("/index.jsp").forward(request,response);
    }
    @RequestMapping(value = "/userCenter")
    public String  userCenter(String username, String password, HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session=request.getSession();
        if(userService.login(username,password).getCode()==200)
        {
            Enumeration enumeration=session.getAttributeNames();
            while(enumeration.hasMoreElements())
            {
                session.removeAttribute(enumeration.nextElement().toString());
            }
            request.setAttribute("message","用户名或密码不正确!请重新登录");
            request.getRequestDispatcher("/index.jsp").forward(request,response);

        }
        Userinf userinf=userService.userInfo(username,password);
        request.setAttribute("userinf",userinf);

        return "front/userCenter";
    }
    @RequestMapping(value = "/manageUser")
    public String manageUser(HttpServletRequest request,@RequestParam(defaultValue = "1") Integer pageNum)
    {

        List<Userinf> userinfList=userService.getAllUser(pageNum);
        PageInfo pageInfo=new PageInfo(userinfList,5);
        request.setAttribute("pageInfo",pageInfo);
        return "back/manageUser";
    }
    @RequestMapping(value = "/deleteUser")
    @ResponseBody
    public boolean deleteUser(Integer uid)
    {
        userService.deleteUser(uid);
        return true;
    }
    @RequestMapping(value = "/register")
    @ResponseBody
    public Msg register(HttpServletRequest request,String username,String password,String nickname,String major,MultipartFile multipartFile) throws IOException {
        String regName="^[a-zA-Z0-9_-]{6,16}$";
        if(!username.matches(regName))
        {
            return Msg.fail().add("inf","用户名必须为6-16位字符");
        }
        if(userService.isUsernameRepeat(username))
        {
            return Msg.fail().add("inf","用户名重复，请按照要求输入");

        }

        String path=request.getSession().getServletContext().getRealPath("/uploads/");
        File file=new File(path);
        if(!file.exists())
        {
            file.mkdirs();
        }
        String uuid=UUID.randomUUID().toString().replace("-","");
        String filename=multipartFile.getOriginalFilename();
        filename=uuid+"_"+filename;
        multipartFile.transferTo(new File(path,filename));

        userService.register(username,password,nickname,major,"/uploads/"+filename);
        return Msg.success();
    }
    @RequestMapping(value = "/fileupload2")
    public void fileupload2(HttpServletRequest httpServletRequest,HttpServletResponse httpServletResponse,MultipartFile multipartFile) throws IOException, ServletException {
        String path=httpServletRequest.getSession().getServletContext().getRealPath("/uploads/");
        File file=new File(path);
        if(!file.exists())
        {
            file.mkdirs();
        }
        String uuid=UUID.randomUUID().toString().replace("-","");
        String filename=multipartFile.getOriginalFilename();
        filename=uuid+"_"+filename;
        multipartFile.transferTo(new File(path,filename));

        Integer id= (Integer) httpServletRequest.getSession().getAttribute("uId");
        userService.updateImage(id,"/uploads/"+filename);
       httpServletRequest.getRequestDispatcher("/index.jsp").forward(httpServletRequest,httpServletResponse);
    }
    @RequestMapping(value = "/updateUser")
    @ResponseBody
    public boolean updateUser(HttpServletRequest request,String nickname,String major)
    {
        Integer uid= (Integer) request.getSession().getAttribute("uId");
        userService.updateUser(uid,nickname,major);
        return true;
    }
    @RequestMapping(value = "/updatePassword")
    @ResponseBody
    public boolean updatePassword(String oldPassword,String newPassword,HttpServletRequest request)
    {
        Integer id= (Integer) request.getSession().getAttribute("uId");
        return userService.updatePassword(id,oldPassword,newPassword);
    }
    @RequestMapping(value = "/isUsernameRepeat")
    @ResponseBody
    public boolean isUsernameRepeat(String username)
    {
        return userService.isUsernameRepeat(username);
    }
}
