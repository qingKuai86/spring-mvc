package com.itheima.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

//定义表现层控制器bean
@Controller
public class UserController {

    //设置映射路径为/save，即外部访问路径
    @RequestMapping("/save")
    //设置当前操作返回结果为指定json数据（本质上是一个字符串信息）
    @ResponseBody
    public String save(){
        System.out.println("user save ...");
        return "{'info':'springmvc'}";
    }

    //设置映射路径为/delete，即外部访问路径
    @RequestMapping("/delete")
    @ResponseBody
    public String delete(){
        System.out.println("user delete ...");
        return "{'info':'springmvc'}";
    }
    @RequestMapping("/show1")
    public String test11(){
        return "show1.jsp";
    }
    @RequestMapping("/show2")
    public ModelAndView hello() {
        ModelAndView mv = new ModelAndView();
        mv.addObject("username","师姐");
        mv.setViewName("/WEB-INF/show2.jsp");
        return mv;
    }

    @RequestMapping("/rsm/t1")
    public String test1(){
        //转发
        return "/index.jsp";
    }

    @RequestMapping("/rsm/t2")
    public String test2(){
        //转发二
        return "forward:/index.jsp";
    }

    @RequestMapping("/rsm/t3")
    public String test3(){
        //重定向
        return "redirect:/index.jsp";
    }

}
