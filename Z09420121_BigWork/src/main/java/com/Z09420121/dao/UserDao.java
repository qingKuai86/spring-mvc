package com.Z09420121.dao;

import com.Z09420121.domain.User;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

public interface UserDao {
    //太坑了，sql写错了居然不报错的，自己要多注意点括号之类的，现在没问题了
    @Insert("insert into t_user (username,password,isRoot) values(#{username},#{password},#{isRoot})")
    public int save(User user);

    @Update("update t_user set username = #{username}, password = #{password} where username = #{username}")
    public int update(User user);

    @Delete("delete from t_user where username = #{username}")
    public int delete(String username);

    @Select("select * from t_user where username = #{username}")
    public User getByName(String username);

    @Select("select * from t_user where username = #{username} and password = #{password}")
    //@Select("select * from t_user where username = #{username}")
    public User getByNameAndPassword(User user);

    @Select("select * from t_user")
    public List<User> getAll();
}
