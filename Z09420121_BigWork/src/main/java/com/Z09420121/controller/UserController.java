package com.Z09420121.controller;

import com.Z09420121.domain.User;
import com.Z09420121.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    @RequestMapping("/check")
    public ModelAndView loginAction(User userR, HttpSession httpSession){
        ModelAndView mav = new ModelAndView();
        User user = userService.checkUser(userR);
        if(user==null) {
            mav.addObject("login_msg","账号或密码错误!");
            mav.setViewName("/pages/login");
            return mav;
        }
        httpSession.setAttribute("user",user);//传入session作用域
        //普通用户
        mav.setViewName("redirect:/");
        //管理员
        if (user.getIsRoot().equals("1")) {
            httpSession.setAttribute("root",user);//传入session作用域
            mav.setViewName("redirect:/root");//转发的页面名称
        }
        mav.addObject("user", user);//传入request作用域参数,重定向后session是拿不到的
        return mav;
    }
    @RequestMapping("/quit")
    public ModelAndView quitAction(HttpSession httpSession){
        ModelAndView mav = new ModelAndView();
        httpSession.setAttribute("user",null);//传入session作用域
        httpSession.setAttribute("root",null);//传入session作用域
        mav.setViewName("redirect:/");//跳转新的页面名称
        mav.addObject("user", null);//传入request作用域参数,重定向后session是拿不到的
        return mav;

    }

    @RequestMapping("/add")
    public ModelAndView registerAction(User user){
        ModelAndView mav = new ModelAndView();
        userService.insertUser(user);
        mav.addObject("alertType",1 );//是否弹窗标志
        //mav.setViewName("redirect:home.jsp");//跳转新的页面名称
        mav.setViewName("home.jsp");//跳转新的页面名称
        return mav;
    }
    @ResponseBody
    @RequestMapping("/checkAccount")
    public Result checkUserName(String account){
        boolean flag = (userService.getUserName(account)!=null);
        String msg="用户名可用";
        String msg_color ="green";
        if (flag==true) {
            msg = "用户名已存在！";
            msg_color = "#EC4141";
            return new Result(Code.GET_ERR, msg_color,msg);
        }
        else if (account.length()==0) {
            msg = "用户名不能为空";
            msg_color ="#EC4141";
            return new Result(Code.GET_ERR, msg_color,msg);
        } else if (account.length()<4||account.length()>8){
            msg = "用户名长度必须在4~8位！";
            msg_color ="#EC4141";
            return new Result(Code.GET_ERR, msg_color,msg);
        }
        return new Result(Code.GET_OK, msg_color,msg);
    }
    @ResponseBody
    @RequestMapping("/checkPassword")
    public Result checkPassword(String password1,String password2){

        String msg = "两次输入不一致";
        String msg_color ="#EC4141";
        if(password2==null)
            return new Result(Code.GET_ERR, msg_color,msg);
        else if(password2.equals(password1)==false)
            return new Result(Code.GET_ERR, msg_color,msg);
        else {
            msg = "密码一致";
            msg_color = "green";
        }
        return new Result(Code.GET_OK, msg_color,msg);
    }

    @ResponseBody
    @RequestMapping("/getName")
    public Result getName(HttpSession httpSession){
        String msg = "";
        User user = (User) httpSession.getAttribute("user");
        if (user!=null) {
            msg = user.getUsername();
            return new Result(Code.GET_OK, msg, msg);
        }
        return new Result(Code.GET_ERR, msg, msg);
    }

}
