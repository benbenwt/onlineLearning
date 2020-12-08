<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="title" value="个人中心" scope="session"/>
<%@ include file="/WEB-INF/pages/include/header.jsp"%>
  <!--修改个人信息模态框--!>
     <div class="modal fade" id="updateUserinf_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
       <div class="modal-dialog" role="document">
         <div class="modal-content">
           <div class="modal-header">
             <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
             <h4 class="modal-title" id="myModalLabel">修改个人信息</h4>
           </div>
           <div class="modal-body">
                 <form class="form-horizontal" id="register_form">
                    <div class="form-group">
                       <label for="nickname1" class="col-sm-2 control-label">昵称</label>
                       <div class="col-sm-10">
                         <input type="text" class="form-control" id="nickname1" placeholder="昵称" name="nickname1">
                       </div>
                     </div>
                     <div class="form-group">
                       <label for="major1" class="col-sm-2 control-label">主修</label>
                       <div class="col-sm-10">
                         <input type="text" class="form-control" id="major1" placeholder="主修" name="major1">
                       </div>
                     </div>
                 </form>
           </div>
           <div class="modal-footer">
             <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
             <button type="button" class="btn btn-primary" id="updateUser_btn">修改</button>
           </div>
         </div>
       </div>
     </div>


    <!--修改我的密码--!>
         <div class="modal fade" id="updatePassword_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
           <div class="modal-dialog" role="document">
             <div class="modal-content">
               <div class="modal-header">
                 <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                 <h4 class="modal-title" id="myModalLabel">修改我的密码</h4>
               </div>
               <div class="modal-body">
                     <form class="form-horizontal" id="register_form">
                        <div class="form-group">
                           <label for="oldPassword" class="col-sm-2 control-label">旧密码</label>
                           <div class="col-sm-10">
                             <input type="text" class="form-control" id="oldPassword" placeholder="旧密码" name="oldPassword">
                                 <span id="nickname_helpBlock" class="help-block"></span>
                           </div>
                         </div>
                         <div class="form-group">
                           <label for="newPassword" class="col-sm-2 control-label">新密码</label>
                           <div class="col-sm-10">
                             <input type="text" class="form-control" id="newPassword" placeholder="新密码" name="newPassword">
                                 <span id="major_helpBlock" class="help-block"></span>
                           </div>
                         </div>
                     </form>
               </div>
               <div class="modal-footer">
                 <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                 <button type="button" class="btn btn-primary" id="updatePassword_btn">修改</button>
               </div>
             </div>
           </div>
         </div>

 <br>
    <div class="row">
        <div class="col-md-1">
            <img src="${requestScope.userinf.image}" alt="图片" width="100" height="100">
            <button id="update-image" class="btn btn-default btn-sm">编辑头像</button>
        </div>
        <div class="col-md-5">
            <ul class="normal_ul">
                <li>用户ID：${requestScope.userinf.id}</li>
                <li>用户名：${requestScope.userinf.username}</li>
                <li>昵称：${requestScope.userinf.nickname}</li>
                <li><span>主修：</span>${requestScope.userinf.major}</li>

            </ul>

        </div>
        <div class="col-md-4">
            <ul class="normal_ul">
                <li><button class="btn  btn-primary btn-sm" data-toggle="modal" data-target="#updateUserinf_modal">修改个人信息</button></li><br>
                <li><button class="btn  btn-success btn-sm" data-toggle="modal" data-target="#updatePassword_modal">修改我的密码</button></li>
            </ul>
        </div>
    </div>
    <hr/>
    <h3>我的课程</h3>
    <div id="myCourse">

    </div>
    <div id="navigate">

    </div>

</div>

<script>
    $(document).ready(function(){
        to_page(1);
    });
    function to_page(pageNum){
        $.ajax({
            url:"/myCourse",
            data:{"pageNum":pageNum,"uid":${userinf.id}},
            type:"POST",
            dataType:"json",
            success:function(result){
                $("#myCourse").empty();
                $("#navigate").empty();
                build_myCourse(result.list);
                build_navigate(result);
            }
        });
    }
    function build_myCourse(list)
    {
        var  row=$("<div></div>").addClass("row");
        $.each(list,function(index,item){
             var image=$("<img>").attr("src",item.image).attr("alt","图片").attr("width",100).attr("height",100);
             var link=$("<a></a>").attr("href","/singleCourse?id="+item.id).append(image);
             var name=$("<h5></h5>").append(item.name);
             var category=$("<h5></h5>").append(item.category);

             var col=$("<div></div>").addClass("col-md-3").append(link).append(name).append(category);
             row.append(col);

            if((index==list.length-1)&&index%4!=3)
            {
                $("#myCourse").append(row);
            }
            if(index%4==3){
                 $("#myCourse").append(row);
                 row=$("<div></div>").addClass("row");

            }
        })
    }

    function build_navigate(pageinfo)
    {
         var inf=$("<p></p>").text("共"+pageinfo.pages+"页");
         var div1=$("<div></div>").css("height","100").css("width","450").css("float","left").append(inf);

         var prePageLi=$("<li></li>").append($("<a></a>").append("&laquo;")).click(function(){to_page(pageinfo.prePage)});
         var nextPageLi=$("<li></li>").append($("<a></a>").append("&raquo;"));

         var firstPageLi=$("<li></li>").append($("<a></a>").append("首页")).click(function(){to_page(1)});
          var lastPageLi=$("<li></li>").append($("<a></a>").append("尾页")).click(function(){to_page(pageinfo.pages)});;

        if(pageinfo.hasPreviousPage==false)
        {
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }

         var ul=$("<ul></ul>").addClass("pagination").append(firstPageLi).append(prePageLi);
         $.each(pageinfo.navigatepageNums,function(index,item){

            var li=$("<li></li>").append($("<a></a>").append(item)).click(function(){to_page(item)});
            if(item==pageinfo.pageNum)
            {
                li.addClass("active");
            }
            ul.append(li);
         });
         if(pageinfo.hasNextPage==false)
         {

             nextPageLi.addClass("disabled");
             lastPageLi.addClass("disabled");
         }
         if(pageinfo.hasNextPage==true)
         {
            nextPageLi.click(function(){to_page(pageinfo.nextPage)});
         }
         ul.append(nextPageLi);
         ul.append(lastPageLi);


         var div2=$("<div></div>").css("height","100").css("width","450").css("float","left").append(ul);
          var div=$("<div></div>").css("height","100").css("width","900").append(div1).append(div2).appendTo("#navigate");
    }
    $(document).on("click","#update-image",function(){
        alert("编辑头像");
        location.href="/updateImage.jsp";
    });
    $(document).on("click","#updateUser_btn",function(){

        $.ajax({
            url:"/updateUser",
            data:{"nickname":$("#nickname1").val(),"major":$("#major1").val()},
            type:"POST",
            dataType:"json",
            success:function(){
                alert("修改成功");
                window.location.reload();
            }
            });
    });

    $(document).on("click","#updatePassword_btn",function(){
        $.ajax({
            url:"/updatePassword",
            data:{"oldPassword":$("#oldPassword").val(),"newPassword":$("#newPassword").val()},
            type:"POST",
            dataType:"json",
            success:function(result){
                alert("请重新登录");
                location.href="/logout";
            }
        });
    });
</script>
</body>
</html>
