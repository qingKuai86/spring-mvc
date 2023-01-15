<%@ page import="com.Z09420121.domain.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>图书管理系统</title>
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="../css/home.css">
    <link rel="stylesheet" href="../plugins/elementui/index.css">
    <link rel="stylesheet" href="../plugins/font-awesome/css/font-awesome.min.css">

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
%>
<script>
    if(${alertType})
        alert("注册成功！")
</script>
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
        </div>
    </div>
    <!--头部第二行 搜索区域-->

</header>
<div id="app">

    <div class="content-header">

        <h1>后台图书管理</h1>

    </div>

    <div class="app-container">

        <div class="box">

            <div class="filter-container">

                <el-input placeholder="图书名称" v-model="searchInput" style="width: 200px;" class="filter-item"></el-input>

                <el-button @click="getAll()" class="dalfBut">查询</el-button>

                <el-button type="primary" class="butT" @click="handleCreate()">新建</el-button>

            </div>

            <el-table size="small" current-row-key="id" :data="dataList" stripe highlight-current-row>

                <el-table-column type="index" align="center" label="序号"></el-table-column>

                <el-table-column prop="type" label="图书类别" align="center"></el-table-column>

                <el-table-column prop="name" label="图书名称" align="center"></el-table-column>

                <el-table-column prop="description" label="描述" align="center"></el-table-column>

                <el-table-column label="操作" align="center">

                    <template slot-scope="scope">

                        <el-button type="primary" size="mini" @click="handleUpdate(scope.row)">编辑</el-button>

                        <el-button type="danger" size="mini" @click="handleDelete(scope.row)">删除</el-button>

                    </template>

                </el-table-column>

            </el-table>

            <!-- 新增标签弹层 -->

            <div class="add-form">

                <el-dialog title="新增图书" :visible.sync="dialogFormVisible">

                    <el-form ref="dataAddForm" :model="formData" :rules="rules" label-position="right" label-width="100px">

                        <el-row>

                            <el-col :span="12">

                                <el-form-item label="图书类别" prop="type">

                                    <el-input v-model="formData.type"/>

                                </el-form-item>

                            </el-col>

                            <el-col :span="12">

                                <el-form-item label="图书名称" prop="name">

                                    <el-input v-model="formData.name"/>

                                </el-form-item>

                            </el-col>

                        </el-row>


                        <el-row>

                            <el-col :span="24">

                                <el-form-item label="描述">

                                    <el-input v-model="formData.description" type="textarea"></el-input>

                                </el-form-item>

                            </el-col>

                        </el-row>

                    </el-form>

                    <div slot="footer" class="dialog-footer">

                        <el-button @click="dialogFormVisible = false">取消</el-button>

                        <el-button type="primary" @click="handleAdd()">确定</el-button>

                    </div>

                </el-dialog>

            </div>

            <!-- 编辑标签弹层 -->

            <div class="add-form">

                <el-dialog title="编辑检查项" :visible.sync="dialogFormVisible4Edit">

                    <el-form ref="dataEditForm" :model="formData" :rules="rules" label-position="right" label-width="100px">

                        <el-row>

                            <el-col :span="12">

                                <el-form-item label="图书类别" prop="type">

                                    <el-input v-model="formData.type"/>

                                </el-form-item>

                            </el-col>

                            <el-col :span="12">

                                <el-form-item label="图书名称" prop="name">

                                    <el-input v-model="formData.name"/>

                                </el-form-item>

                            </el-col>

                        </el-row>

                        <el-row>

                            <el-col :span="24">

                                <el-form-item label="描述">

                                    <el-input v-model="formData.description" type="textarea"></el-input>

                                </el-form-item>

                            </el-col>

                        </el-row>

                    </el-form>

                    <div slot="footer" class="dialog-footer">

                        <el-button @click="dialogFormVisible4Edit = false">取消</el-button>

                        <el-button type="primary" @click="handleEdit()">确定</el-button>

                    </div>

                </el-dialog>

            </div>

        </div>

    </div>

</div>
</body>

<script src="../js/component/vue.js"></script>
<script type="text/javascript" src="../js/component/jquery.min.js"></script>
<script src="../js/component/axios-0.18.0.js"></script>
<script src="../plugins/elementui/index.js"></script>

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
<script>
    var vue = new Vue({

        el: '#app',
        data:{
            searchInput:'',
            dataList: [],//当前页要展示的列表数据
            formData: {},//表单数据
            dialogFormVisible: false,//控制表单是否可见
            dialogFormVisible4Edit:false,//编辑表单是否可见
            rules: {//校验规则
                type: [{ required: true, message: '图书类别为必填项', trigger: 'blur' }],
                name: [{ required: true, message: '图书名称为必填项', trigger: 'blur' }]
            }
        },

        //钩子函数，VUE对象初始化完成后自动执行
        created() {
                this.getAll();
        },

        methods: {
            //列表
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

            //弹出添加窗口
            handleCreate() {
                this.dialogFormVisible = true;
                this.resetForm();
            },

            //重置表单
            resetForm() {
                this.formData = {};
            },

            //添加
            handleAdd () {
                //发送ajax请求
                axios.post("/books",this.formData).then((res)=>{
                    console.log(res.data);
                    //如果操作成功，关闭弹层，显示数据
                    if(res.data.code == 20011){
                        this.dialogFormVisible = false;
                        this.$message.success("添加成功");
                    }else if(res.data.code == 20010){
                        this.$message.error("添加失败");
                    }else{
                        this.$message.error(res.data.msg);
                    }
                }).finally(()=>{
                    this.getAll();
                });
            },

            //弹出编辑窗口
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

            //编辑
            handleEdit() {
                //发送ajax请求
                axios.put("/books",this.formData).then((res)=>{
                    //如果操作成功，关闭弹层，显示数据
                    if(res.data.code == 20031){
                        this.dialogFormVisible4Edit = false;
                        this.$message.success("修改成功");
                    }else if(res.data.code == 20030){
                        this.$message.error("修改失败");
                    }else{
                        this.$message.error(res.data.msg);
                    }
                }).finally(()=>{
                    this.getAll();
                });
            },

            // 删除
            handleDelete(row) {
                //1.弹出提示框
                this.$confirm("此操作永久删除当前数据，是否继续？","提示",{
                    type:'info'
                }).then(()=>{
                    //2.做删除业务
                    axios.delete("/books/"+row.id).then((res)=>{
                        if(res.data.code == 20021){
                            this.$message.success("删除成功");
                        }else{
                            this.$message.error("删除失败");
                        }
                    }).finally(()=>{
                        this.getAll();
                    });
                }).catch(()=>{
                    //3.取消删除
                    this.$message.info("取消删除操作");
                });
            }
        }
    })

</script>
</html>
