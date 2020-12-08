<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>用户管理</title>
    <link href="/css/bootstrap.min.css" rel="stylesheet">
     <script type="text/javascript" src="/js/jquery.min.js"></script>
     <script src="/js/bootstrap.min.js"></script>
     <link rel="stylesheet" href="/css/layui.css"  media="all">
</head>
<body>
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
    </ul>
    <br>
    <div class="container">

    <h1>管理用户信息</h1>

        <div class="row">
            <table class="table table-hover">
                <tr>
                <th>id</th>
                <th>account</th>
                <th>nickname</th>
                <th>major</th>
                <th>active(1为已激活)</th>
                <th>operate</th>
                </tr>
                 <c:forEach items="${pageInfo.list}" var="user">
                     <tr>
                        <td> ${user.id}</td>
                        <td> ${user.username}</td>
                        <td> ${user.nickname}</td>
                        <td> ${user.major}</td>
                        <td>${user.active}</td>
                        <td>

                            <button class="btn btn-danger btn-sm delete-btn" value=${user.id}><span class="glyphicon glyphicon-trash"></span>delete</button>
                        </td>

                     </tr>
                 </c:forEach>
            </table>
        </div>


<!-- 分页导航条 -->
     <div class="row">
            <div class="col-md-6">
                第${pageInfo.pageNum}页 共${pageInfo.pages}页 共${pageInfo.total}条记录
            </div>
            <div class="col-md-6">
                <nav aria-label="Page navigation">
                      <ul class="pagination">
                        <c:if test="${pageInfo.hasPreviousPage==true}">
                            <li><a href="/manageUser?pageNum=1">firstPage</a></li>
                        </c:if>
                        <c:if test="${pageInfo.hasPreviousPage==false}">
                            <li class="disabled"><a href="/manageUser?pageNum=1" >firstPage</a></li>
                        </c:if>
                        <c:if test="${pageInfo.hasPreviousPage}">
                            <li>
                              <a href="/manageUser?pageNum=${pageInfo.pageNum-1}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                              </a>
                            </li>
                        </c:if>

                        <c:forEach items="${pageInfo.navigatepageNums}" var="page_Num">
                            <c:if test="${page_Num==pageInfo.pageNum}">
                                <li class="active"><a href="#">${page_Num}</a></li>
                             </c:if>
                            <c:if test="${page_Num!=pageInfo.pageNum}">
                                <li><a href="/manageUser?pageNum=${page_Num}">${page_Num}</a></li>
                             </c:if>
                        </c:forEach>
                        <c:if test="${pageInfo.hasNextPage}">
                            <li>
                              <a href="/manageUser?pageNum=${pageInfo.pageNum+1}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                              </a>
                            </li>
                        </c:if>
                        <c:if test="${pageInfo.hasNextPage==true}">
                              <li><a href="/manageUser?pageNum=${pageInfo.pages}">endPage</a></li>
                        </c:if>
                        <c:if test="${pageInfo.hasNextPage==false}">
                              <li class="disabled"><a href="/manageUser?pageNum=${pageInfo.pages}">endPage</a></li>
                        </c:if>

                      </ul>
                    </nav>
            </div>
     </div>

</div>

    <script src="/js/layui.js" charset="utf-8"></script>
    <script src="/js/layui.all.js" charset="utf-8"></script>

    <script>
        $(document).on("click",".delete-btn",function(){
            var id=this.value
           if(!confirm("确认删除"+id+"号用户?"))
           {return false;}

              $.ajax({
                url:"/deleteUser",
                data:{"uid":id},
                type:"POST",
                dataType:"json",
                success:function(result){
                    location.href="/manageUser?pageNum="+${pageInfo.pageNum};
                }

              });
        })
    </script>
</body>
</html>
