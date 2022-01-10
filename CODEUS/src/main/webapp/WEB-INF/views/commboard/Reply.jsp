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
#replyTable {
	width: 90%;
	margin-top: 100px;
}
.rCount {
	width: 90%;
}
#replyContentArea > textarea {
	resize: none;
	width: 100%;
	border: 1px solid #17a2b8;;
	border-radius : 5px;
	margin : 0px;
}
#replyWrite {
	margin-right : 400px;
}
#replyBtnArea {
	width: 100px; 
	display: inline-block;
}
.rWriter {
	display: inline-block;
	margin-right: 30px;
	vertical-align: top;
}
.rDate {
	display: inline-block;
	font-size: 0.5em;
	color: gray;
}
#replyListArea {
	list-style-type: none;
}
.rContent, .replyBtnArea {
	height: 100%;
	width: 100%;
}
.replyBtnArea {
	text-align: right;
	marign:0px;]
}
.replyUpdateContent {
	resize: none;
	width: 100%;
}
.reply-row{
	border-top : 1px solid #ccc;
	padding : 15px 0;
}
.btn1{
	background-color: #8ad2d5;
	color: white;
	border: white;
	border-radius: 5px;
	width : 60px;
	height: 55px;
}
.btn1:hover{
	background-color: #17a2b8;
}
#updateReply, #deleteReply {
	background-color: #8ad2d5;
	color: white;
	border: white;
	border-radius: 5px;
	width : 60px;
	height: 55px;
}
</style>

							
							<table  class="replyTable" id="rtb" style="color : black;">
								<thead>
									<tr>
										<td colspan="2"><b id="rCount"></b></td>
									</tr>
								</thead>
								<tbody></tbody>
							</table>
							<table class="replyTable" >
								<tr>
									<td><textarea rows="3" cols="55" id="rContent"></textarea></td>
									<td><button id="rSubmit" class="btn btn-primary">등록하기</button></td>
									
								</tr>
							</table>
					
							
							<!-- 댓글 등록 -->
							<script>
								$("#rSubmit").on("click", function() {
									var rContent = $("#rContent").val();
									var refBid = ${ b.bId };
					
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
												
												$("rContent").val('');
												getReplyList();
												alert("댓글 등록 성공")
												
											}
										}
									});
								});
						
								
								function getReplyList() {
									var bId = ${ b.bId };
						
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
													$rWriter = $('<td width="100">').text(data[i].rWriter);
													$rContent = $('<td>').text(data[i].rContent);
													$rCreateDate = $('<td width="100">').text(data[i].rCreateDate);
												    $btnArea = $("<td width='80'>")
								                    .append("<a href ='#' onclick='modifyReply(this,"+bId+","+data[i].rId+",\""+data[i].rContent+"\");'>수정/<a> ")
								                    .append("<a href ='#' onclick='removeReply("+bId+","+data[i].rId+")'>삭제<a>");
												    $btnAreaT = $("<td width='80' class='modi'>")
												   .append("<a href ='#' onclick='ReportReply("+bId+","+data[i].rId+")'>신고<a>");
//			                                       
						
													$tr.append($rWriter);
													$tr.append($rContent);
													$tr.append($rCreateDate);
													//if(data[i].rWriter == loginUser.mId || loginUser.mId == 'admin'){
													$tr.append($btnArea);
													//}else if(data[i].rWriter != loginUser.mId){
								                    	 $tr.append($btnAreaT);
								                 // };
													$tableBody.append($tr);
												}
											} else {
												var $tr = $('<tr>');
												var $rContent = $('<td colspan="3">').text("등록된 댓글이 없습니다.");
						
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
							        .append("<td colspan='3'><input type='text' id='modifyReply' size='50' value='"+rContent+"'></td>&nbsp;");
							        $trModify
							        .append("<td>&nbsp;<button class='btn btn-primary' onclick='modifyReplyCommit("+bId+","+rId+")'>수정</button></td>");
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