<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="title" value="兴趣标签" scope="session"/>
<%@ include file="/WEB-INF/pages/include/header.jsp"%>


<h1>选择您感兴趣的标签</h1>
    <div class="row">

            <div class="row">
                <button class="btn" name="label" value="计算机">计算机</button>
                <button class="btn" name="label" value="法律">法律</button>
                <button class="btn" name="label" value="心理学">心理学</button>
                <button class="btn" name="label" value="语文">语文</button>
                <button class="btn" name="label" value="数学">数学</button>
                <button class="btn" name="label" value="英语">英语</button>
            </div> <br>

            <div class="row">
               <div class="col-md-8"></div>
               <div class="col-md-4">
                   <button class="btn btn-warning" id="submit_btn">完成</button>
               </div>
            </div>

    </div>



</div>
<script>
$(document).on("click","button[name='label']",function(){
$(this).toggleClass("btn-success");
});
<!-- 提交按钮 -->
$(document).on("click","#submit_btn",function(){
var labels=$("button[name='label']").filter(function(index,item){
    return $(item).hasClass("btn-success");
}).map(function(index,item){
    return item.value
});
labels=$.makeArray(labels);
$.ajax({
    url:"/addLabel",
    data:{"labels":labels},
    type:"POST",
    dataType:"json",
    traditional:true,
    success:function(result){
        if(result.code==100)
        {
            location.href="/recommend";
        }

    }
});
});
</script>

</body>
</html>
