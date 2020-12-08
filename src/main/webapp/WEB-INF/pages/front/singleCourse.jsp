<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="title" value="${requestScope.course.name}" scope="session"/>
<%@ include file="/WEB-INF/pages/include/header.jsp"%>  <br>
    <div class="row" >
        <div class="col-md-7">
            <img src="${course.image}" alt="image" height="350" width="600">

        </div>
        <div id="btn_div" class="col-md-5">
            <h3><p class="course_title">${course.name}</p></h3>
            <div class="course_inf">
                <p><span>类别:${course.category}</span></p>
                <p><span>授课老师id:${course.tid}</span></p>
            </div>
           
        </div>
    </div>
    <div class="row">
        <div id="comments_div" class="col-md-9">
        <!--评论--!>

        </div>
        <div class="col-md-3">

        </div>
    </div>
    <h3>相似课程</h3>
    <div id="myCourse">

    </div>
    <div id="navigate">

    </div>
</div>

<script>
    $(document).ready(function(){
        to_page(1);
        is_subscribe(${course.id});
        to_page1(1);
    });

    function to_page1(pageNum){
            $.ajax({
                url:"/recommendByItem",
                data:{"cid":${course.id},"pageNum":pageNum},
                type:"POST",
                dataType:"json",
                success:function(result){
                    $("#myCourse").empty();
                    $("#navigate").empty();
                    build_myCourse(result.list);
                    build_navigate1(result);
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

    function build_navigate1(pageinfo)
    {
         var inf=$("<p></p>").text("共"+pageinfo.pages+"页");
         var div1=$("<div></div>").css("height","100").css("width","450").css("float","left").append(inf);

         var prePageLi=$("<li></li>").append($("<a></a>").append("&laquo;")).click(function(){to_page1(pageinfo.prePage)});
         var nextPageLi=$("<li></li>").append($("<a></a>").append("&raquo;"));

         var firstPageLi=$("<li></li>").append($("<a></a>").append("首页")).click(function(){to_page1(1)});
          var lastPageLi=$("<li></li>").append($("<a></a>").append("尾页")).click(function(){to_page1(pageinfo.pages)});;

        if(pageinfo.hasPreviousPage==false)
        {
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }

         var ul=$("<ul></ul>").addClass("pagination").append(firstPageLi).append(prePageLi);
         $.each(pageinfo.navigatepageNums,function(index,item){

            var li=$("<li></li>").append($("<a></a>").append(item)).click(function(){to_page1(item)});
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
            nextPageLi.click(function(){to_page1(pageinfo.nextPage)});
         }
         ul.append(nextPageLi);
         ul.append(lastPageLi);


         var div2=$("<div></div>").css("height","100").css("width","450").css("float","left").append(ul);
          var div=$("<div></div>").css("height","100").css("width","900").append(div1).append(div2).appendTo("#navigate");
    }

















    function is_subscribe(cid){
        $.ajax({
            url:"/isSubscribe",
            data:{"cid":cid},
            type:"POST",
            dataType:"json",
            success:function(result){

                build_btn_div(result);
            }
        });

    }
    function build_btn_div(result){
         if(result==true)
         {
             var btn1=$("<button></button>").addClass("btn btn-success btn-lg").append("开始学习").click(function(){window.location.href="/lesson?id=${course.id}"});
             var btn2=$("<button></button>").addClass("btn btn-primary btn-lg").append("取消订阅").click(function(){window.location.href="/unSubscribe?cid=${course.id}"});
             $("#btn_div").append(btn1).append(btn2);
         }
         if(result==false)
         {
            var btn1=$("<button></button>").addClass("btn btn-primary btn-lg").append("立即订阅").click(function(){window.location.href="/subscribe?cId=${course.id}"});
            $("#btn_div").append(btn1).append(btn2);
         }
     }
    function to_page(pageNum)
    {
        $.ajax({
            url:"/comments",
            data:{"pageNum":pageNum,"cid":"${course.id}"},
            type:"POST",
            dataType:"json",
            success:function(result){
                reset_comments();
                build_comments_div(result.extend.pageinfo.list);
                build_navigate(result.extend.pageinfo);
            }
        });
    }

    function reset_comments()
    {
        $("#comments_div").empty();
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
          var div=$("<div></div>").css("height","100").css("width","900").append(div1).append(div2).appendTo("#comments_div");
    }
    function build_comments_div(list)
    {
        $("<h2></h2>").append("课程评论").appendTo("#comments_div");
        $.each(list,function(index,item){
             var nickname=$("<p></p>").text(item.nickname);
             var div1=$("<div></div>").css("height","100").css("width","80").css("float","left").append(nickname);
             var star=$("<p></p>").text("星数："+item.star);
             var text=$("<p></p>").text("评论内容:"+item.text);
             var div2=$("<div></div>").css("height","100").css("width","800").css("float","left").append(star).append(text);
             var div=$("<div></div>").css("height","100").css("width","880").append(div1).append(div2).appendTo("#comments_div");

        })
    }
</script>
</body>
</html>
