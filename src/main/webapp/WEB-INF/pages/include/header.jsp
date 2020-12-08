<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>${sessionScope.title}</title>
     <link href="/css/bootstrap.min.css" rel="stylesheet">
     <script type="text/javascript" src="/js/jquery.min.js"></script>
     <script src="/js/bootstrap.min.js"></script>
     <script src="/js/jquery.validate.min.js"></script>
     <style>
        .course_title{
            font-size:40px;
        }
        .course_inf{
            background-color:#DDDDDD;
            font-size:15
        }

        .filter_ul{
            list-style:none;

        }
        .filter_ul li{
            float:left;
          margin-left:40;
        }
        .normal_ul{
            list-style:none;
       }

     </style>
</head>
<body>
<div id="container" class="container">
<!-- 头部导航栏 -->
    <div class="row">
       <nav class="nav navbar-default">
            <div class="col-md-9">
                <ul class="nav navbar-nav">
                  <li><a href="/course" >课程广场</a> </li>

                </ul>
            </div>

            <div class="col-md-3">
                <ul class="nav navbar-nav">
                    <c:if test="${sessionScope.username!=null}">
                        <li role="presentation" class="dropdown">
                            <a class="dropdown-toggle" data-toggle="dropdown">
                                  ${sessionScope.username}已登录 <span class="caret"></span>
                                </a>
                            <ul class="dropdown-menu">
                              <li> <a href="/recommend">个性推荐</a></li>
                              <li> <a href="/userCenter?username=${sessionScope.username}&password=${sessionScope.password}">个人中心</a></li>
                              <li><a href="/logout">注销</a></li>
                            </ul>

                        </li>

                    </c:if>
                    <c:if test="${sessionScope.username==null}">
                        <li ><a data-toggle="modal" data-target="#myModal">登录</a></li>
                    </c:if>

                    <li><a data-toggle="modal" data-target="#signup_modal">注册</a></li>
                </ul>

            </div>
       </nav>
    </div>

    <!--登录模态框--!>
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
          <div class="modal-dialog" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">登录</h4>
              </div>
              <div class="modal-body">
                    <form class="form-horizontal" id="signin_form">
                                  <div class="form-group">
                                    <label for="name" class="col-sm-2 control-label">账号</label>
                                    <div class="col-sm-10">
                                      <input type="text" class="form-control" id="name" placeholder="账号必须为6-16位字符" name="name">
                                      <span id="name_helpBlock" class="help-block"></span>
                                    </div>
                                  </div>
                                  <div class="form-group">
                                    <label for="password1" class="col-sm-2 control-label">密码</label>
                                    <div class="col-sm-10">
                                      <input type="password" class="form-control" id="password1" placeholder="密码" name="password1">
                                          <span id="password_helpBlock" class="help-block"></span>
                                    </div>
                                  </div>
                    </form>

              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="signin_btn">登录</button>
              </div>
            </div>
          </div>
        </div>
    <!--注册模态框--!>
    <div class="modal fade" id="signup_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title" id="myModalLabel">注册</h4>
          </div>
          <div class="modal-body">
                <form class="form-horizontal" id="register_form">
                  <div class="form-group">
                    <label for="username" class="col-sm-2 control-label">账号</label>
                    <div class="col-sm-10">
                      <input type="text" class="form-control" id="username" placeholder="账号必须为6-16位字符" name="username">
                      <span id="username_helpBlock" class="help-block"></span>
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="password" class="col-sm-2 control-label">密码</label>
                    <div class="col-sm-10">
                      <input type="password" class="form-control" id="password" placeholder="密码" name="password">
                      <span id="password_helpBlock" class="help-block"></span>
                    </div>
                  </div>
                   <div class="form-group">
                      <label for="nickname" class="col-sm-2 control-label">昵称</label>
                      <div class="col-sm-10">
                        <input type="text" class="form-control" id="nickname" placeholder="昵称" name="nickname">
                            <span id="nickname_helpBlock" class="help-block"></span>
                      </div>
                    </div>
                    <div class="form-group">
                      <label for="major" class="col-sm-2 control-label">主修</label>
                      <div class="col-sm-10">
                        <input type="text" class="form-control" id="major" placeholder="主修" name="major">
                            <span id="major_helpBlock" class="help-block"></span>
                      </div>
                    </div>
                    <input type="file" id="multipartFile" name="multipartFile">
                </form>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            <button type="button" class="btn btn-primary" id="register_btn">注册</button>
          </div>
        </div>
      </div>
    </div>
