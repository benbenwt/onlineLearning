package com.weitao.service.impl;

import com.weitao.dao.AdminMapper;
import com.weitao.domain.Admin;
import com.weitao.domain.AdminExample;
import com.weitao.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class AdminServiceImpl implements AdminService {
    @Autowired
    AdminMapper adminMapper;
    @Override
    public boolean login(String username, String password) {
        AdminExample example=new AdminExample();
        example.createCriteria().andUsernameEqualTo(username).andPasswordEqualTo(password);
        List<Admin> adminList=adminMapper.selectByExample(example);
        if(adminList!=null&adminList.size()>0)
        {
            return true;
        }
        return false;
    }
}
