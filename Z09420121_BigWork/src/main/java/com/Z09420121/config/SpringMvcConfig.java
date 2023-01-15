package com.Z09420121.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

@Configuration
@ComponentScan({"com.Z09420121.controller","com.Z09420121.config"})
@EnableWebMvc //用于启用 Spring MVC
public class SpringMvcConfig {
}
