package com.weitao.service.impl;

import com.github.pagehelper.PageHelper;
import com.weitao.dao.LessonMapper;
import com.weitao.domain.Lesson;
import com.weitao.domain.LessonExample;
import com.weitao.service.LessonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class LessonServiceImpl implements LessonService {
    @Autowired
    LessonMapper lessonMapper;
    @Override
    public List<Lesson> selectByCid(Integer cid) {
        LessonExample example1=new LessonExample();
        example1.createCriteria().andCidEqualTo(cid);
        return lessonMapper.selectByExample(example1);
    }

    @Override
    public List<Lesson> selectByCidAndPageNum(Integer cid, Integer pageNum) {
        PageHelper.startPage(pageNum,10);
        LessonExample example=new LessonExample();
        example.createCriteria().andCidEqualTo(cid);
        List<Lesson> lessonList=lessonMapper.selectByExample(example);
        return lessonList;
    }

    @Override
    public void deleteById(Integer id) {
        lessonMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void addLesson(Integer cid, String name, String vedio) {
        Lesson record=new Lesson();
        record.setCid(cid);record.setName(name);record.setVedio(vedio);
        lessonMapper.insertSelective(record);
    }
}
