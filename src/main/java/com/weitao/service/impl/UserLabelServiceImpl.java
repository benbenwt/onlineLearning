package com.weitao.service.impl;

import com.weitao.dao.UserlabelMapper;
import com.weitao.domain.Userlabel;
import com.weitao.domain.UserlabelExample;
import com.weitao.service.UserLabelService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserLabelServiceImpl implements UserLabelService {
    @Autowired
    UserlabelMapper userlabelMapper;

    @Override
    public void addLabels(Integer uId, String[] labels) {
        Userlabel userlabel=new Userlabel();

        for(String label:labels)
        {
            userlabel.setUserid(uId);
            userlabel.setLabel(label);
            userlabelMapper.insert(userlabel);
        }

    }
}
