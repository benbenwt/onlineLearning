package com.weitao.service;

import com.weitao.domain.Msg;
import com.weitao.domain.Userinf;

import java.util.List;

public interface UserService {
     Msg login(String username, String password);
     Userinf userInfo(String username,String password);
     void setUserActive(Integer uId);
     List<Userinf> getAllUser(Integer pageNum);
     void deleteUser(Integer uid);
     void register(String username,String password,String nickname,String major,String image);
     void updateUser(Integer uid,String nickname,String major);
     boolean updatePassword(Integer uid,String oldPassword,String newPassword);
     void updateImage(Integer id,String image);
     boolean isUsernameRepeat(String username);
}
