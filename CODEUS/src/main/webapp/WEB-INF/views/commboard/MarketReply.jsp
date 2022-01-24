<%@ page language="java" contentType="text/html; charset=UTF-8"
	    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 등록 댓글</title>

<style>
/*댓글*/
a, .text {
 	color : black;
}

 table {
        width: 100%;
        border-collapse: collapse;
        color : black;
      }
 th, td {
   padding: 10px;
   color : black;
 }
.replyTable {
    width: 100%;
	margin: auto;
	color : black;
}
#rtb tbody {
	color : black;
}
#rtb th {
	border-bottom: 1px dotted grey;
}
#rtb td {
	padding: 3px;
}

.button {
 
  display: inline-block;
  font-size: 12px position: relative;

</style>

		<div class="col-lg-20">
               <div class="card" style="background : #f1f3f5;">
                     <div class="card-body">		
					<table  class="replyTable" id="rtb" style="color : black;">
						<thead>
							<tr>
							<b id="rCount"><br></b>
							</tr>
							<tr>
								<td colspan="10"></td>
							</tr>
						</thead>
						<tbody></tbody>
					</table>
						<br><hr>
				<div class="card">
                   <div class="card-head">
                  	 <div class="card-body">	
					<table class="replyTable" style="width : 800px;">
						<tr>	
							<td><label type="text" style="color : black;">${ sessionScope.loginUser.mId}</label>
							<textarea textarea class="form-control" rows="5" cols="500" id="rContent" placeholder="불쾌감을 주는 욕설과 악플은 삭제될 수 있습니다."></textarea></td>
						</tr>
						<tr>
							<td style="text-align: right;"><div id="test_cnt">0 / 50</div></td>
						</tr>
						<tr>	
							<td><p align="right"><button id="rSubmit" class="btn btn-primary"  display: inline-block;>등록하기</button></p><td>
						</tr>
					</table>
				</div>
			</div>
		</div>			
	</div>
</div>
<script>
$(document).ready(function() {
    $('#rContent').on('keyup', function() {
        $('#test_cnt').html("("+$(this).val().length+" / 50)");
 
        if($(this).val().length > 50) {
            $(this).val($(this).val().substring(0, 50));
            $('#test_cnt').html("(50 / 50)");
        }
    });
});

</script>

				<!-- 댓글 등록 -->
						<script>
								$("#rSubmit").on("click", function() {
									var rContent = $("#rContent").val();
									var refBid = ${ mb.bId };
					
									 if(rContent =="" || rContent == null){
							        	 alert("내용을 입력해 주세요");
							        	 return false;
							         }
						
									$.ajax({
										url: "addReply.bo",
										data: {rContent:rContent, refBid:refBid},
										success: function(data) {
											console.log(data);
						
											if(data == "success") {
												
												$("#rContent").val('');
												getReplyList();
												alert("댓글 등록 성공")
												
											}
										}
									});
								});
						
								
								function getReplyList() {
									var bId = ${ mb.bId };
									var rWriter = '${r.rWriter}';
						
									$.ajax({
										url: "rList.bo",
										type : "get",
										data: {bId:bId},
										dataType : "json",
										success: function(data) {
											console.log(data);
						
											$tableBody = $("#rtb tbody");
											$tableBody.html("");
											
											var $tr;
											var $rWriter;
											var $rContent;
											var $rCreateDate;
											var $btnArea;
											var $btnAreaT;
						
											$("#rCount").text('댓글(' + data.length + ')');
											
											
											if(data.length > 0) {
												for(var i in data) {
													$tr = $("<tr id='modifyTr'>");
													$rWriter = $("<td width='25%' style='font-weight:bold'>").text(data[i].rWriter);
													$rContent = $('<td>').text(data[i].rContent);
													$rCreateDate = $('<td width="25%">').text(data[i].rCreateDate);
													$btnArea = $("<td width='25%' class='modi'>")
								                    .append("<a href ='#' onclick='modifyReply(this,"+bId+","+data[i].rId+",\""+data[i].rContent+"\");'>수정/<a> ")
								                    .append("<a href ='#' onclick='removeReply("+bId+","+data[i].rId+")'>삭제<a>");
												    $btnAreaT = $("<td width='25%' class='modi'>")
												   .append("<a href ='#' onclick='ReportReply("+bId+","+data[i].rId+")'><img class='fit-picture' src='${contextPath}/resources/assets/images/1224162.png' alt=''>신고<a>");
//			                                       
						
													$tr.append($rWriter);
													$tr.append($rContent);
													$tr.append($rCreateDate);
													if(data[i].rWriter == '${loginUser.mId}' || '${loginUser.mId}' == 'kimdo'){
													$tr.append($btnArea);
													}else if(data[i].rWriter != '${loginUser.mId}'){
								                    	 $tr.append($btnAreaT);
								                 	};
													$tableBody.append($tr);
												}
											} else {
												var $tr = $('<tr>');
												var $rContent = $('<td colspan="3">').text("등록된 문의사항이 없습니다.");
												$tr.append($rContent);
												$tableBody.append($tr);
											}
										}
									});
								}

								$(function(){
									getReplyList();
								
								});
								
								
							     function modifyReply(obj, bId, rId,rContent){
							        $trModify = $("<tr>");
							        $trModify
							        .append("<td colspan='3'><input class='form-control'  type='text' id='modifyReply' size='50' value='"+rContent+"'></td>;");
							        $trModify
							        .append("<td><button class='btn btn-primary' onclick='modifyReplyCommit("+bId+","+rId+")'>수정</button></td>");
							        $trModify
							        .append("<td>&nbsp;<button class='btn btn-primary' onclick='getReplyList()'>취소</button></td>");
							        $(obj).parent().parent().after($trModify);
							     }	
							     function modifyReplyCommit(bId, rId){
							         var modifiedContent = $("#modifyReply").val();
							         $.ajax({
							            url : "modifyReply.bo",
							            type : "post",
							            data : {
							               "refBid" : bId,
							               "rId" : rId,
							               "rContent" : modifiedContent
							            },
							            success : function(data){
							               if(data == "success"){
							                  getReplyList();
							               }else{
							                  alert("댓글 수정 실패");
							               }
							            },
							            error : function(){
							               alert("실패");
							            }
							         });
							      }   
							         function removeReply(bId, rId){
							            $.ajax({
							               url : "deleteReply.bo",
							               type : "get",
							               data : {"refBid" : bId,   "rId" : rId,},
							               success : function(data) {
							                  if(data == "success"){
							                     getReplyList();
							                  }else{
							                     alert("댓글 삭제 실패");
							                  }
							               }
							            })
							         }
							         
									 function ReportReply(bId, rId){
										 if(!confirm('정말로 신고하시겠습니까?')) return;
									        $.ajax({
									           url : "ReportReply.bo",
									           type : "get",
									           data : {"bId" : bId, "rId" : rId },
									           success : function(data) {
									        	   if(data == 'success'){
									        	  	 alert("신고되었습니다. 관리자 확인 후 처리 됩니다.");
									        	   }else if(data == 'fail'){
									        		   alert('이미 신고된 댓글 입니다.');
									        	   }
									           }
									        })
									     }
								
					            </script>
</body>

</html>