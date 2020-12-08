package com.weitao.service;

import com.weitao.domain.Lesson;

import java.util.List;

public interface LessonService {
    public List<Lesson> selectByCid(Integer cid);
    public List<Lesson> selectByCidAndPageNum(Integer cid,Integer pageNum);
    public void deleteById(Integer id);
    public void addLesson(Integer cid,String name,String vedio);
}
