package com.weitao.service.impl;

import com.github.pagehelper.PageHelper;

import com.weitao.dao.CourseMapper;
import com.weitao.dao.UsercourseMapper;
import com.weitao.dao.UserlabelMapper;
import com.weitao.domain.*;
import com.weitao.service.CourseService;

import com.weitao.utils.Mahout;
import org.apache.mahout.cf.taste.common.TasteException;
import org.apache.mahout.cf.taste.recommender.RecommendedItem;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
@Service
public class CourseServiceImpl implements CourseService {
    @Autowired
    UserlabelMapper userlabelMapper;
    @Autowired
    CourseMapper courseMapper;
    @Autowired
    UsercourseMapper usercourseMapper;
    @Autowired
    Mahout mahout;
    @Override
    public List<Course> selectByPageNumAndCategory(Integer pageNum,String category) {

        List<Course> list=new ArrayList<Course>();
        if(category.equals("all")){
            PageHelper.startPage(pageNum,12);
            list=courseMapper.selectByExample(null);
        }
        else{
            CourseExample example=new CourseExample();
            example.createCriteria().andCategoryEqualTo(category);
            PageHelper.startPage(pageNum,12);
            list=courseMapper.selectByExample(example);
        }


        return list;
    }

    @Override
    public Course selectByCid(Integer cid) {
        CourseExample example=new CourseExample();
        example.createCriteria().andIdEqualTo(cid);
        List<Course> list=courseMapper.selectByExample(example);
        return list.get(0);
    }

    @Override
    public List<Course> selectByPageNumAndUid(Integer pageNum, Integer uid) {
        UsercourseExample example=new UsercourseExample();
        example.createCriteria().andUidEqualTo(uid);

        List<Usercourse> usercourseList= usercourseMapper.selectByExample(example);
        List<Integer> cidList=new ArrayList<>();
        for (Usercourse usercourse :
                usercourseList) {
            cidList.add(usercourse.getCid());
        }

        CourseExample example1=new CourseExample();
        example1.createCriteria().andIdIn(cidList);
        PageHelper.startPage(pageNum,12);
        List<Course> courseList=courseMapper.selectByExample(example1);


        return courseList;

    }

    @Override
    public List<Course> recommend(Integer uid,Integer pageNum) throws TasteException {
        List<RecommendedItem> itemList=mahout.recommendByUser(uid,60);
        if(itemList.size()==0)
        {
            //若评价信息不足，无法协同推荐，则使用标签。
            UserlabelExample userlabelExample=new UserlabelExample();
            userlabelExample.createCriteria().andUseridEqualTo(uid);
            List<Userlabel> userlabelList=userlabelMapper.selectByExample(userlabelExample);

            List<String> list=new ArrayList<String>();
            for(Userlabel userlabel:userlabelList)
            {
                list.add(userlabel.getLabel());
            }

            CourseExample example=new CourseExample();
            example.createCriteria().andCategoryIn(list);
            PageHelper.startPage(pageNum,12);
            List<Course> courseList=courseMapper.selectByExample(example);
            return courseList;
        }
        List<Integer> integerList =new ArrayList<>();
        for(RecommendedItem recommendedItem:itemList)
        {
            integerList.add((int) recommendedItem.getItemID());
        }
        CourseExample example=new CourseExample();
        example.createCriteria().andIdIn(integerList);
        PageHelper.startPage(pageNum,12);
        List<Course> courseList=courseMapper.selectByExample(example);
        return courseList;
    }

    @Override
    public List<Course> recommendByItem(Integer cid, Integer pageNum) throws TasteException {
        List<RecommendedItem> itemList=mahout.recommendByItem(cid,60);
        List<Integer> integerList =new ArrayList<>();
        for(RecommendedItem recommendedItem:itemList)
        {
            integerList.add((int) recommendedItem.getItemID());
        }
        CourseExample example=new CourseExample();
        example.createCriteria().andIdIn(integerList);
        PageHelper.startPage(pageNum,12);
        List<Course> courseList=courseMapper.selectByExample(example);
        return courseList;
    }

    @Override
    public List<Course> getAllCourse(Integer pageNum) {
        List<Course> courseList;
        PageHelper.startPage(pageNum,10);
        courseList=courseMapper.selectByExample(null);

        return courseList;
    }

    @Override
    public void deleteCourse(Integer cid) {
        courseMapper.deleteByPrimaryKey(cid);
    }

    @Override
    public void addCourse(String name, String category, Integer tid,String img) {
        Course record=new Course();
        record.setName(name);record.setCategory(category);record.setTid(tid);record.setImage(img);
        courseMapper.insert(record);
    }


}
