package com.Z09420121.config;

import org.springframework.context.annotation.*;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@Configuration
@ComponentScan({"com.Z09420121.service"})//扫描包，service层交由spring容器管理
@PropertySource("classpath:jdbc.properties")//加载jdbc配置文件
@Import({JdbcConfig.class,MyBatisConfig.class})

@EnableTransactionManagement            //开启事务管理器
public class SpringConfig {
}
