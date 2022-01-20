<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 상세</title>
<style>
	a:hover{cursor: pointer;}
	.card-body{color: black;}
	.button:hover{cursor: pointer;}
	.formBtn{color: #696969; font-size: 15px; font-weight: bold;}
	.table tbody{font-size: 14px;}
	.table a{color: black;}
	.replyUpdateBtn{float:right; padding-right: 10px;}
  	 #replyArea{font-size: 13px;}
  	 .nestedReply{margin-left: 20px;}
  	 .file a{color: black;}
  	 
  	 /* scrap 관련 css */
	.scrapBtn {float: right;}
	.scrapBtn .bi, .scrapBtn span{color: black;}
	.scrapBtn:hover {border-color: MediumSlateBlue; background-color: Lavender;}
	.scrapBtn:hover .bi, .scrapBtn:hover span {color: MediumSlateBlue;}
	.scrap{background: Lavender;}  	 
	
	/* 댓글 관련 css */
	.nestedReplyWrite{margin-left: 20px; display: none;}
	.nestedReplyWrite textarea {display: inline; max-width: 1050px;}
	.nestedReplyWrite button, .replyWriteArea button, .replyEditArea button{float: right; margin-right: 10px;}
	.replyWriteArea textarea{display: inline; max-width: 1070px;}
	.replyUpdateBtn{display: none;}
	.nestedReplywriteFormBtn{color: #696969;}
	.replyEditArea textarea{display: inline; max-width: 1000px;}
	.deleted span{color: gray;}
</style>
</head>
<body>

    <!--**********************************
        Main wrapper start
    ***********************************-->
    <div id="main-wrapper">	

		<c:import url="../common/menubar.jsp"/>
    
        <!--**********************************
            Content body start
        ***********************************-->
        <div class="content-body">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title" style="font-weight: bold; font-size: large;">공지사항</h3>
                            </div>
                            <div class="card-body">
                            	<!-------- 버튼 영역 --------->
                            	<div id="btnArea">
                            		<c:if test="${ loginUser.mId == board.mId }">
                            			<!-- 수정 페이지 이동  -->
	                            		<c:url var="nbUpdateView" value="nbUpdateView.nb">
	                            		   <c:param name="bNum" value="${ board.bNum }"/>
			                               <c:param name="page" value="${ page }"/>
			                               <c:if test="${ searchValue ne null }"> <!-- null이 아니면 검색을 했다는 뜻 -->
			                                    <c:param name="searchCondition" value="${ searchCondition }"/>
												<c:param name="searchValue" value="${ searchValue }"/>
											</c:if>	
			                            </c:url>
                            			<a class="formBtn" href="${ nbUpdateView }">
                            				<i class="bi bi-pencil-square"></i> 수정
                            			</a>&nbsp;&nbsp;
                            			<form id="deleteForm" class="formBtn" action="nbDelete.nb" method="post" style="display: inline;">
                            				<input type="hidden" name="bNum" value="${ board.bNum }">
                            				<a id="deleteBoardBtn" class="formBtn"><i class="bi bi-trash"></i> 삭제</a>
                            			</form>
                            		</c:if>
                            		<script>
                            			// 게시글 삭제
                            			$('#deleteBoardBtn').on('click', function() {
                            				Swal.fire({
	    	                       				  title: '정말 삭제하시겠습니까?',
	    	                       				  showCancelButton: true,
	    	                       				  confirmButtonText: '삭제',
	    	                       				  cancelButtonText: '취소'
	    	                       				}).then((result) => {
	    	                       				  if (result.value) {
	    	                       					$('#deleteForm').submit();
	    	                       				  }
	                           				});
                            			});
                            		</script>
                            		<!-- 목록 이동  -->
		                            <c:if test="${ searchValue eq null }">
			                            <c:url var="noticeBoardList" value="noticeBoardList.nb">
			                                <c:param name="page" value="${ page }"/>
			                            </c:url>
                            			<a class="formBtn" style="float: right;" href="${ noticeBoardList }"><i class="bi bi-justify"></i> 목록으로</a>
                            		</c:if>	
		                            <c:if test="${ searchValue ne null }">
			                            <c:url var="searchNoticeBoard" value="searchNoticeBoard.nb">
			                                <c:param name="page" value="${ page }"/>
			                                <c:param name="searchCondition" value="${ searchCondition }"/>
										    <c:param name="searchValue" value="${ searchValue }"/>
			                            </c:url>
                            			<a class="formBtn" style="float: right;" href="${ searchNoticeBoard }"><i class="bi bi-justify"></i> 목록으로</a>
                            		</c:if>	
                            		<br>
                            	</div>
                            	<hr>
                            	<!-------- 글 영역 --------->
                            	<div id="boardArea">
                            		<div id="boardTitle">
                            			<h3>${ board.bTitle }</h3>
                            			<span> &nbsp;${ board.mName } ${ board.jobName }</span>
                            			<span style="color: gray; font-size: small;"> &nbsp;${ board.createDate } [<fmt:formatDate value="${ board.createDate }" pattern="E"/>] </span>
										<span style="color: gray; font-size: small;"> 조회수 ${ board.views }</span>
                            			<!-- 스크랩 버튼 -->
                            			<button class="scrapBtn btn btn-rounded btn-outline-light ${ scrapStatus == 1 ? 'scrap' : '' }" onclick="scrap('${ board.bNum }')">
                            				<i class="bi bi-bookmark-star-fill"></i><span> 스크랩</span>
                            			</button>
                            		</div>
                            		<br><br>
                            		<div id="boardContent">
                            			${ board.bContent }
                            		</div>
                            		<br>
                            	</div>
                            	<script>
	                            	// scrap 관련 js
	                       			$(function() {
	                       				$('.scrap').css('background', 'Lavender');
	                       			});
	                       			
		                       		function scrap(bNum) {
		                       			let $scrapBtn = $('.scrapBtn');
		                       			
		                       			if (!$scrapBtn.hasClass('scrap')) { // 스크랩한 상태가 아닐때
		                       				// 스크랩 추가
		                       				$.ajax({
	                   							url: 'insertScrap.nb',
	                   							data: {bNum:bNum},
	                   							type: 'POST',
	                   							success: function(data){
	                   								console.log(data);
	                   								if (data.trim() == 'success') {
	                   									$scrapBtn.css('background', 'Lavender');
	                   									$scrapBtn.addClass('scrap');
	                   								} else {
	                   									alert('알 수 없는 에러가 발생했습니다.', '', 'error');
	                   								}
	                   							},
	                   							error: function(data){
	                   								console.log(data);
	                   								alert('알 수 없는 에러가 발생했습니다.', '', 'error');
	                   							}
	                   						});			
		                       				
		                       			
		                       			} else { // 스크랩한 상태일때
		                       				// 스크랩 삭제
		                       				$.ajax({
	                   							url: 'deleteScrap.nb',
	                   							data: {bNum:bNum},
	                   							type: 'POST',
	                   							success: function(data){
	                   								console.log(data);
	                   								if (data.trim() == 'success') {
	                   									$('.scrapBtn').css('background', '');
	            	                       				$('.scrapBtn').removeClass('scrap');
	                   								} else {
	                   									alert('알 수 없는 에러가 발생했습니다.', '', 'error');
	                   								}
	                   							},
	                   							error: function(data){
	                   								console.log(data);
	                   								alert('알 수 없는 에러가 발생했습니다.', '', 'error');
	                   							}
		                       				});
		                       				
		                       			}
		                       		}
                            	</script>
                            	
                            	<!-------- 첨부파일 영역 --------->
                            	<div id="fileArea">
                            		<c:forEach var="f" items="${ fileList }">
                            			 <!-- 파일이 이미지인지 아닌지 확인-->
                            			<c:set var="length" value="${fn:length(f.fileOriginName)}"/>
                            			<c:set var="imgExtArr" value="${fn:split('jpg,jpeg,png,gif,svg', ',')}" />
                            			<c:set var="ext" value="${ fn:substring(f.fileOriginName, fn:indexOf(f.fileOriginName, '.')  + 1, length) }"/>
                             			<c:set var="imgFlag" value="false"/>
                             			<c:forEach var="e" items="${ imgExtArr }">
                             				<c:if test="${ ext == e }">
                             					<c:set var="imgFlag" value="true"/>
                             				</c:if>
                             			</c:forEach>
                             			
                             			<div id="file${ f.fileNo }" class="file">
	                             			<!-- 이미지 파일인 경우 -->
	                             			<c:if test="${ imgFlag }">
	                             				<!-- 이미지 미리보기  -->
		 					              		<img id="img${ f.fileNo }" src="${contextPath}/resources/uploadFiles/${ f.fileChangeName }" width="100" height="100" download><br>
		 					                	    <%-- <a class="badge-s badge-outline-light" onclick="fileDelete(${ f.fileNo })"><i class="bi bi-x"></i></a> --%>
	 										</c:if>
	 										<!-- 이미지 파일이 아닌 경우-->
	 										<c:if test="${ !imgFlag }">
	 					                	    <%-- <a class="badge-s badge-outline-light" onclick="fileDelete(${ f.fileNo })"><i class="bi bi-x"></i></a> --%>
							                    <!-- 파일 아이콘 결정 -->
							                    <c:set var="iconType" value="${ ext == 'pdf' ? '-pdf' : ext == 'txt' ? '-text' :  ext == 'docx' ? '-word' : '' }"/> 
							                    <i class="bi bi-file-earmark${ iconType }" style="color: #D2B48C;"></i>
 											</c:if>
 											<a href="${contextPath}/resources/uploadFiles/${ f.fileChangeName }" download>${ f.fileOriginName }</a> 
 											<!-- 파일 사이즈 표기 -->
 					                		<c:set var="size" value="${  f.fileSize >= 1024 * 1024 ?  f.fileSize / 1024 / 1024 * 100 : f.fileSize / 1024 * 100 }"/> 
 					                		<c:set var="unit" value="${  f.fileSize >= 1024 * 1024 ?  'MB' : 'KB' }"/> 
 					                		<fmt:formatNumber var="fileSizeFmt" value="${ size+((size%1>0.5)?(1-(size%1))%1:-(size%1)) }" type="number" pattern="0.00" />
 					                		<span style="color: gray"> (${ fileSizeFmt / 100 } ${ unit })</span>
 					                	</div>
                        			</c:forEach>
                            	</div>
                            	<br><br>
                            	<!-------- 댓글 영역 --------->
                            	<c:set var="replyCount" value="0"/>
                            	<c:forEach var="r" items="${ replyList }">
                            		<c:set var="replyCount" value="${ r.replyStatus == 0 ? replyCount + 1 : replyCount }"/>
								</c:forEach>
	                        	<span class="badge-m badge-rounded badge-outline-light">
									댓글&nbsp;<span id="replyCount">${ replyCount }</span>	
								</span>
								<hr>
                            	<div id="replyArea">
                            		<% pageContext.setAttribute("newLineChar", "\n"); %> <!-- 개행문자 줄바꿈 처리 -->
									<c:forEach var="r" items="${ replyList }">
										<c:if test="${ r.level == 1 }"> 
											<c:set var="hasChildren" value="false"/>
											<c:forEach var="r2" items="${ replyList }">
												<c:if test="${ r2.parentReplyNo == r.replyNo && r2.replyStatus == 0 }">
													<c:set var="hasChildren" value="true"/>
												</c:if>
											</c:forEach>
											<c:if test="${ r.replyStatus == 0 }">
												<div class="reply">
													<p id="replyNo${ r.replyNo }">
														<span>${ r.writerName } ${ r.writerJobName } &nbsp;</span>
														<span style="color: gray;">${ r.replyCreateDate } &nbsp;&nbsp;</span>
														<a class="nestedReplywriteFormBtn">
																<i class="bi bi-chat-right"></i> <span>답댓글</span>
														</a>
														<c:if test="${ loginUser.mId == r.replyWriter }">
															<span class="replyUpdateBtn">
																<input type="hidden" name="rNo" value="${ r.replyNo }">
																<a class="replyEditFormBtn badge badge-light"><i class="bi bi-pencil"></i> 수정</a>
																<a class="replyDeleteBtn badge badge-light"><i class="bi bi-x-lg"></i> 삭제</a>
															</span>
														</c:if>
														<br>
														<span class="rContent">${ fn:replace(r.replyContent, newLineChar, "<br>") }</span>
													</p>
													<!-- 대댓글 작성 -->
													<div class="nestedReplyWrite">
														<textarea class="form-control" rows="1" maxlength="160"></textarea>
														<button type="button" class="nestedReplyInsertBtn btn btn-sm btn-outline-dark">등록</button>
														<input type="hidden" name="rNo" value="${ r.replyNo }">
													</div>
												</div>
											</c:if>
											<c:if test="${ hasChildren && r.replyStatus == 1 }">
												<div class="reply deleted">
													<p id="replyNo${ r.replyNo }">
														<span>삭제된 댓글입니다.</span>
													</p>
												</div>
											</c:if>
										</c:if>
										<!-- 대댓글 -->
										<c:forEach var="r2" items="${ replyList }">
											<c:if test="${ r2.parentReplyNo == r.replyNo && r2.replyStatus == 0 }">
												<div class="reply nestedReply">
													<p id="replyNo${ r2.replyNo }">
														<span>${ r2.writerName } ${ r2.writerJobName } &nbsp;</span>
														<span style="color: gray;">${ r2.replyCreateDate } &nbsp;&nbsp;</span>
														<c:if test="${ loginUser.mId == r2.replyWriter }">
					                            	   		<span class="replyUpdateBtn">
					                            	   			<input type="hidden" name="rNo" value="${ r2.replyNo }">
					                            	   			<a class="replyEditFormBtn badge badge-light"><i class="bi bi-pencil"></i> 수정</a>
					                            	   			<a class="replyDeleteBtn badge badge-light"><i class="bi bi-x-lg"></i> 삭제</a>
					                            	   		</span>
				                            	   		</c:if>
														<br>
														<span class="rContent">${ fn:replace(r2.replyContent, newLineChar, "<br>") }</span>
													</p>
	                            	   			</div> 
											</c:if>
										</c:forEach>
									</c:forEach>
                        		</div>
                        		<br>
                        		<!-- 댓글 작성 -->
								<div class="replyWriteArea">
									<textarea class="form-control" rows="1" maxlength="160"></textarea>
									<button type="button" class="replyInsertBtn btn btn-sm btn-outline-dark">등록</button>
								</div>
                            </div>
                            
							<!-- 댓글 관련 js -->                            
                       		<script>
                       		
	                       		// 답댓글 작성 버튼 클릭시 작성 영역 보이게 하는 js
 	                       		$(document).on('click', '.nestedReplywriteFormBtn', function(){
	 	                       		let writeBtnText = $(this).children().next().text();
	                       			if (writeBtnText == '답댓글') {
	                       				$('.nestedReplywriteFormBtn').find('span').text('답댓글');
	                       				$('.nestedReplyWrite').hide();
	                       				$('.nestedReplyWrite').children('textarea').val('');
	                       				$(this).parent().next().slideToggle();
		                       			$(this).children().next().text('취소');
		                       			
		                       			$('.replyEditArea').remove();
		                       			$('.rContent').show();
		                       			
	                       			} else {
	                       				$(this).parent().next().slideToggle();
		                       			$(this).children().next().text('답댓글');
	                       			}
 	                       		});
	                       		
	                       		// 대댓글 등록 버튼 클릭
 	                       		$(document).on('click', '.nestedReplyInsertBtn', function(){
	 	                       		let parentReplyNo = $(this).next().val();
	 	                       		console.log("dd" +parentReplyNo)
	 	                       		let replyContent = $(this).prev().val();
		 	                       	
	 	                       		insertReply(replyContent, parentReplyNo);
	                       		});	
	                       		
	                       		// 댓글 등록 버튼 클릭
 	                       		$(document).on('click', '.replyInsertBtn', function(){
	 	                       		let replyContent = $(this).prev().val();
		 	                       	
	 	                       		insertReply(replyContent);
	                       		});	
	                       		
	                       		// 댓글 등록 ajax
	                       		function insertReply(replyContent, parentReplyNo) {
	                       			let refBNum = '${board.bNum}';
	                       			// console.log(parentReplyNo == undefined);
	                       			
	                       			if (replyContent.trim() == "") {
	 	                       			alert('내용이 비어있습니다.');
	 	                       		} else {
		 	                       		$.ajax({
	               							url: 'insertReply.nb',
	               							data: {replyContent:replyContent, refBNum:refBNum, parentReplyNo:parentReplyNo},
	               							type: 'POST',
	               							dataType: 'json',
	               							success: function(data){
	               								console.log(data);
	               								if (data.length > 0) {
	               									$('.replyWriteArea').children().val('');
	               									
	               									updateReplyArea(data);
	               								} else {
	               									alert('알 수 없는 에러가 발생했습니다.', '', 'error');
	               								}
	               							},
	               							error: function(data){
	               								console.log(data);
	               								alert('알 수 없는 에러가 발생했습니다.', '', 'error');
	               							}
	                       				});
	 	                       		}
	                       		}
	                       		
	                       		// 댓글 등록, 수정, 삭제시 목록 갱신
	                       		function updateReplyArea(data) {
	                       			//replyArr = Array.prototype.slice.call(data); // replyArr 새로 생성된 리스트로 업데이트
	                       			let replyCount = 0;
	                       			let replyArea = $('#replyArea'); 
	                       			
	                       			replyArea.html('');
	                       			
	                       			let newLineChar = /\n/g; // 개행문자 줄바꿈 처리 위한 정규식 
	                       			let html = '';
	                       			let editBtnArea = '<a class="replyEditFormBtn badge badge-light"><i class="bi bi-pencil"></i> 수정</a>'
													+ '<a class="replyDeleteBtn badge badge-light"><i class="bi bi-x-lg"></i> 삭제</a></span>';	
	                       			for (let i in data) {
	                       				if (data[i].replyStatus == 0) {
	                       					replyCount++;
	                       				}
	                       				
	                       				if(data[i].writerJobName == null) {
	                       					data[i].writerJobName = "";
	                       				}
										
	                       				// 대댓글이 아닌 경우
	                       				if(data[i].level == 1) {
	                       					let hasChildren = false;
	                       					for (let j in data) {
	                       						if (data[j].parentReplyNo == data[i].replyNo && data[j].replyStatus == 0) {
	                       							hasChildren = true;
	                       						}
	                       					}
	                       					
	                       					if (data[i].replyStatus == 0) {
	                       						html += '<div class="reply">'
	                       							+ '<p id="replyNo' +  data[i].replyNo + '">'
	                       							+ '<span>' + data[i].writerName + " " +  data[i].writerJobName  + ' &nbsp;</span>'
	                       							+ '<span style="color: gray;">' + data[i].replyCreateDate + '&nbsp;&nbsp;</span>'
	                       							+ '<a class="nestedReplywriteFormBtn"><i class="bi bi-chat-right"></i> <span>답댓글</span></a>';
	                       						
	                       						// 자신이 작성한 댓글이면 수정, 삭제 버튼 보이게
		                       					if ('${loginUser.mId}' == data[i].replyWriter) {
		                       						html += '<span class="replyUpdateBtn">'
		                       								+ '<input type="hidden" name="rNo" value="' +  data[i].replyNo + '">'
		                       								+ editBtnArea;
		                       					}
		                       					
		                       					// 댓글 내용 개행문자 줄바꿈 처리
		                       					html += '<br><span class="rContent">' + data[i].replyContent.replace(newLineChar, '<br>') + '</span></p>';
		                       					
		                       					// 대댓글 작성 영역
												html += '<div class="nestedReplyWrite">'
													    + '<textarea class="form-control" rows="1" maxlength="160"></textarea>'
													    + '<button type="button" class="nestedReplyInsertBtn btn btn-sm btn-outline-dark">등록</button>'
														+ '<input type="hidden" name="rNo" value="' +  data[i].replyNo + '"></div></div>';
		                       					
	                       					} else if (hasChildren && data[i].replyStatus == 1) {
	                       						// 답댓글이 달려 있으면서 삭제된 댓글이면 삭제된 댓글로 표시
	                       						html += '<div class="reply deleted">'
	                       								+ '<p id="replyNo' +  data[i].replyNo + '">'
	                       								+ '<span>삭제된 댓글입니다.</span></p></div>';
	                       					} 
	                       					
	                       				} 
	                       				
	                       				// 대댓글
	                       				for (let j in data) {
	                       						
	                       					if(data[j].writerJobName == null) {
	    	                       				data[j].writerJobName = "";
	    	                       			}
	                       						
	                       					if (data[j].parentReplyNo == data[i].replyNo && data[j].replyStatus == 0) {
	                       						html += '<div class="reply nestedReply">'
		                       						+ '<p id="replyNo' +  data[j].replyNo + '">'
		                       						+ '<span>' + data[j].writerName + " " +  data[j].writerJobName  + ' &nbsp;</span>'
		                       						+ '<span style="color: gray;">' + data[j].replyCreateDate + '&nbsp;&nbsp;</span>';
		                       					
		                       					// 자신이 작성한 댓글이면 수정, 삭제 버튼 보이게
				                       			if ('${loginUser.mId}' == data[j].replyWriter) {
				                       				html += '<span class="replyUpdateBtn">'
				                       						+ '<input type="hidden" name="rNo" value="' +  data[j].replyNo + '">'
				                       						+ editBtnArea;
				                       			}
		                       						
				                       			// 댓글 내용 개행문자 줄바꿈 처리
			                       				html += '<br><span class="rContent">' + data[j].replyContent.replace(newLineChar, '<br>') + '</span></p></div>';
	                       					}
	                       				}
	                       				
	                       			}
	                       			
	                       			$('#replyCount').text(replyCount);

	                       			replyArea.append(html);
	                       			
	                       		}
	                       		
								// 마우스 호버시 댓글 수정 삭제 버튼 보이게 하는 js 
	                       		$(document).on('mouseenter', '.reply', function(){
	                       			$(this).children().find('.replyUpdateBtn').show();
 	                       		}).on('mouseleave', '.reply', function(){
 	                       			$(this).children().find('.replyUpdateBtn').hide();
 	                       		});

	                       		
	                       		// 댓글 수정 버튼 클릭
	                       		$(document).on('click', '.replyEditFormBtn', function() {
	                       			let replyNo = $(this).prev().val();
	                       			
	                       			let replyContent = $('p[id=replyNo' +  replyNo + ']').find('.rContent').html();
	                       			replyContent =  replyContent.replace(/<br>/g, '\n');
		                       		
		                       		// 수정 버튼 클릭시 댓글 수정 화면으로 보이게 함
		                       		let html = "";
		                       		html += '<div class="replyEditArea">'
		                       				  +	'<textarea class="form-control" rows="1" maxlength="160">' + replyContent  + '</textarea>'
		                       				  + '<button type="button" class="replyEditCancelBtn btn btn-sm btn-outline-dark">취소</button>'
		                       				  + '<button type="button" class="replyEditBtn btn btn-sm btn-outline-dark">저장</button>'
		      								  + '<input type="hidden" name="rNo" value="' + replyNo  +  '"></div>';
		                       		
		      						$('.replyEditArea').remove();
		                       		$('p[id=replyNo' +  replyNo + ']').parent().append(html)
		                       		$('p[id=replyNo' +  replyNo + ']').find('.rContent').hide();
		                       		
		                       		$('.nestedReplywriteFormBtn').find('span').text('답댓글');
                       				$('.nestedReplyWrite').hide();
		                       				
	                       		});
	                       		
	                       		// 댓글 수정 취소
	                       		$(document).on('click', '.replyEditCancelBtn', function() {
	                       			$('.replyEditArea').remove();
	                       			$('.rContent').show();
	                       		});
	                       		
	                       		// 댓글 수정내용 저장
								$(document).on('click', '.replyEditBtn', function() {
									let replyNo = $(this).next().val();
									let replyContent = $(this).prev().prev().val();
									let refBNum = '${board.bNum}';
									
									if (replyContent.trim() == "") {
	 	                       			alert('내용이 비어있습니다.');
	 	                       		} else {
		 	                       		$.ajax({
	               							url: 'updateReply.nb',
	               							data: {replyContent:replyContent, replyNo:replyNo, refBNum:refBNum},
	               							type: 'POST',
	               							dataType: 'json',
	               							success: function(data){
	               								console.log(data);
	               								if (data.length > 0) {
	               									updateReplyArea(data);
	               								} else {
	               									alert('알 수 없는 에러가 발생했습니다.', '', 'error');
	               								}
	               							},
	               							error: function(data){
	               								console.log(data);
	               								alert('알 수 없는 에러가 발생했습니다.', '', 'error');
	               							}
	                       				});
	 	                       		}
									
	                       		});
	                       		
	                       		// 댓글 삭제
	                       		$(document).on('click', '.replyDeleteBtn', function() {
	                       			let refBNum = '${board.bNum}';
	                       			let replyNo = $(this).prev().prev().val();
	                       			
	                       			console.log(replyNo)
	                       			
	                       			Swal.fire({
				        				title : '정말 삭제하시겠습니까?', 
				        				customClass : 'sweet-size', 
				        				showCancelButton: true,
				        				confirmButtonText: '삭제',
		                       		 	cancelButtonText: '취소'	
	                       			}).then((result) => {
	                       				if (result.value) {
	                       					$.ajax({
		               							url: 'deleteReply.nb',
		               							data: {replyNo:replyNo, refBNum:refBNum},
		               							type: 'POST',
		               							dataType: 'json',
		               							success: function(data){
		               								console.log(data);
		               								if (data.length > 0) {
		               									updateReplyArea(data);
		               								} else {
		               									alert('알 수 없는 에러가 발생했습니다.', '', 'error');
		               								}
		               							},
		               							error: function(data){
		               								console.log(data);
		               								alert('알 수 없는 에러가 발생했습니다.', '', 'error');
		               							}
		                       				});
	                       				}
	                       			});
	                       		});

	                       		// 게시글 수정 성공시 success 알럿창 띄우기
	                			$(function(){
	                				console.log('${message}')
	                				if ('${message}' != '') {
	                					alert('수정되었습니다.');
	                					<c:remove var="message" scope="request"/>
	                					
										let qureyString = "?bNum=${ board.bNum }&page=${page}"
										<c:if test="${ searchValue ne null }">
											qureyString += "&searchCondition=${ searchCondition }&searchValue=${searchValue}"
										</c:if>		
										
		                				history.replaceState({}, null, location.pathname + qureyString);
	                				}
	                			});
                       			
                       			// sweet alert customize
				        		var alert = function(msg, title, icon) {
				        			Swal.fire({
				        				position: 'top', // top : 상단 중앙에 띄우기
				        				background: '#292B30', // 알럿창 배경색
					       				color: 'white', // 글자색
				        				title : title, // 제목(큰 글씨)
				        				text : msg, // 내용(작은 글씨)
				        				icon: icon, // info, error 등 icon type
				        				timer : 2000, // 자동 종료 타이머
				        				customClass : 'sweet-size', 
				        				showConfirmButton : false // ok버튼 표시 여부
				        			});
				        		}
                       		</script> 
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--**********************************
            Content body end
        ***********************************-->

        <!--**********************************
            Footer start
        ***********************************-->
        <div class="footer">
            <div class="copyright">
                <p>Copyright © Designed &amp; Developed by <a href="${contextPath}/home.do" target="_blank">CODEUS</a> 2021</p>
            </div>
        </div>
        <!--**********************************
            Footer end
        ***********************************-->      
          
    </div>
    <!--**********************************
        Main wrapper end
    ***********************************-->
    
   <!--**********************************
        Scripts
    ***********************************-->											
</body>
</html>