package com.itheima.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TestController {

    @RequestMapping()
    public String homeAction(){
        System.out.println(1);
        return "/show1.jsp";
    }
}
