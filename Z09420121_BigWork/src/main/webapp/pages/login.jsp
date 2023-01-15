<%@ page import="com.Z09420121.domain.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="GBK">
    <title>图书管理系统--登录</title>
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" type="text/css" href="../css/home.css">
    <link rel="stylesheet" type="text/css" href="../css/login.css">
</head>
<body>
<%
    String img = "../images/headerPic/";
    User user = (User) request.getSession().getAttribute("user");
    String username = "";
    if (user!=null) {
        username = user.getUsername();
        img = img + user.getImg();
    }
    else {
        img = img + "default.jpg";
    }

%>
<h1>${address}</h1>
<header class="header">
    <!-- 头部的第一行 -->
    <div class="top">
        <div class="container">
            <div class="loginList">
                <p><span style="border-left:thick double #ff0000;font-size: 24px;color: black"><a style="color: white" href="/" >首页</a></span></p>

                <p v-show="<%=username==""%>">
                    <%--<span>请</span>--%>
                    <a href="/pages/register" class="register" >注册</a>
                    <a href="javascript:void(0);" >登录</a>
                </p>
                <p v-show="<%=username!=""%>">
                    <a href="/pages/register" class="register" >注册</a>
                </p>
            </div>
        </div>
    </div>
</header>

<div id="container">
    <div id="container_sub">
        <div id="Login">
            <form action="/check" method="post" id="form">
                <h1 id="LoginMsg" style="background: linear-gradient(to right, red, black, red, black, red, black, red, black,red, black, yellow, black, red);
                -webkit-background-clip: text;/*背景颜色以文本方式剪切*/
                -webkit-text-fill-color: transparent;/*文字填充为透明色让设置的渐变色显示出来，一定要设置为透明色不然设置的渐变色无法显示出来，会被遮挡住*/ margin-left: 100px">登录界面</h1>
                <div id="errorMsg" style="color: red;margin-left: 100px;height: 30px;width: 150px">${login_msg}</div>
                <p>用户名:<input value="${cookie.u_username.value}" id="username" type="text" name="username" placeholder="请输入用户名"></p>
                <p>密&nbsp;&nbsp;&nbsp;码:<input value="${cookie.u_password.value}" id="password" type="password" name="password"placeholder="请输入密码"></p>
                <p>记住密码:<input id="remember" type="checkbox" name="remember" value="1"></p>
                <div id="Register">
                    <input type="submit" value="登录" style="width: 165px">
                    <a href="/pages/register">注册</a>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
<script src="../js/component/vue.js"></script>
<script type="text/javascript" src="../js/component/jquery.min.js"></script>
<script src="../js/component/axios-0.18.0.js"></script>
<script>
    new Vue({
        el:'.top',
        data(){
            return{
                isLogin:false,
                inputMessage:''
            }
        },
        methods:{
        }

    });
</script>
</html>
