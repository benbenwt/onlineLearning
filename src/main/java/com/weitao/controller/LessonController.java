package com.weitao.controller;

import com.github.pagehelper.PageInfo;
import com.weitao.dao.LessonMapper;
import com.weitao.domain.Course;
import com.weitao.domain.CourseExample;
import com.weitao.domain.Lesson;
import com.weitao.domain.LessonExample;
import com.weitao.service.LessonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
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
public class LessonController {
    @Autowired
    LessonService lessonService;
    @RequestMapping("/lesson")
    public String lesson(HttpServletRequest request){
        Integer id=Integer.parseInt(request.getParameter("id"));

        List<Lesson> list=lessonService.selectByCid(id);
        request.setAttribute("cid",id);
        request.setAttribute("lessonlist",list);

        return "front/lesson";
    }
    @RequestMapping(value = "/manageLesson")
    public String manageLesson(HttpServletRequest request,Integer cid,@RequestParam(defaultValue = "1") Integer pageNum)
    {
        List<Lesson> lessonList=lessonService.selectByCidAndPageNum(cid,pageNum);
        PageInfo pageInfo=new PageInfo(lessonList,5);
        request.setAttribute("pageInfo",pageInfo);
        request.setAttribute("cid",cid);
        return "back/manageLesson";
    }
    @RequestMapping(value = "/deleteLesson")
    @ResponseBody
    public boolean deleteLesson(Integer id)
    {
        lessonService.deleteById(id);
        return true;
    }
    @RequestMapping(value = "/addLesson")
    @ResponseBody
    public boolean addLesson(HttpServletRequest httpServletRequest,String name, Integer cid,@RequestParam( value="files",required=false)MultipartFile multipartFile) throws IOException {

        String path=httpServletRequest.getSession().getServletContext().getRealPath("/uploads/");
        File file=new File(path);
        if(!file.exists())
        {
            file.mkdirs();
        }
        String uuid= UUID.randomUUID().toString().replace("-","");
        String filename=multipartFile.getOriginalFilename();
        filename=uuid+"_"+filename;
        multipartFile.transferTo(new File(path,filename));

        lessonService.addLesson(cid,name,"/uploads/"+filename);
        return true;
    }
}
