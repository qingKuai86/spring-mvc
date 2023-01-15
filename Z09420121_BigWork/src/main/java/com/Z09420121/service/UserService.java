package com.Z09420121.service;



import com.Z09420121.domain.User;
import org.springframework.transaction.annotation.Transactional;

@Transactional
public interface UserService{
    //通过用户名和密码获取用户信息
    public User checkUser(User user);

    public User getUserName(String username);

    public boolean insertUser(User user);
}
