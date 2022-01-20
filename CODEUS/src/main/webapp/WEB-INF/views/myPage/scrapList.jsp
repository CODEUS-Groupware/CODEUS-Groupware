<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스크랩 글 목록</title>
<style>
	a:hover{cursor: pointer;}
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
                <div class="row page-titles mx-0">
                    <div class="col-sm-6 p-md-0">
                   	</div>
                    <div class="col-sm-6 p-md-0 justify-content-sm-end mt-2 mt-sm-0 d-flex">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item">조직 관리</li>
                            <li class="breadcrumb-item active"><a href="joblist.ad">직위 관리</a></li>
                        </ol>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title" style="font-weight: bold;">스크랩 글 목록</h3>
                            </div>
                            <div class="card-body">
	                        	<div style="float: right; margin-bottom: 10px;">
			                        <button type="button" class="btn btn-primary" id="deleteBtn">스크랩 해제</button>
	                            </div>
	                            
	                            <div class="table-responsive">
	                            	<form id="deleteForm" action="${ contextPath }/scrapDelete.mp" method="post">
		                            	<table id="scrapList" class="table table-hover table-responsive-sm" style="color: black; text-align: center;">
		                                	<thead>
		                                    	<tr>
		                                        	<th scope="col" width="30px"><input type="checkbox" id="checkAll"></th>
		                                            <th scope="col" width="100px">게시판 유형</th>
		                                            <th scope="col" width="500px">제목</th>
		                                            <th scope="col" width="100px">작성자</th>
		                                            <th scope="col" width="100px">작성일</th>
		                                  	</thead>
		                                  	<tbody>
		                                    	<c:if test="${ empty sList }">
		                                       		<tr>
				                                		<td colspan="5">스크랩한 글이 없습니다.</td>
			                                   		</tr>
		                                        </c:if>
		                                        <c:forEach var="s" items="${ sList }">
			                                    	<tr>
				                                		<td><input type="checkbox" class="checkBoard" name="bNum" value="${ s.bNum }"></td>
				                                        <td>${ s.bType }</td>
				                                        <c:if test="${ s.boardStatus == 0 }">
				                                        	<td><a href="noticeBoardDetail.nb?bNum=${ s.bNum }&page=1" style="color: black;">${ s.bTitle }</a></td>
				                                        </c:if>
				                                        <c:if test="${ s.boardStatus == 1 }">
				                                        	 <td style="color: gray;">삭제된 글입니다.</td>
				                                        </c:if>
				                                        <td>${ s.boardWriterName } ${ s.boardWriterJob }</td>
				                                        <td>${ s.createDate  }</td>
			                                        </tr>
		                                       	</c:forEach>
		                                   	</tbody>
		                                </table>
	                            	</form>
	                        	</div>
	                        	<script>
	                       			// 체크박스 선택 js
	                       			$('#checkAll').on('change', function(){
	                       				var checkAll = $(this).prop('checked');
	                       				
	                       				if (checkAll) {
	                       					$('.checkBoard').prop('checked', true);
	                       				} else {
	                       					$('.checkBoard').prop('checked', false);
	                       				}
	                       			});
	                       			
	                       			$(document).on('change', '.checkBoard', function(){
	                       				var checkBoard = document.getElementsByClassName('checkBoard');
	                       				
	                       				var checkFlag = true;
	                       				for (var i in checkBoard) {
	                       					if(checkBoard[i].checked == false) {
	                       						checkFlag = false;
	                       					}
	                       				}
	                       				
	                       				if(checkFlag) {
	                       					$('#checkAll').prop('checked', true);
	                       				} else {
	                       					$('#checkAll').prop('checked', false);
	                       				}
	                       			});	
	                       			
					        		
					        		// 스크랩 취소(삭제)
					        		$(document).on('click', '#deleteBtn', function(){
					        			var checkBoard = document.getElementsByClassName('checkBoard');
					        			
					        			var count = 0;
					        			for(var i in checkBoard) {
					        				console.log(checkBoard[i]);
					        				if(checkBoard[i].checked) {
					        					count++;
					        				}
					        			}
					        			
					        			if (count > 0) {
					        				Swal.fire({
						        				title: count + '개의 항목을 스크랩 해제하시겠습니까?',
				                       			showCancelButton: true,
				                       			confirmButtonText: '삭제',
				                       		 	cancelButtonText: '취소'	
					        				}).then((result) => {
			                       				if (result.value) {
				                       				$('#deleteForm').submit();
				                       			}
			                       			});
					        			} else {
							       			alert('스크랩 해제할 항목을 선택하세요.');
					        			}
					        			
					        		});
					        		
					        		// 스크랩 해제 성공시 success 알럿창 띄우기
		                			$(function(){
		                				if ('${message}' != '') {
		                					alert('스크랩이 해제되었습니다.');
		                					<c:remove var="message" scope="request"/>
		                					history.replaceState({}, null, location.pathname);
		                				}
		                			});
					        		
					        		// sweet alert customize
					        		var alert = function(msg, title, icon) {
					        			Swal.fire({
					        				position: 'top',
					        				background: '#292B30',
						       				color: 'white',
					        				title : title,
					        				text : msg,
					        				icon: icon,
					        				timer : 1500,
					        				customClass : 'sweet-size',
					        				showConfirmButton : false
					        			});
					        		}
	                        	</script>
                            </div>
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