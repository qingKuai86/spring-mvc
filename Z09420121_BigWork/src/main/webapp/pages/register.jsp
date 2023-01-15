<%@ page import="com.Z09420121.domain.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>图书管理系统--注册</title>
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" type="text/css" href="../css/home.css">
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
<div id="box">
    <header class="header">
        <!-- 头部的第一行 -->
        <div class="top">
            <div class="container">
                <div class="loginList">
                    <p><span style="border-left:thick double #ff0000;font-size: 24px;color: black"><a style="color: white" href="/" >首页</a></span></p>

                    <p v-show="<%=username==""%>">
                        <%--<span>请</span>--%>
                        <a href="javascript:void(0);" class="register" >注册</a>
                        <a href="/pages/login" >登录</a>
                    </p>
                    <p v-show="<%=username!=""%>">
                        <a href="/pages/register" class="register" >注册</a>
                    </p>
                </div>
            </div>
        </div>
    </header>

    <div class="container-top">
    <div id="OpenButton"><!--这里有isOK检查-->
        <form @mousemove="isOK()" ref="myForm" action="/add">
            <h1 id="LoginMsg" style="color: whitesmoke">用户注册</h1>
            <p>
                帐号：<input type="text" id="username" name="username" @change="checkUserName()" v-model="account" placeholder="请输入用户名"/>
                <label id="tipsLabel1" v-bind:style="{ color: msg_color }">{{msg}}</label>
            </p>
            <p>密码：<input type="password" name="password" v-model="password1" placeholder="请输入密码"/></p>
            <p>确认密码：<input type="password" @change="checkPasswordAgain()" v-model="password2" placeholder="请再次输入密码"/>
                <label id="tipsLabel2" v-bind:style="{ color: msg_color2 }">{{msg2}}</label>
            <p><input type="button" id="registerButton" value="提交注册" @click="toAdd()" :disabled="disable"/></p><!--这里也有isOK检查，防止极端情况出现-->
        </form>
    </div>
    </div>

</div>
</body>
<script src="../js/component/vue.js"></script>
<script src="../js/component/axios-0.18.0.js"></script>
<script>
    new Vue({
        el:'#box',
        data(){
            return{
                account:'',
                password1:'',
                password2:'',
                msg:'',
                msg_color:'',
                msg2:'',
                msg_color2:'',
                disable:true
            }
        },
        methods:{
            checkUserName(){
                axios.get("/checkAccount", { params: {
                        account: this.account
                    }}).then((res)=>{
                    if(res.data.code == 20041){
                        console.log(res.data);
                        this.msg = res.data.msg
                        this.msg_color = res.data.data
                    }else{
                        this.msg = res.data.msg
                        this.msg_color = res.data.data
                    }
                });
            },
            checkPasswordAgain(){
                console.log(this.password1+":"+this.password2)
                axios.get("/checkPassword", { params: {
                        password1: this.password1,
                        password2: this.password2
                    }}).then((res)=>{
                    if(res.data.code == 20041){
                        this.msg2 = res.data.msg
                        this.msg_color2 = res.data.data
                    }else{
                        this.msg2 = res.data.msg
                        this.msg_color2 = res.data.data
                    }
                });
            },
            isOK(){
                if(this.msg_color=='green'&&this.msg_color2=='green')
                    this.disable = false
                else
                    this.disable = true
            },
            toAdd(){
                this.$refs.myForm.submit();
            }
        }
    })
</script>
<style type="text/css">

    .container-top{
        height: 100%;
        width: 100%;
        background: url("../images/background3.jpg") no-repeat;
        background-size: 100% 100%;
        border: 1px white solid;
        margin: 5px auto;

    }
    #OpenButton{
        position: relative;
        left: 37.5%;
        top: 100px;
        width: 450px;
        height: 300px;
        border: white solid 1px;
        background-color: cadetblue;
        font-weight: bolder;
    }
    #OpenButton p {
        margin-top: 30px;
        margin-left: 20px;
    }
    #LoginMsg{
        width: 200px;
        margin: 0px auto;
    }
</style>
</html>