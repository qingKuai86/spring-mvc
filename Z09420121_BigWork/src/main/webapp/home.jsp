<%@ page import="com.Z09420121.domain.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>图书管理系统</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/home.css">
    <link rel="stylesheet" href="plugins/elementui/index.css">
    <link rel="stylesheet" href="plugins/font-awesome/css/font-awesome.min.css">

</head>
<body>
<%
    String img = "images/headerPic/";
    User user = (User) request.getSession().getAttribute("user");
    String username = "";
    if (user!=null) {
        username = user.getUsername();
        img = img + user.getImg();
    }
    else {
        img = img + "default.jpg";
    }
    //String warn = (String) request.getAttribute("warning");
    String warn = (String) request.getParameter("warn");
%>
<script>
    if(${alertType})
        alert("注册成功！")

</script>
<script>
    if(<%=warn!=null%>)
        alert("抱歉，您不是管理员!")
</script>
<div id="toppest">
    <header class="header">
        <!-- 头部的第一行 -->
        <div class="top">
            <div class="container">
                <div class="loginList">
                    <p><span style="border-left:thick double #ff0000;font-size: 24px;color: black"><a style="color: white" href="/" >首页</a></span></p>
                    <p v-show="<%=username==""%>">
                        <%--<span>请</span>--%>
                        <a href="/pages/register" class="register" >注册</a>
                        <a href="/pages/login" >登录</a>
                    </p>
                    <span>
                      <img
                              class="user-img"
                              src="<%=img%>"
                              alt=""
                      />
                      <span><%=username%></span>
                </span>
                    <p v-show="<%=username!=""%>" style="font-size: 12px">
                        <a href="/quit" class="register" >退出</a>
                    </p>

                </div>
                <div class="typeList">
                    <a href="javascript:void(0);" @click="showOrder()">我的预订</a>
                </div>
            </div>
        </div>
        <!--头部第二行 搜索区域-->

    </header>
    <div id="app">

        <div class="content-header">

            <h1 v-show="showMyOrder1">图书馆藏</h1>
            <h1 v-show="showMyOrder2" style="color: #3a8ee6">我的预订</h1>

        </div>

        <div class="app-container">

            <div class="box">

                <div class="filter-container">

                    <el-input placeholder="图书名称" v-model="searchInput" style="width: 200px;" class="filter-item"></el-input>

                    <el-button @click="getAll()" class="dalfBut">查询</el-button>


                </div>

                <el-table size="small" current-row-key="id" :data="dataList" stripe highlight-current-row>

                    <el-table-column type="index" align="center" label="序号"></el-table-column>

                    <el-table-column prop="type" label="图书类别" align="center"></el-table-column>

                    <el-table-column prop="name" label="图书名称" align="center"></el-table-column>

                    <el-table-column prop="description" label="描述" align="center"></el-table-column>

                    <el-table-column label="操作" align="center">

                        <template slot-scope="scope">

                            <el-button type="primary" size="mini" @click="handleUpdate(scope.row)">查看</el-button>

                            <el-button v-show="showMyOrder1" type="danger" size="mini" @click="handleBooking(scope.row)">预订</el-button>

                            <el-button v-show="showMyOrder2" type="danger" size="mini" @click="handleDeleteBooking(scope.row)">取消预订</el-button>

                        </template>

                    </el-table-column>

                </el-table>


                <!-- 查看图书内容标签弹层 -->

                <div class="add-form">

                    <el-dialog title="查看图书内容" :visible.sync="dialogFormVisible4Edit">

                        <el-form ref="dataEditForm" :model="formData" :rules="rules" label-position="right" label-width="100px">

                            <el-row>

                                <el-col :span="12">

                                    <el-form-item label="图书类别" prop="type">

                                        <el-input v-model="formData.type" readonly/>

                                    </el-form-item>

                                </el-col>

                                <el-col :span="12">

                                    <el-form-item label="图书名称" prop="name">

                                        <el-input v-model="formData.name" readonly/>

                                    </el-form-item>

                                </el-col>

                            </el-row>

                            <el-row>

                                <el-col :span="24">

                                    <el-form-item label="描述">

                                        <el-input v-model="formData.description" type="textarea" readonly></el-input>

                                    </el-form-item>

                                </el-col>

                            </el-row>

                        </el-form>

                        <div slot="footer" class="dialog-footer">

                            <el-button @click="dialogFormVisible4Edit = false">退出查看</el-button>

                        </div>

                    </el-dialog>

                </div>

            </div>

        </div>

    </div>
