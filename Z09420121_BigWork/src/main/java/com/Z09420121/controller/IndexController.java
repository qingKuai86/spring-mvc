package com.Z09420121.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class IndexController {

    @RequestMapping
    public String showUserIndex(){
        System.out.println(1);
        return "home.jsp";
    }
    @RequestMapping("/root")
    public String showRootIndex(){
        return "WEB-INF/root_home.jsp";
    }
}
