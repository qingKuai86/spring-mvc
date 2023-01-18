package com.Z09420121.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class IndexController {

    @RequestMapping
    public String showUserIndex(){
        System.out.println(1);
        return "/home.jsp";
    }

    //访问WEB-INF下的资源，重定向会找不到，而转发才可以
    @RequestMapping("/root")
    public String showRootIndex(){
        return "/WEB-INF/root_home.jsp";
    }//默认是转发
}
