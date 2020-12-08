package com.weitao.service;

import com.weitao.domain.Usercourse;

public interface UserCourseService {
     void subscribe(Usercourse usercourse);
     boolean isSubscribe(Integer uid,Integer cid);
     boolean unSubscribe(Integer cid);
}
