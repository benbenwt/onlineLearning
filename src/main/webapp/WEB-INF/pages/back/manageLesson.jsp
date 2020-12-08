<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>管理${cid}号课程内容</title>
    <link href="/css/bootstrap.min.css" rel="stylesheet">
     <script type="text/javascript" src="/js/jquery.min.js"></script>
     <script src="/js/bootstrap.min.js"></script>
     <link rel="stylesheet" href="/css/layui.css"  media="all">
</head>
<body>
<!-- 增加单节课程 -->
 <div class="modal fade" id="addLessonModal" tabindex="-1" role="dialog" >
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title" id="myModalLabel">添加课程</h4>
          </div>
          <div class="modal-body">
                <form class="form-horizontal" id="update_user_form">
                              <div class="form-group">
                                <label for="lessonName" class="col-sm-2 control-label">lessonName</label>
                                <div class="col-sm-10">
                                  <input type="text" class="form-control" id="lessonName" placeholder="lessonName" name="lessonName">
                                </div>
                              </div>
                             <input type="file" id="file1" name="file1" >
                            </form>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            <button type="button" class="btn btn-primary" id="save_addLesson_btn">添加</button>
          </div>
        </div>
      </div>
 </div>




    <ul class="layui-nav">
        <li class="layui-nav-item ">在线学习平台后台管理</li>
        <li class="layui-nav-item ">
            <a href="javascript:;">欢迎登录！</a>
            <dl class="layui-nav-child">
              <dd><a href="/manageUser">用户管理</a></dd>
              <dd><a href="/manageCourse">课程管理</a></dd>
              <dd><a href="/adminLogout">注销</a></dd>
            </dl>
        </li>
    </ul>  <br>
    <div class="container">
        <div class="row">
            <div class="col-md-8"><h1>管理${cid}号课程内容</h1></div>
            <div class="col-md-4"><button id="addLesson" class="btn btn-info btn-sm"><span class="glyphicon glyphicon-plus"></span>add</button></div>
        </div>

        <div class="row">
            <table class="table table-hover">
                <tr>
                <th>id</th>
                <th>name</th>
                <th>video</th>
                <th>operate</th>
                </tr>
                 <c:forEach items="${pageInfo.list}" var="lesson">
                     <tr>
                        <td> ${lesson.id}</td></td>
                        <td> ${lesson.name}</td>
                        <td> ${lesson.vedio}</td>
                        <td>

                            <button class="btn btn-danger btn-sm delete-btn" value=${lesson.id}><span class="glyphicon glyphicon-trash"></span>delete</button>
                        </td>

                     </tr>
                 </c:forEach>
            </table>
        </div>
    </div>

    <div class="row">
        <div class="col-md-6">
            第${pageInfo.pageNum}页 共${pageInfo.pages}页 共${pageInfo.total}条记录
        </div>
        <div class="col-md-6">
            <nav aria-label="Page navigation">
                  <ul class="pagination">
                    <c:if test="${pageInfo.hasPreviousPage==true}">
                        <li><a href="/manageLesson?cid=${cid}&pageNum=1">firstPage</a></li>
                    </c:if>
                    <c:if test="${pageInfo.hasPreviousPage==false}">
                        <li class="disabled"><a href="/manageLesson?pageNum=1" >firstPage</a></li>
                    </c:if>
                    <c:if test="${pageInfo.hasPreviousPage}">
                        <li>
                          <a href="/manageLesson?cid=${cid}&pageNum=${pageInfo.pageNum-1}" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                          </a>
                        </li>
                    </c:if>

                    <c:forEach items="${pageInfo.navigatepageNums}" var="page_Num">
                        <c:if test="${page_Num==pageInfo.pageNum}">
                            <li class="active"><a href="#">${page_Num}</a></li>
                         </c:if>
                        <c:if test="${page_Num!=pageInfo.pageNum}">
                            <li><a href="/manageLesson?cid=${cid}&pageNum=${page_Num}">${page_Num}</a></li>
                         </c:if>
                    </c:forEach>
                    <c:if test="${pageInfo.hasNextPage}">
                        <li>
                          <a href="/manageLesson?cid=${cid}&pageNum=${pageInfo.pageNum+1}" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                          </a>
                        </li>
                    </c:if>
                    <c:if test="${pageInfo.hasNextPage==true}">
                          <li><a href="/manageLesson?cid=${cid}&pageNum=${pageInfo.pages}">endPage</a></li>
                    </c:if>
                    <c:if test="${pageInfo.hasNextPage==false}">
                          <li class="disabled"><a href="/manageLesson?cid=${cid}&pageNum=${pageInfo.pages}">endPage</a></li>
                    </c:if>

                  </ul>
                </nav>
        </div>
    </div>


    <script src="/js/layui.js" charset="utf-8"></script>
    <script src="/js/layui.all.js" charset="utf-8"></script>

    <script>
         $(document).on("click",".delete-btn",function(){
            if(!confirm("确认删除该节课程吗？"))
            {
                return false;
            }
            $.ajax({
                url:"/deleteLesson",
                data:{"id":$(this).val()},
                type:"POST",
                dataType:"json",
                success:function(result){
                    alert("删除成功");
                    window.location.reload();
                }
            });
         });

         $(document).on("click","#save_addLesson_btn",function(){
            var formData = new FormData();
                formData.append("files", $("#file1")[0].files[0]);
                formData.append("name",$("#lessonName").val());
                formData.append("cid",${cid});
           $.ajax({
                    type:"POST",
                    url:"/addLesson",
                    data:formData,
                    contentType:false,
                    processData:false,
                    dataType:"json",
                    mimeType:"multipart/form-data",
                success:function(){
                    alert("添加成功");
                    window.location.reload();
                }
            });
         });

         $(document).on("click","#addLesson",function(){

            $("#addLessonModal").modal({});
         });
    </script>
</body>
</html>
