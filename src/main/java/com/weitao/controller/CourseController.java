package com.weitao.controller;


import com.github.pagehelper.PageInfo;

import com.weitao.domain.*;
import com.weitao.service.CourseService;
import com.weitao.utils.Mahout;
import org.apache.mahout.cf.taste.common.TasteException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

@Controller
public class CourseController {
    @Autowired
    CourseService courseService;

    @RequestMapping(value = "/course")
    public String course(@RequestParam(defaultValue ="1" ) int pageNum, @RequestParam(defaultValue = "all") String category,HttpServletRequest request)
    {
        request.setAttribute("lastCategory",category);
        List<Course> courseList=courseService.selectByPageNumAndCategory(pageNum,category);
        PageInfo pageInfo=new PageInfo(courseList,5);
        request.setAttribute("pageinfo",pageInfo);
        return "front/course";
    }
    @RequestMapping(value = "/singleCourse")
    public String singleCourse(Integer id,HttpServletRequest request){
        Course course=courseService.selectByCid(id);
        request.setAttribute("course",course);

        return "front/singleCourse";
    }
    @RequestMapping(value = "/myCourse")
    @ResponseBody
    public PageInfo myCourse(@RequestParam(defaultValue ="1")Integer pageNum,Integer uid)
    {
        List<Course> courseList=courseService.selectByPageNumAndUid(pageNum,uid);
        PageInfo pageInfo=new PageInfo(courseList,5);
        return pageInfo;
    }
    @RequestMapping(value = "/recommend")
    public String recommend(@RequestParam(defaultValue = "1") Integer pageNum,HttpServletRequest request) throws TasteException {
        Integer uid= (Integer) request.getSession().getAttribute("uId");
        List<Course> courseList=courseService.recommend(uid,pageNum);
        PageInfo pageinfo=new PageInfo(courseList,5);
        request.setAttribute("pageinfo",pageinfo);
        return "front/recommend";
    }
    @RequestMapping(value = "/recommendByItem")
    @ResponseBody
    public PageInfo recommendByItem(Integer cid,@RequestParam(defaultValue = "1") Integer pageNum) throws TasteException {
        List<Course> courseList=courseService.recommendByItem(cid,pageNum);
        PageInfo pageinfo=new PageInfo(courseList,5);
        return pageinfo;
    }
    @RequestMapping(value = "/manageCourse")
    public String manageCourse(HttpServletRequest request,@RequestParam(defaultValue = "1") Integer pageNum)
    {
        List<Course> courseList=courseService.getAllCourse(pageNum);
        PageInfo pageInfo=new PageInfo(courseList,5);
        request.setAttribute("pageInfo",pageInfo);
        return "back/manageCourse";
    }
    @RequestMapping(value = "/deleteCourse")
    @ResponseBody
    public boolean deleteCourse(Integer cid)
    {
        courseService.deleteCourse(cid);
        return true;
    }
    @RequestMapping(value = "/addCourse")
    @ResponseBody
    public boolean addCourse(HttpServletRequest request,String name, String category, Integer tid, MultipartFile multipartFile) throws IOException {
        String path=request.getSession().getServletContext().getRealPath("/uploads/");
        File file=new File(path);
        if(!file.exists())
        {
            file.mkdirs();
        }
        String uuid= UUID.randomUUID().toString().replace("-","");
        String filename=multipartFile.getOriginalFilename();
        filename=uuid+"_"+filename;
        multipartFile.transferTo(new File(path,filename));


        courseService.addCourse(name,category,tid,"/uploads/"+filename);
        return true;
    }
}
