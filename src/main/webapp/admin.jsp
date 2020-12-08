<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <meta charset="utf-8">
  <title>后台管理</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

  <link rel="stylesheet" href="/css/layui.css"  media="all">

</head>
<body>

<ul class="layui-nav">
    <li class="layui-nav-item ">在线学习平台后台管理</li>
    <!--<li class="layui-nav-item ">
        <a href="javascript:;">欢迎登录！</a>
        <dl class="layui-nav-child">
          <dd><a href="">用户管理</a></dd>
          <dd><a href="">课程管理</a></dd>
          <dd><a href="">注销</a></dd>
        </dl>
    </li>--!>
</ul>

<div class="layui-container">
    <div class="layui-row"> <div class="layui-col-md4 layui-col-md-offset5" style="margin-top:100"><h1>管理员登录</h1></div></div>
    <div class="layui-row" style="margin-top:50">
        <div class="layui-col-md4 layui-col-md-offset4">
            <form class="layui-form" action="" lay-filter="example">
              <div class="layui-form-item">
                <label class="layui-form-label">账号</label>
                <div class="layui-input-inline">
                  <input type="text" name="username" lay-verify="title" autocomplete="off" placeholder="请输入账号" class="layui-input">
                </div>
              </div>
              <div class="layui-form-item">
                <label class="layui-form-label">密码</label>
                <div class="layui-input-inline">
                  <input type="password" name="password" placeholder="请输入密码" autocomplete="off" class="layui-input">
                </div>
              </div>
              <div class="layui-form-item"style="padding-left:235">
                  <button id="submit_btn" class="layui-btn">提交</button>
              </div>
            </form>
        </div>

    </div>
</div>



<script src="/js/layui.js" charset="utf-8"></script>
<script src="/js/layui.all.js" charset="utf-8"></script>

<script>

layui.use(['layer', 'form', 'element'], function(){
  var layer = layui.layer;
  var form = layui.form;
  var element = layui.element;
  var $ = layui.jquery;

   $(document).on("click","#submit_btn",function(){
       $.ajax({
           url:"/adminLogin",
           data:{"username":$("input[name='username']").prop("value"),"password":$("input[name='password']").prop("value")},
           type:"POST",
           dataType:"json",
           success:function(result)
           {
                alert("登录成功");
                location.href="/manageUser"
           }
       });
       return false;
   });

});

</script>

</body>
</html>