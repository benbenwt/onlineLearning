<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="title" value="课程广场" scope="session"/>
<%@ include file="/WEB-INF/pages/include/header.jsp"%>
<%@ include file="/WEB-INF/pages/include/filter_course.jsp"%>

    <c:forEach items="${pageinfo.list}" var="course" varStatus="status">
        <c:if test="${(status.index % 4) ==0}">
            <div class="row">
                <div class="col-md-3">
                    <a href="/singleCourse?id=${course.id}"> <img src="${course.image}" alt="图片" width="220" height="120"></a>
                    <h5>${course.name}</h5>
                     <h5>分类： ${course.category}</h5>
                </div>
        </c:if>

         <c:if test="${(status.index % 4) ==1||(status.index % 4) ==2}">
            <div class="col-md-3">
                <a href="/singleCourse?id=${course.id}"> <img src="${course.image}" alt="图片" width="220" height="120"></a>
                    <h5>${course.name}</h5>
                    <h5>分类： ${course.category}</h5>
            </div>
        </c:if>
        <c:if test="${(status.index % 4) ==3}">

            <div class="col-md-3">
                <a href="/singleCourse?id=${course.id}"> <img src="${course.image}" alt="图片" width="220" height="120"></a>
                    <h5>${course.name}</h5>
                      <h5>分类：${course.category}</h5>
            </div>
        </div>
        </c:if>
        <c:if test="${status.last &&status.index % 4!=3}">
            </div>
        </c:if>
    </c:forEach>
    <div class="row">
        <div class="col-md-6">

        </div>
        <div class="col-md-6">
            <nav aria-label="Page navigation">
              <ul class="pagination">
                <c:if test="${pageinfo.hasPreviousPage==true}">
                    <li>
                        <a href="/course?pageNum=1&category=${requestScope.lastCategory}">首页</a>
                    </li>
                    <li>
                        <a href="/course?pageNum=${pageinfo.prePage}&category=${requestScope.lastCategory}">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                </c:if>
                 <c:if test="${pageinfo.hasPreviousPage==false}">
                    <li class="disabled">
                        <a >首页</a>
                    </li>
                    <li class="disabled">
                        <a>
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                </c:if>


                <c:forEach items="${pageinfo.navigatepageNums}" var="page">


                     <c:if test="${page==pageinfo.pageNum}">
                        <li class="active">
                            <a href="/course?pageNum=${page}&category=${requestScope.lastCategory}">${page}</a>
                        </li>
                     </c:if>
                     <c:if test="${page!=pageinfo.pageNum}">
                         <li >
                             <a href="/course?pageNum=${page}&category=${requestScope.lastCategory}">${page}</a>
                         </li>
                      </c:if>
                </c:forEach>


                <c:if test="${pageinfo.hasNextPage==true}">
                    <li>
                        <a href="/course?pageNum=${pageinfo.nextPage}&category=${requestScope.lastCategory}">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                    <li>
                        <a href="/course?pageNum=${pageinfo.pages}&category=${requestScope.lastCategory}">尾页</a>
                    </li>
                </c:if>
                <c:if test="${pageinfo.hasNextPage==false}">
                    <li class="disabled">
                        <a>
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                    <li class="disabled">
                        <a >尾页</a>
                    </li>
                </c:if>
              </ul>
            </nav>
        </div>
    </div>
</div>
</body>
</html>
