package com.weitao.service.impl;

import com.weitao.dao.UsercourseMapper;
import com.weitao.domain.Usercourse;
import com.weitao.domain.UsercourseExample;
import com.weitao.service.UserCourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserCourseServiceImpl implements UserCourseService {
    @Autowired
    UsercourseMapper usercourseMapper;
    @Override
    public void subscribe(Usercourse usercourse) {

        usercourseMapper.insert(usercourse);
    }

    @Override
    public boolean isSubscribe(Integer uid, Integer cid) {
        UsercourseExample example=new UsercourseExample();
        example.createCriteria().andUidEqualTo(uid).andCidEqualTo(cid);
        List<Usercourse> usercourseList=usercourseMapper.selectByExample(example);
        if(usercourseList!=null&usercourseList.size()>0)
        {
            return  true;

        }
        return false;
    }

    @Override
    public boolean unSubscribe(Integer cid) {
        UsercourseExample example=new UsercourseExample();
        example.createCriteria().andCidEqualTo(cid);
        usercourseMapper.deleteByExample(example);
        return true;
    }
}