</div>
</body>

<script src="js/component/vue.js"></script>
<script type="text/javascript" src="js/component/jquery.min.js"></script>
<script src="js/component/axios-0.18.0.js"></script>
<script src="plugins/elementui/index.js"></script>

<script>
    var vue = new Vue({

        el: '#toppest',
        data:{
            showMyOrder1:true,
            showMyOrder2:false,
            isLogin:false,
            bookingUsername:'',
            searchInput:'',
            dataList: [],//当前页要展示的列表数据
            formData: {},//表单数据
            dialogFormVisible4Edit:false,//查看表单是否可见
            rules: {//校验规则
                type: [{ required: true, message: '图书类别为必填项', trigger: 'blur' }],
                name: [{ required: true, message: '图书名称为必填项', trigger: 'blur' }]
            }
        },

        //钩子函数，VUE对象初始化完成后自动执行
        created() {
            axios.get("/getName").then((res)=>{
                this.bookingUsername = res.data.data
            }).finally(() => {
                this.getAll();
            });
        },

        methods: {
            //列表
            getAll() {
                console.log(this.searchInput);
                axios.get("/books", { params: {
                        value: this.searchInput
                    }}).then((res)=>{
                    console.log(res.data);

                    if(res.data.code == 20041){
                        this.dataList = res.data.data;
                    }else{
                        this.dataList = {};
                    }
                });
            },

            //弹出查看窗口
            handleUpdate(row) {
                // console.log(row);   //row.id 查询条件
                //查询数据，根据id查询
                axios.get("/books/"+row.id).then((res)=>{
                    // console.log(res.data.data);
                    if(res.data.code == 20041){
                        //展示弹层，加载数据
                        this.formData = res.data.data;
                        this.dialogFormVisible4Edit = true;
                    }else{
                        this.$message.error(res.data.msg);
                    }
                });
            },

            // 预订
            handleBooking(row) {
                if(this.bookingUsername!='') {
                    //1.弹出提示框
                    this.$confirm("确认预订？", "提示", {
                        type: 'info'
                    }).then(() => {
                        axios.get("/books/booking", { params: {
                                username: this.bookingUsername,
                                id: row.id,

                            }}).then((res)=>{
                            if (res.data.code == 20011) {
                                this.$message.success("预订成功");
                            } else {
                                this.$message.error("您之前预订过这本书了");
                            }
                        }).finally(() => {
                            this.getAll();
                        });
                    }).catch(() => {
                        this.$message.info("取消预订操作");
                    });
                }else {
                    this.$message.error("您还没有登录！");
                }
            },

            //取消预订
            handleDeleteBooking(row) {
                //1.弹出提示框
                this.$confirm("此操作取消预订当前书本，是否继续？","提示",{
                    type:'info'
                }).then(()=>{
                    //2.做业务
                    console.log(this.bookingUsername+" : "+row.id)
                    axios.get("/books/deleteBooking",{ params: {
                            username: this.bookingUsername,
                            id: row.id,

                        }}).then((res)=>{
                        if(res.data.code == 20021){
                            this.$message.success("取消预订成功");
                        }else{
                            this.$message.error("取消预订失败");
                        }
                    }).finally(()=>{
                        this.getMyAll();
                    });
                }).catch(()=>{
                    //3.取消预订操作
                    this.$message.info("取消预订操作");
                });
            },
            showOrder(){
                if(this.bookingUsername!='') {
                    this.showMyOrder1 = !this.showMyOrder1
                    this.showMyOrder2 = !this.showMyOrder2
                    if (this.showMyOrder1)
                        this.getAll()
                    else
                        this.getMyAll()
                }
                else {
                    this.$message.error("您还没有登录！");
                }
            },
            getMyAll(){
                axios.get("/books/getMyAll", { params: {
                        username: this.bookingUsername
                    }}).then((res)=>{
                    console.log("getmyall:"+res.data);
                    if(res.data.code == 20041){
                        this.dataList = res.data.data;
                    }else{
                        this.dataList = {};
                    }
                });
            }

        }
    })

</script>
</html>
