<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Member Management</title>
<style>
	#searchForm select{width: 130px; margin-right: 5px; display: inline;}
	#searchForm button{background: none; border: none;}
	.disabled a:hover{background: white; color: white}
	.search input{display: inline;  width: 150px;}
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
                <div class="row page-titles mx-0">
                    <div class="col-sm-6 p-md-0">
                        <div class="welcome-text">
                        	<span style="color: black; margin-right: 100px;"><b>사원 수</b></span>
                        	<span style="color: black; margin-right: 50px;"><b>${ memberCount[0] }</b>명(정상)</span>
                        	<span style="color: black;"> 중지: <span> ${ memberCount[1] }</span>명</span>
                        </div>
                   	</div>
                    <div class="col-sm-6 p-md-0 justify-content-sm-end mt-2 mt-sm-0 d-flex">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item">조직 관리</li>
                            <li class="breadcrumb-item active"><a href="mlist.ad">사원 관리</a></li>
                        </ol>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title" style="font-weight: bold;">사원 목록</h3>
                            </div>
                            <div class="card-body">
				                <div class="search" style="float: right;">
					                <form id="searchForm" action="${ contextPath }/admin/msearch.ad" method="get">
					                	<select id="selectDept" class="form-control" name="selectDept">
					                    	<option value="">부서</option>  
					                    	<c:forEach var="d" items="${ dList }">
					                    		<c:if test="${ selectDept ne d.deptId }">
					                    			<option value="${ d.deptId }">${ d.deptName }</option>
					                    		</c:if>
					                    		<c:if test="${ selectDept eq d.deptId }">
					                    			<option value="${ d.deptId }" selected>${ d.deptName }</option>
					                    		</c:if>
					                    	</c:forEach>
					                    </select>
					                    <select id="selectJob" class="form-control" name="selectJob">
					                    	<option value="">직위</option>
					                    	<c:forEach var="j" items="${ jList }">
					                    		<c:if test="${ selectJob ne j.jobId }">
					                    			<option value="${ j.jobId }">${ j.jobName }</option>
					                    		</c:if>
					                    		<c:if test="${ selectJob eq j.jobId }">
					                    			<option value="${ j.jobId }" selected>${ j.jobName }</option>
					                    		</c:if>
					                    	</c:forEach>
					                    </select>
					                    <input type="search" class="form-control" name="searchValue"  list="memberList" placeholder="사원 이름" autocomplete="off">
					                    <datalist id="memberList">
			                        	<c:forEach var="m2" items="${ mList2 }">
			                        		<option value="${ m2.mName }"></option>                               		
	 	                                </c:forEach>
			                        </datalist>
					                    
					                    <button><i class="mdi mdi-magnify"></i></button>
					                </form>
					                <script>
					                    $('#selectDept').on('change', function(){
					                    	var selectDept = $(this).val();
					                    	if(selectDept != '부서') {
					                    		$('#searchForm').submit();
					                    	}
					                    });
					                    		
					                    $('#selectJob').on('change', function(){
					                    	var selectJob = $(this).val();
					                    	if(selectJob != '직위') {
					                    		$('#searchForm').submit();
					                    	}
					                    });
					                </script>
				                </div>
				             	<form id="deleteForm" action="${ contextPath }/admin/mdelete.ad" method="post">
	                            	<div style="margin-bottom: 10px;">
					                    <button type="button" class="btn btn-dark" id="btnSubmit">계정 삭제</button>
					                    <!-- Button trigger modal -->
	                                    <button type="button" class="btn btn-dark" id="btnModal" data-toggle="modal" data-target="#updateStatus">계정 상태 변경</button>
	                                    <!-- Modal -->
	                                    <div class="modal fade" id="updateStatus">
	                                        <div class="modal-dialog modal-dialog-centered" role="document">
	                                            <div class="modal-content">
	                                                <div class="modal-header">
	                                                    <h5 class="modal-title">사원 정보 수정</h5>
	                                                    <button type="button" class="close" data-dismiss="modal"><span>&times;</span>
	                                                    </button>
	                                                </div>
	                                                <div class="modal-body" style="color: black;">
	                                                	<p>선택한 사원 <span id="countCheck"></span>명의</p>
	                                                	계정 상태 변경  &nbsp;
	                                                	<select id="mStatus" class="form-control" name="mStatus"  style="width: 100px; display: inline;">
	                                                		<option value="0">정상</option>
	                                                		<option value="1">중지</option>
	                                                	</select>
	                                                </div>
	                                                <div class="modal-footer">
	                                                    <button type="button" class="btn btn-primary" id="btnSubmit2">저장</button>
	                                                    <button type="button" class="btn btn-light" data-dismiss="modal">취소</button>
	                                                </div>
	                                            </div>
	                                        </div>
	                                    </div>
					                </div>
	                                <div class="table-responsive">
	                                    <table class="table table-hover table-responsive-sm" style="color: black; text-align: center;">
	                                        <thead>
	                                            <tr>
	                                                <th scope="col" width="30px"><input type="checkbox" id="checkAll"></th>
	                                                <th scope="col" width="100px">이름</th>
	                                                <th scope="col" width="120px">직위</th>
	                                                <th scope="col" width="150px">부서</th>
	                                                <th scope="col" width="120px">아이디</th>
	                                                <th scope="col" width="180px">이메일</th>
	                                                <th scope="col" width="130px">입사일</th>
	                                                <th scope="col" width="120px">계정 상태</th>
	                                                <th scope="col" width="50px">상세</th>
	                                                <c:set var="loopFlag" value="false"/>
	                                                <c:forEach var="m" items="${ mList }">
	                                                	<c:if test="${ not loopFlag }">
			                                               	<c:if test="${ m.status eq 2 }">  <!-- 가입 대기 상태일 때 -->
			                                               		<th scope="col" width="150px">가입 승인</th>
			                                               		<c:set var="loopFlag" value="true"/>
			                                              	</c:if> 
	                                                	</c:if>
	                                                </c:forEach>
	                                            </tr>
	                                        </thead>
	                                        <tbody>
	                                        	<c:if test="${ empty mList && searchValue ne null }">
	                                        		<tr>
			                                        	<td colspan="9">검색 결과가 없습니다.</td>
		                                         	</tr>
	                                        	</c:if>
	                                        	<c:if test="${ empty mList && searchValue eq null }">
	                                        		<tr>
			                                        	<td colspan="9">등록된 사원이 없습니다.</td>
		                                         	</tr>
	                                        	</c:if>
	                                         	<c:forEach var="m" items="${ mList }">
		                                            <tr>
		                                            	<td><input type="checkbox" class="checkM" name="mId" value="${ m.mId }"></td>
		                                                <td>${ m.mName }</td>
		                                                <td>${ m.jobName }</td>
		                                                <td>${ m.deptName }</td>
		                                                <td>${ m.mId }</td>
		                                                <td>${ m.email }</td>
		                                                <td>${ m.hireDate }</td>
		                                                <td>
			                                                <c:if test="${ m.status eq 0 }">
			                                                	정상
			                                                </c:if>
			                                                <c:if test="${ m.status eq 1 }">
			                                                	중지
			                                                </c:if>
			                                                <c:if test="${ m.status eq 2 }">
			                                                	승인 대기
			                                                </c:if>		                                                		                                                	
		                                                </td>
		                                                <td>
		                                                    <span>
		                                                    	<c:url var="mdetail" value="mdetail.ad">
		                                                    		<c:param name="mId" value="${ m.mId }"/>
		                                                    		<c:param name="page" value="${ pi.currentPage }"/>
		                                                    		<c:if test="${ searchValue ne null }"> <!-- null이 아니면 검색을 했다는 뜻 -->
																		<c:param name="selectDept" value="${ selectDept }"/>
																		<c:param name="selectJob" value="${ selectJob }"/>
																		<c:param name="searchValue" value="${ searchValue }"/>
																	</c:if>	
		                                                    	</c:url>
		                                                        <a href="${ mdetail }" class="mr-4" data-toggle="tooltip"
		                                                            data-placement="top" title="Edit" style="padding-left: 30%;"><i
		                                                                class="fa fa-search color-muted"></i></a>
		<!--                                                         <a href="javascript:void()" data-toggle="tooltip"
		                                                            data-placement="top" title="Close"><i
		                                                                class="fa fa-close color-danger"></i></a> -->
		                                                    </span>
		                                                </td>
		                                                <c:if test="${ m.status eq 2 }"> <!-- 가입 대기 상태일 때 -->
		                                               		<td>
				                                                <div class="btn-group">
				                                                	<input type="hidden" name="joinId" value="${ m.mId }">
								                                    <button type="button" class="btn btn-primary in approveBtn" style="background: #6495ED; border: #6495ED;">승인</button>
								                                    <button type="button" class="btn btn-primary out rejectBtn" style="background: #CD5C5C; border: #CD5C5C;">거부</button> 
								                                </div>
							                                </td>
	                                              		</c:if>
	                                              		<c:if test="${ loopFlag && m.status ne 2 }">
	                                              			<td></td>
	                                              		</c:if>
	                                            	</tr>
	                                            </c:forEach>
	                                        </tbody>
	                                    </table>
	                                </div>
                                </form>
                            </div>
                        
                       		<script>
								// 수정 또는 삭제 성공시 success 알럿창 띄우기
	                			$(function(){
	                				var message = '${message}' == "u" ? "변경이 완료되었습니다." : "계정 삭제가 완료되었습니다.";
	                				
	                				if ('${message}' != '') {
	                					alert(message);
	                					<c:remove var="message" scope="request"/>
		                				history.replaceState({}, null, location.pathname);
	                				}
	                			});
								
                       		
                       			// 체크박스 선택 js
                       			$('#checkAll').on('click', function(){
                       				var checkAll = $(this).prop('checked');
                       				
                       				if (checkAll) {
                       					$('.checkM').prop('checked', true);
                       				} else {
                       					$('.checkM').prop('checked', false);
                       				}
                       			});
                       			
                       			$('.checkM').on('click', function(){
                       				var checkM = document.getElementsByClassName('checkM');
                       				
                       				var checkFlag = true;
                       				for (var i in checkM) {
                       					if(checkM[i].checked == false) {
                       						checkFlag = false;
                       					}
                       				}
                       				
                       				if(checkFlag) {
                       					$('#checkAll').prop('checked', true);
                       				} else {
                       					$('#checkAll').prop('checked', false);
                       				}
                       				
                       			});
                       			
                       			// 계정 삭제 버튼 클릭시 실행하는 함수
                       			$('#btnSubmit').on('click', function(){
                       				
									var checkM = document.getElementsByClassName('checkM');
                       				
                       				var count = 0;
                       				var managerYn = false;
                       				var deptMgrYn = false;
                       				var managerId = "";
                       				var deptMgrId = "";
                       				for (var i in checkM) {
                       					if(checkM[i].checked) {
                       						count++;
                       						<c:forEach items="${ mList }" var="m">
                       							if (checkM[i].value == '${ m.mId }' && '${ m.managerYn }' == 'Y' ) {
                       							 	managerYn = true;
                       							 	if (managerId == "") {
                       							 		managerId = checkM[i].value;
                       							 	} else {
                       							 		managerId += ", " + checkM[i].value;
                       							 	}
                       								
                       							}
                       						</c:forEach>
                       						
                       						<c:forEach items="${ dList }" var="d">
	                   							if (checkM[i].value == '${ d.deptManager }') {
	                   								deptMgrYn = true;
	                   							 	if (deptMgrId == "") {
	                   							 		deptMgrId = checkM[i].value;
	                							 	} else {
	                							 		deptMgrId += ", " + checkM[i].value;
	                							 	}
	                   							}
           									</c:forEach>
                       					}
                       				}                   			
                       				
                       				if (count > 0 && !managerYn && !deptMgrYn) {
                       			 		Swal.fire({
	                       				  title: '선택된 ' + count + '명의 사원을 삭제하시겠습니까?',
	                       				  text: '삭제 후 복구할 수 없습니다.',
	                       				  // icon: 'warning',
	                       				  showCancelButton: true,
	                       				  confirmButtonColor: '#CD5C5C',
	                       				  cancelButtonColor: 'gray',
	                       				  confirmButtonText: '삭제',
	                       				  cancelButtonText: '취소'
	                       				}).then((result) => {
	                       				  if (result.value) {
	                       					$('#deleteForm').submit();
	                       				  }
                       					});
                       				} else if (managerYn) {
                       					alert('삭제하려면, 먼저 관리자 설정을 해제하여 주세요.', managerId + '은 관리자 계정입니다.')
                       				} else if (deptMgrYn) {
                       					alert('삭제하려면, 먼저 부서 책임자 설정을 해제하여 주세요.', deptMgrId + '은 부서 책임자입니다.')
                       				} else {
                       					alert('적용할 사원을 선택하세요.');
                       				}
                       			});
                       			
                       			// 계정 상태 변경 모달창 띄우기 전 모달 내 텍스트 변경
                       			$('#btnModal').on('click', function(){
                       				$(this).attr('data-toggle', '');
                       				
                       				var checkM = document.getElementsByClassName('checkM');
                       				
                       				var count = 0;
                       				for (var i in checkM) {
                       					if(checkM[i].checked) {
                       						count++;
                       					}
                       				}
                       				
                       				if (count > 0) { // 선택한 사원이 1명 이상이면 모달창 띄움
                       					$('#countCheck').html(count);
                       					$(this).attr('data-toggle', 'modal');
                       				} else {
                       					alert('적용할 사원을 선택하세요.');
                       				}
                       			});
                       			
                       			// 사원 정보 수정 모달창에서 상태 변경 저장 버튼 클릭시 실행하는 함수
                       			$('#btnSubmit2').on('click', function(){
									var checkM = document.getElementsByClassName('checkM');
                       				var mStatus = $('#mStatus').val();
                       				
                       				var managerYn = false;
                       				var deptMgrYn = false;
                       				var managerId = "";
                       				var deptMgrId = "";
                       				for (var i in checkM) {
                       					if(checkM[i].checked) {
                       						<c:forEach items="${ mList }" var="m">
                       							if (checkM[i].value == '${ m.mId }' && '${ m.managerYn }' == 'Y') {
                       							 	managerYn = true;
                       							 	if (managerId == "") {
                    							 		managerId = checkM[i].value;
                    							 	} else {
                    							 		managerId += ", " + checkM[i].value;
                    							 	}
                       							}
                       						</c:forEach>
                       						
                       						<c:forEach items="${ dList }" var="d">
	                   							if (checkM[i].value == '${ d.deptManager }') {
	                   								deptMgrYn = true;
	                   							 	if (deptMgrId == "") {
	                   							 		deptMgrId = checkM[i].value;
	                							 	} else {
	                							 		deptMgrId += ", " + checkM[i].value;
	                							 	}
	                   							}
               								</c:forEach>
                       					}
                       				}       
                       				
                       				if ((!managerYn & !deptMgrYn) || mStatus == 0) {
                       					$(this).parents('form').attr('action', '${ contextPath }/admin/mupdatemulti.ad');
                       					$(this).parents('form').submit();
                       				} else if (managerYn) {
                       					alert('계정을 중지하려면, 먼저 관리자 설정을 해제하여 주세요.', managerId + '은 관리자 계정입니다.');
                       				} else {
                       					alert('계정을 중지하려면, 먼저 부서책임자 설정을 해제하여 주세요.', deptMgrId + '은 부서책임자입니다.');
                       				}
                       				                      				
                       			});
                       			
                       			// 가입 승인
                       			$('.approveBtn').on('click', function() {
                       				var checkM = document.getElementsByClassName('checkM');
                       				
                       				for(var i in checkM) {
                       					if(checkM[i].value == $(this).prev().val()) { // 승인하려는 멤버만 선택되어 있게 함
                       						checkM[i].checked = true;
                       					} else {
                       						checkM[i].checked = false;
                       					}
                       				}
                       				
									$('#mStatus').eq(0).attr('selected', 'selected'); // 계정 상태 변경 : 정상  선택
									
                   			 	 	Swal.fire({
	                       				title: '가입을 승인하시겠습니까?',
	                       				text: '승인 후 계정 상태가 정상으로 변경됩니다.',
	                       				showCancelButton: true,
	                       				confirmButtonColor: '#3085d6',
	                       				cancelButtonColor: 'gray',
	                       				confirmButtonText: '승인',
	                       				cancelButtonText: '취소'
	                       			}).then((result) => {
	                       				if (result.value) {
	                       					$(this).parents('form').attr('action', '${ contextPath }/admin/mupdatemulti.ad');
	                           				$(this).parents('form').submit();
	                       				}
                     				});
                       			});
                       			
                       			// 가입 거부
                       			$('.rejectBtn').on('click', function() {
                       				var checkM = document.getElementsByClassName('checkM');
                       				
                       				for(var i in checkM) {
                       					if(checkM[i].value == $(this).prev().prev().val()) { // 가입 거부하려는 멤버만 선택되어 있게 함
                       						checkM[i].checked = true;
                       					} else {
                       						checkM[i].checked = false;
                       					}
                       				}
                       				
                   			 	 	Swal.fire({
	                       				title: '가입을 거부하시겠습니까?',
	                       				text: '계정이 삭제되며 복구할 수 없습니다.',
	                       				showCancelButton: true,
	                       				confirmButtonColor: '#CD5C5C',
	                       				cancelButtonColor: 'gray',
	                       				confirmButtonText: '가입 거부',
	                       				cancelButtonText: '취소'
	                       			}).then((result) => {
	                       				if (result.value) {
	                       					$('#deleteForm').submit();
	                       				}
                     				}); 
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
                        
                            <!-- 페이징 영역 시작 -->
                            <div style="margin-left: auto; margin-right: auto;">
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
													<c:param name="selectDept" value="${ selectDept }"/>
													<c:param name="selectJob" value="${ selectJob }"/>
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
														<c:param name="selectDept" value="${ selectDept }"/>
														<c:param name="selectJob" value="${ selectJob }"/>
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
													<c:param name="selectDept" value="${ selectDept }"/>
													<c:param name="selectJob" value="${ selectJob }"/>
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
                            <!-- 페이징 영역 끝 -->
                            
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