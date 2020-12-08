package com.weitao.service.impl;

import com.github.pagehelper.PageHelper;
import com.weitao.dao.UserinfMapper;
import com.weitao.domain.Msg;
import com.weitao.domain.Userinf;
import com.weitao.domain.UserinfExample;
import com.weitao.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    UserinfMapper userinfMapper;
    @Override
    public Msg login(String username, String password) {
        UserinfExample example=new UserinfExample();
        example.createCriteria().andUsernameEqualTo(username).andPasswordEqualTo(password);
        List<Userinf> list=userinfMapper.selectByExample(example);
        if(list!=null&&list.size()>0)
        {
            return Msg.success().add("uId",list.get(0).getId()).add("active",list.get(0).getActive());
        }
        return Msg.fail();
    }

    @Override
    public Userinf userInfo(String username,String password)
    {
        UserinfExample example=new UserinfExample();
        example.createCriteria().andUsernameEqualTo(username).andPasswordEqualTo(password);
        List<Userinf> userinfList=userinfMapper.selectByExample(example);
        return userinfList.get(0);
    }

    @Override
    public void setUserActive(Integer uId) {
        UserinfExample example=new UserinfExample();
        example.createCriteria().andIdEqualTo(uId);
        Userinf userinf=new Userinf();
        userinf.setActive((byte) 1);
        userinfMapper.updateByExampleSelective(userinf,example);
    }

    @Override
    public List<Userinf> getAllUser(Integer pageNum) {
        PageHelper.startPage(pageNum,10);
        return userinfMapper.selectByExample(null);
    }

    @Override
    public void deleteUser(Integer uid) {
        userinfMapper.deleteByPrimaryKey(uid);
    }

    @Override
    public void register(String username, String password, String nickname, String major,String image) {
        Userinf record=new Userinf();
        record.setUsername(username);record.setPassword(password);record.setNickname(nickname);record.setMajor(major);record.setImage(image);
        userinfMapper.insertSelective(record);
    }

    @Override
    public void updateUser(Integer uid,String nickname, String major) {
        Userinf record=new Userinf();
        record.setNickname(nickname);record.setMajor(major);
       UserinfExample example=new UserinfExample();
       example.createCriteria().andIdEqualTo(uid);
        userinfMapper.updateByExampleSelective(record,example);
    }

    @Override
    public boolean updatePassword(Integer uid, String oldPassword, String newPassword) {
        UserinfExample example=new UserinfExample();
        example.createCriteria().andIdEqualTo(uid).andPasswordEqualTo(oldPassword);
        List<Userinf> userinfList=userinfMapper.selectByExample(example);
        if(userinfList!=null&userinfList.size()>0)
        {
            Userinf record=new Userinf();
            record.setId(uid);record.setPassword(newPassword);
            userinfMapper.updateByPrimaryKeySelective(record);
            return true;
        }
        return false;
    }

    @Override
    public void updateImage(Integer id, String image) {
        Userinf record=new Userinf();
        record.setId(id);record.setImage(image);
        userinfMapper.updateByPrimaryKeySelective(record);
    }

    @Override
    public boolean isUsernameRepeat(String username) {
        UserinfExample example=new UserinfExample();
        example.createCriteria().andUsernameEqualTo(username);
        List<Userinf> list=userinfMapper.selectByExample(example);
        if(list!=null&list.size()>0)
        {
            return true;
        }
        return false;
    }

}
