<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="title" value="首页" scope="session" />
<%@ include file="/WEB-INF/pages/include/header.jsp" %>
<c:if test="${requestScope.message!=null}">
    <script>
        alert("${requestScope.message}");
    </script>
</c:if>
</div>
</body>
</html>
