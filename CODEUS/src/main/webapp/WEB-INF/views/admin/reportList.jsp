<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신고글 관리</title>
<style>
	#searchForm button{background: none; border: none;}
	.disabled a:hover{background: white; color: white}
	.searchArea input{display: inline;  width: 150px;}
	.searchArea select{display: inline;  width: 100px;}
	.searchArea select, .searchArea input{font-size: small;}
	.writeFormBtn{color: #696969; font-size: 15px; font-weight: bold;}
	.table tbody{font-size: 14px;}
	.table a{color: black;}
</style>
</head>
<body>

    <!--**********************************
        Main wrapper start
    ***********************************-->
    <div id="main-wrapper">	

		<c:import url="../common/menubar_admin.jsp"/>
    
        <!--**********************************
            Content body start
        ***********************************-->
        <div class="content-body">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title" style="font-weight: bold; font-size: large;">신고글 관리</h3>
                            </div>
                            <div class="card-body">
                            	<div class="default-tab">
                                    <ul class="nav nav-tabs" role="tablist">
                                        <li class="nav-item">
                                            <a class="nav-link active" data-toggle="tab" href="#boardArea">게시글 신고</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" data-toggle="tab" href="#replyArea">댓글 신고</a>
                                        </li>
                                    </ul>
                                    <div class="tab-content">
                                        <div class="tab-pane fade show active" id="boardArea" role="tabpanel">
                                            <div class="pt-4">
                                            	<div class="table-responsive">
				                                    <form id="handingBoardForm" action="handingBoardReport.ad" method="post">
				                                    	<input type="hidden" name="page" value="${ pi.currentPage }">
					                                    <table class="table table-hover table-responsive-sm" style="color: black; text-align: center;">
					                                        <thead>
					                                            <tr style="font-size: large;">
					                                                <th scope="col" width="400px">글 제목</th>
					                                                <th scope="col" width="120px">글 작성자</th>
					                                                <th scope="col" width="120px">게시판 유형</th>
					                                                <th scope="col" width="150px">신고 유형</th>
					                                                <th scope="col" width="120px">신고일</th>
					                                                <th scope="col" width="100px">처리 상태</th>
					                                                <th scope="col" width="100px">게시글 상세</th>
					                                                <c:set var="boardLoopFlag" value="false"/>
					                                                <c:forEach var="br" items="${ boardReportList }">
					                                                	<c:if test="${ not boardLoopFlag }">
							                                               	<c:if test="${ br.reportStatus eq 0 }">  <!-- 처리 대기 상태일 때 -->
							                                               		<th scope="col" width="200px">신고 처리</th>
							                                               		<c:set var="boardLoopFlag" value="true"/>
							                                              	</c:if> 
					                                                	</c:if>
					                                                </c:forEach>
					                                            </tr>
					                                        </thead>
					                                        <tbody>
					                                        	<c:if test="${ empty boardReportList }">
					                                        		<tr>
							                                        	<td colspan="9">등록된 신고가 없습니다.</td>
						                                         	</tr>
					                                        	</c:if>
					                                         	<c:forEach var="br" items="${ boardReportList }">
					                                         		<tr>
					                                         			<td>
					                                         				<c:if test="${ fn:length(br.bTitle) <= 10 }">
												                                  ${ br.bTitle }
												                            </c:if>
												                            <c:if test="${ fn:length(br.bTitle) > 10 }">
													                              ${ fn:substring(br.bTitle,0,10) }...
													                        </c:if>
					                                         			</td>
						                                                <td>${ br.writerName } ${ br.writerJobName }</td>
						                                                <td>${ br.bType }</td>
						                                                <td>
						                                                	<c:set var="reportType" value="${ br.reportType == 'A' ? '부적절한 내용' : '광고성'}"/>
						                                                	${ reportType }
						                                                </td>
						                                                <td>${ br.reportDate }</td>
						                                                <td>
						                                                	<c:set var="reportStatus" value="${ br.reportStatus == 0 ? '처리 대기' : br.reportStatus == 1 ? '삭제' : '신고 취소'}"/>
						                                                	${ reportStatus }
						                                                </td>
						                                                <td>
						                                                	<c:set var="url" value="${ br.bType == '자유' ? 'CommBoardDetail.bo' : 'marketDetail.bo' }"/>
					                                         				<c:url var="BoardReportDetail" value="${ url }">
								                                                <c:param name="bId" value="${ br.bNum }"/>
								                                                <c:param name="page" value="${ pi.currentPage }"/>
							                                                </c:url>
					                                         				<a href="${ contextPath }/${ BoardReportDetail }" class="mr-4" data-toggle="tooltip"
			                                                            		data-placement="top" title="Edit" style="padding-left: 30%;"><i
			                                                                	class="fa fa-search color-muted"></i>
					                                         				</a>
					                                         			</td>
					                                         			<c:if test="${ br.reportStatus eq 0 }"> <!-- 처리 대기 상태일 때 -->
						                                               		<td>
								                                                <div class="btn-group">
								                                                	<input type="hidden" value="${ br.reportNo }">
								                                                	<input type="hidden" value="${ br.bNum }">
												                                    <button type="button" class="btn btn-primary in boardDeleteBtn" style="background: #CD5C5C; border: #CD5C5C;">삭제</button>
												                                    <button type="button" class="btn btn-primary out boardCancelBtn" style="background: #6495ED; border: #6495ED;">신고 취소</button> 
												                                </div>
											                                </td>
					                                              		</c:if>
					                                              		<c:if test="${ boardLoopFlag && br.reportStatus ne 0 }">
					                                              			<td></td>
					                                              		</c:if>
					                                            	</tr>
					                                            </c:forEach>
					                                        </tbody>
					                                    </table>
					                            	</form>
				                                </div>
                                            </div>
                                        </div>
                                        <script>
                                        	$('.boardDeleteBtn').on('click', function(){
                                        		let reportNo = $(this).prev().prev().val();
                                        		let bNum = $(this).prev().val();
                                        		let reportStatus = 1;
                                        		
                                        		let html = '<input type="hidden" name="reportNo" value="' + reportNo + '">'
                                        				   + '<input type="hidden" name="reportStatus" value="' + reportStatus + '">'
                                        				   + '<input type="hidden" name="bNum" value="' + bNum + '">';
                                        		
                                        		Swal.fire({
                       	                       		title: '게시글을 삭제하시겠습니까?',
                       	                       		showCancelButton: true,
                       	                       		confirmButtonText: '삭제',
                       	                       		cancelButtonText: '닫기'
                       	                       	}).then((result) => {
                       	                       		if (result.value) {
	                       	                       		$('#handingBoardForm').append(html);		   
	                                            		$('#handingBoardForm').submit();
                       	                       		}
                                            	}); 
                                        		
                                        	});
                                        	
                                        	$('.boardCancelBtn').on('click', function(){
                                        		let reportNo = $(this).prev().prev().prev().val();
                                        		let bNum = $(this).prev().prev().val();
                                        		let reportStatus = 2;
                                        		
                                        		let html = '<input type="hidden" name="reportNo" value="' + reportNo + '">'
			                             				   + '<input type="hidden" name="reportStatus" value="' + reportStatus + '">'
			                             				   + '<input type="hidden" name="bNum" value="' + bNum + '">';
                                        		
                                        		Swal.fire({
                                 	            	title: '신고 취소 처리하시겠습니까?',
                                 	                showCancelButton: true,
                                 	                confirmButtonText: '신고 취소',
                                 	                cancelButtonText: '닫기'
                                 	            }).then((result) => {
                                 	                 if (result.value) {
          	                       	                     $('#handingBoardForm').append(html);		   
          	                                             $('#handingBoardForm').submit();
                                 	                 }
                                                }); 
                                        	});
                                        </script>
                                        
                                        
                                        <div class="tab-pane fade" id="replyArea">
                                            <div class="pt-4">
                                                <div class="table-responsive">
                                                	<form id="handingReplyForm" action="handingReplyReport.ad" method="post">
	                                                	<input type="hidden" name="page" value="${ pi.currentPage }">
					                                    <table class="table table-hover table-responsive-sm" style="color: black; text-align: center;">
					                                        <thead>
					                                            <tr style="font-size: large;">
					                                                <th scope="col" width="400px">댓글 내용</th>
					                                                <th scope="col" width="120px">댓글 작성자</th>
					                                                <th scope="col" width="120px">게시판 유형</th>
					                                                <th scope="col" width="150px">신고 유형</th>
					                                                <th scope="col" width="120px">신고일</th>
					                                                <th scope="col" width="100px">처리 상태</th>
					                                                <th scope="col" width="100px">게시글 상세</th>
					                                                <c:set var="replyLoopFlag" value="false"/>
					                                                <c:forEach var="r" items="${ replyReportList }">
					                                                	<c:if test="${ not replyLoopFlag }">
							                                               	<c:if test="${ r.reportStatus eq 0 }">  <!-- 처리 대기 상태일 때 -->
							                                               		<th scope="col" width="200px">신고 처리</th>
							                                               		<c:set var="replyLoopFlag" value="true"/>
							                                              	</c:if> 
					                                                	</c:if>
					                                                </c:forEach>
					                                            </tr>
					                                        </thead>
					                                        <tbody>
					                                        	<c:if test="${ empty replyReportList }">
					                                        		<tr>
							                                        	<td colspan="9">등록된 신고가 없습니다.</td>
						                                         	</tr>
					                                        	</c:if>
					                                         	<c:forEach var="r" items="${ replyReportList }">
					                                         		<tr>
					                                         			<td>
					                                         				<div id="reply${ r.replyNo }" class="accordion accordion-no-gutter accordion-bordered">
											                                    <div class="accordion__item">
											                                        <div class="accordion__header" data-toggle="collapse" data-target="#bordered_no-gutter_collapseOne${ r.replyNo }">
											                                            <span class="accordion__header--text">
											                                            	<c:if test="${ fn:length(r.replyContent) <= 15 }">
												                                        		${ r.replyContent }
												                                        	</c:if>
												                                 			<c:if test="${ fn:length(r.replyContent) > 15 }">
													                                        	${ fn:substring(r.replyContent,0,15) }...
													                                        </c:if>
													                                   	</span>
											                                            <span class="accordion__header--indicator style_two"></span>
													                                </div>
											                                        <div id="bordered_no-gutter_collapseOne${ r.replyNo }" class="collapse accordion__body show" data-parent="#reply${ r.replyNo }">
											                                            <div class="accordion__body--text">
												                                        	${ r.replyContent }
											                                            </div>
											                                        </div>
											                                    </div>
											                                </div>
					                                         			</td>
					                                         			<td>${ r.writerName } ${ r.writerJobName }</td>
					                                         			<td>${ r.bType }</td>
						                                                <td>
						                                                	<c:set var="reportType" value="${ r.reportType == 'A' ? '부적절한 내용' : '광고성'}"/>
						                                                	${ reportType }
						                                                </td>
						                                                <td>${ r.reportDate }</td>
						                                                <td>
						                                                	<c:set var="reportStatus" value="${ r.reportStatus == 0 ? '처리 대기' : r.reportStatus == 1 ? '삭제' : '신고 취소'}"/>
						                                                	${ reportStatus }
						                                                </td>
						                                                <td>
						                                                	<c:set var="url" value="${ br.bType == '자유' ? 'CommBoardDetail.bo' : 'marketDetail.bo' }"/>
					                                         				<c:url var="ReplyBoardDetail" value="${ url }">
								                                                <c:param name="bId" value="${ r.bNum }"/>
								                                                <c:param name="page" value="${ pi.currentPage }"/>
							                                                </c:url>
					                                         				<a href="${ contextPath }/${ ReplyBoardDetail }" class="mr-4" data-toggle="tooltip"
			                                                            		data-placement="top" title="Edit" style="padding-left: 30%;"><i
			                                                                	class="fa fa-search color-muted"></i>
					                                         				</a>
					                                         			</td>
					                                         			<c:if test="${ r.reportStatus eq 0 }"> <!-- 처리 대기 상태일 때 -->
						                                               		<td>
								                                                <div class="btn-group">
								                                                	<input type="hidden" value="${ r.reportNo }">
								                                                	<input type="hidden" value="${ r.replyNo }">
												                                    <button type="button" class="btn btn-primary in replyDeleteBtn" style="background: #CD5C5C; border: #CD5C5C;">삭제</button>
												                                    <button type="button" class="btn btn-primary out replyCancelBtn" style="background: #6495ED; border: #6495ED;">신고 취소</button> 
												                                </div>
											                                </td>
					                                              		</c:if>
					                                              		<c:if test="${ replyLoopFlag && r.reportStatus ne 0 }">
					                                              			<td></td>
					                                              		</c:if>
					                                            	</tr>
					                                            </c:forEach>
					                                        </tbody>
					                                    </table>
				                                 	</form>
				                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <script>
                                 $('.replyDeleteBtn').on('click', function(){
                                	 let reportNo = $(this).prev().prev().val();
                                	 let replyNo = $(this).prev().val();
                             		 let reportStatus = 1;
                             		
                            		 let html = '<input type="hidden" name="reportNo" value="' + reportNo + '">'
			                   				   + '<input type="hidden" name="reportStatus" value="' + reportStatus + '">'
			                   				   + '<input type="hidden" name="replyNo" value="' + replyNo + '">';
                             				   
                                     Swal.fire({
                             	         title: '댓글을 삭제하시겠습니까?',
                             	         showCancelButton: true,
                             	         confirmButtonText: '삭제',
                             	         cancelButtonText: '닫기'
                             	     }).then((result) => {
                             	         if (result.value) {
      	                       	             $('#handingReplyForm').append(html);		   
      	                                     $('#handingReplyForm').submit();
                             	         }
                                     });                              	
                                 });
                                        	
                                 $('.replyCancelBtn').on('click', function(){
                                	 
                              		 let reportNo = $(this).prev().prev().prev().val();
                              		 let replyNo = $(this).prev().prev().val();
                            		 let reportStatus = 2;
                            		
                            		 let html = '<input type="hidden" name="reportNo" value="' + reportNo + '">'
                             				   + '<input type="hidden" name="reportStatus" value="' + reportStatus + '">'
                             				   + '<input type="hidden" name="replyNo" value="' + replyNo + '">';
                              		
                                     Swal.fire({
                             	         title: '신고 취소 처리하시겠습니까?',
                             	         showCancelButton: true,
                             	         confirmButtonText: '신고 취소',
                             	         cancelButtonText: '닫기'
                             	     }).then((result) => {
                             	         if (result.value) {
      	                       	             $('#handingReplyForm').append(html);		   
      	                                     $('#handingReplyForm').submit();
                             	         }
                                     }); 
                                 });
                            </script>
                       		<script>
								// 작성 또는 삭제 성공시 success 알럿창 띄우기
	                			$(function(){
	                				console.log('${message}')
	                				if ('${message}' != '') {
	                					let msg = '${message}' == 'success' ? '등록되었습니다.' : '삭제되었습니다.';
	                					alert(msg);
	                					<c:remove var="message" scope="request"/>
		                				history.replaceState({}, null, location.pathname);
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
                        
                            <!--------------- 페이징 영역 시작 ---------------->
                            <div id="paging" style="margin-left: auto; margin-right: auto;">
                            	<nav>
                                	<ul class="pagination pagination-xs pagination-circle">
                                		<!-- 이전 -->
                                		<c:if test="${ pi.currentPage <= 1 }">
	                                  		<li class="page-item page-indicator disabled">
	                                        	<a class="page-link">
	                                            	<i class="icon-arrow-left"></i></a>                                     
	                                  		</li>
                                  		</c:if>
                                  		<c:if test="${ pi.currentPage > 1 }">
                                  			<c:url var="before" value="${ loc }">
												<c:param name="page" value="${ pi.currentPage - 1 }"/>
												<c:if test="${ searchValue ne null }"> <!-- null이 아니면 검색을 했다는 뜻 -->
													<c:param name="searchCondition" value="${ searchCondition }"/>
													<c:param name="searchValue" value="${ searchValue }"/>
												</c:if>												
											</c:url>
	                                  		<li class="page-item page-indicator">
	                                        	<a class="page-link" href="${ before }">
	                                            	<i class="icon-arrow-left"></i></a>
	                                        </li>  
                                        </c:if> 
                                        
                                        <!-- 숫자 -->
                                        <c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
	                                        <c:if test="${ p eq pi.currentPage }">
		                                        <li class="page-item active"><a class="page-link">${ p }</a></li>
	                                        </c:if>
	                                        <c:if test="${ p ne pi.currentPage }">
	                                        	<c:url var="pagination" value="${ loc }">
	                                        		<c:param name="page" value="${ p }"/>
	                                        		<c:if test="${ searchValue ne null }"> 
	                                        			<c:param name="searchCondition" value="${ searchCondition }"/>
														<c:param name="searchValue" value="${ searchValue }"/>
													</c:if>	
	                                        	</c:url>
	                                       		<li class="page-item"><a class="page-link" href="${ pagination }">${ p }</a></li>
	                                        </c:if>
                                        </c:forEach>
                                        
                                        <!-- 다음 -->
                                        <c:if test="${ pi.currentPage >= pi.maxPage }">
	                                        <li class="page-item page-indicator disabled">
	                                            <a class="page-link">
	                                                <i class="icon-arrow-right"></i></a>
	                                        </li>
                                        </c:if>
                                         <c:if test="${ pi.currentPage < pi.maxPage }">
                                         	<c:url var="after" value="${ loc }">
                                        		<c:param name="page" value="${ pi.currentPage + 1 }"/>
	                                        	<c:if test="${ searchValue ne null }"> 
	                                        		<c:param name="searchCondition" value="${ searchCondition }"/>
													<c:param name="searchValue" value="${ searchValue }"/>
												</c:if>	                                       		
                                         	</c:url>
	                                        <li class="page-item page-indicator">
	                                            <a class="page-link" href="${ after }">
	                                                <i class="icon-arrow-right"></i></a>
	                                        </li>
                                        </c:if>                                       
                                    </ul>
                                </nav>
                            </div>
                            <!--------------- 페이징 영역 끝 ---------------->
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