<script>

   $(document).on("click","#signin_btn",function(){

        $.ajax({
            url:"/login",
            data:{"username":$("#name").val(),"password":$("#password1").val()},
            type:"POST",
            dataType:"json",
            success:function(result){
                alert(result.extend.inf);
                if(result.extend.active==0)
                {
                    location.href="/userLabel";
                }
                else if(result.extend.active==1){
                    location.href="/index.jsp";
                }
            }
        });
   });

   $(document).on("click","#register_btn",function(){
        var formData=new FormData();
        formData.append("username",$("#username").val());
        formData.append("password",$("#password").val());
        formData.append("nickname",$("#nickname").val());
        formData.append("major",$("#major").val());
        formData.append("multipartFile",$("#multipartFile")[0].files[0]);
        $.ajax({
            url:"/register",
            data:formData,
            type:"POST",
            dataType:"json",
            contentType:false,
            processData:false,
            success:function(result){
                alert(result.extend.inf);
                if(result.code==100)
                {
                    location.href="/index.jsp";
                }
                else if(result.code==200){
                    $("#username").prop("value","");
                    $("#password").prop("value","");
                    $("#nickname").prop("value","");
                    $("#major").prop("value","");
                    $("#multipartFile").prop("value","");

                }

            }
        });

   });

    $(document).ready(function(){
        jQuery.validator.addMethod("checkInput", function(value, element) {
            var pattern = new RegExp("[.`~!@#$^&*=|{}':;',\\[\\]<>《》/?~！@#￥……&*|{}【】‘；：”“'。，、？' ']");
            var reg = /^([0-9]+)$/;
            if(pattern.test(value)) {
                return false;
            } else if(value.indexOf(" ") != -1){
                return false;
            } else {
                return true;
            }
        }, "禁止输入特殊字符及空格");

        jQuery.validator.addMethod("checkInput2", function(value, element) {

            var deferred=$.Deferred();
            $.ajax({
                url:"/isUsernameRepeat",
                data:{"username":value},
                type:"POST",
                dataType:"json",
                 async:false,
                success:function(result){
                    if(result==true)
                    {
                        deferred.reject();
                    }
                    else if(result==false)
                    {
                        deferred.resolve();
                    }
                }
            });
            return deferred.state() == "resolved" ? true : false;
        }, "禁止输入特殊字符及空格");


        $("#signin_form").validate({
            rules:{
                name:{
                required:true,
                rangelength:[6,10],
                 checkInput:true
                },
                password1:{
                 required:true,
                 rangelength:[6,10]

                }
            },
            messages:{
                name:{
                    required:"用户名不为空",
                    rangelength:"用户名为6至16位",
                    checkInput:"禁止输入特殊字符及空格"
                },
                 password1:{
                         required:"密码不为空",
                         rangelength:"密码为6至10位"
                        }
            }
        });

        $("#register_form").validate({
            rules:{
                username:{
                required:true,
                rangelength:[6,10],
                 checkInput:true,
                 checkInput2:true
                },
                password:{
                 required:true,
                 rangelength:[6,10]

                }
            },
            messages:{
                username:{
                    required:"用户名不为空",
                    rangelength:"用户名为6至16位",
                    checkInput:"禁止输入特殊字符及空格",
                    checkInput2:"账号已存在"
                },
                 password:{
                         required:"密码不为空",
                         rangelength:"密码为6至10位"
                        }
            }
        });
    });

</script>