package com.Z09420121.service.impl;



import com.Z09420121.dao.UserDao;
import com.Z09420121.domain.User;
import com.Z09420121.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserDao userDao;

    @Override
    public User checkUser(User user) {
        return userDao.getByNameAndPassword(user);
    }

    @Override
    public User getUserName(String username) {
        return userDao.getByName(username);
    }

    @Override
    public boolean insertUser(User user) {
        return userDao.save(user)>=1;
    }
}
