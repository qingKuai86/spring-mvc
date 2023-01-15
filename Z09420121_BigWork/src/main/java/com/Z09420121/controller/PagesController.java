package com.Z09420121.controller;

import com.Z09420121.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/pages")
public class PagesController {
    @Autowired
    private UserService userService;
    /*经测试：同一个方法上同时应用@GetMapping和@PostMapping只能生效一个*/

    @GetMapping("/login")
    public String toLogin(){
        return "login.jsp";
    }
    @PostMapping("/login")
    public String toLogin2(){
        return "login.jsp";
    }
    @GetMapping("/register")
    public String toRegitser(){
        return "register.jsp";
    }

}
