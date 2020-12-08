<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="title" value="${requestScope.cid}" scope="session"/>
<%@ include file="/WEB-INF/pages/include/header.jsp"%> <br>

    <c:if test="${requestScope.message!=null}">
        <script>
            alert("${requestScope.message}");
        </script>
    </c:if>
    <!-- 视频列表 -->
    <div class="row" >
        <div class="col-md-4">
            <div class="row pre-scrollable"  style="width:300;font-size:20;">
                <ol style="list-style:none ">
                    <c:forEach items="${lessonlist}" var="lesson">
                        <li onclick="change_video('${lesson.vedio}')">${lesson.name}</li>
                    </c:forEach>
                </ol>
            </div>
        </div>
        <div class="col-md-6">
            <video id="video" src="/video/movie.ogv" controls="controls">
                your browser does not support the video tag
            </video>
        </div>
        <div id="comment_div" class="col-md-2">

        </div>
    </div>

</div>

<!-- 查看我的评论模态框 -->
<div class="modal fade" id="comment_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">我的评论</h4>
      </div>
      <div class="modal-body">
            <form class="form-horizontal">
                          <div class="form-group">
                            <label class="col-sm-2">打分</label>
                            <div id="star" class="col-sm-10">
                            </div>
                          </div>
                          <div class="form-group">
                            <label class="col-sm-2">评论</label>
                            <div id="text" class="col-sm-10">
                            </div>
                          </div>
            </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      </div>
    </div>
  </div>
</div>

<!-- 评论课程模态框 -->
<div class="modal fade" id="addcomment_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">评价课程</h4>
      </div>
      <div class="modal-body">
            <form id="comment_form" class="form-horizontal">
                          <div class="form-group">
                            <label class="col-sm-2">打分</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" placeholder="star" name="star">
                            </div>
                          </div>
                          <div class="form-group">
                            <label class="col-sm-2">评论</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control"  placeholder="text"  name="text">
                            </div>
                          </div>
            </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary" id="addcomment_btn">完成</button>
      </div>
    </div>
  </div>
</div>

<script>
    $(document).ready(function(){
        show_comment(${requestScope.cid});
    });
    function show_comment(cid){
        $.ajax({
            url:"/hasComment",
            data:{"cid":cid},
            type:"POST",
            dataType:"json",
            success:function(result){
                if(result==true)
                {
                    var btn=$("<button></button>").addClass("btn btn-primary btn-lg").append("查看评价").click(function(){get_comment(${requestScope.cid})});
                    $("#comment_div").append(btn);
                }
                else{
                    var btn=$("<button></button>").addClass("btn btn-primary btn-lg").append("评价课程").click(function(){$("#addcomment_modal").modal({});});
                    $("#comment_div").append(btn);
                }
            }
        });
    }

    $(document).on("click","#addcomment_btn",function(){
            add_comment(${requestScope.cid});
             window.location.reload();
    });
    function add_comment(cid){
        $.ajax({
            url:"/addComment",
            data:{"cid":cid,"star":$("input[name='star']").prop("value"),"text":$("input[name='text']").prop("value")},
            type:"POST",
            dataType:"json",
            success:function(result){
                alert(result.msg);

            }
        });
    }
    function get_comment(cid)
    {
        $.ajax({
            url:"/myComment",
            data:{"cid":cid},
            type:"POST",
            dataType:"json",
            success:function(result){
                $("#star").empty();
                $("#text").empty();
                $("#star").append($("<p></p>").append(result.star));
                $("#text").append($("<p></p>").append(result.text));

                $("#comment_modal").modal({});
            }
        });
    }
    function change_video(video)
    {

        $("#video").attr("src",video);
    }


   $(document).ready(function(){
        jQuery.validator.addMethod("checkInput1", function(value, element) {
            var regName=/^[1-5]{1,1}$/;
            if(regName.test(value)) {
                return true;
            }
            return false;
        }, "评分为1-5的整数");

        $("#comment_form").validate({
            rules:{
                star:{
                required:true,
                 checkInput1:true
                },
                text:{
                    rangelength:[1,50]
                }

            },
            messages:{
                name:{
                    required:"评分不为空",
                    checkInput1:"评分为1-5的整数"
                },
                text:{
                    rangelength:"最多输入50字评论"
                    }
            }
        });
   });
</script>
</body>
</html>
