<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> Member Detail</title>
<style>
	.profile-photo img{width: 150px; height: 150px; margin-top: 30px; margin-left: 30px;}
	.member-info{color: black; font-size: medium;}
	.col-form-label{font-weight: bolder; width: 150px;}
	.form-col{padding-left: 15px;}
	.member-info input[type=date], .member-info input[type=text], .member-info select{display: inline;  width: 150px;}
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
                       <b style="color: black; font-size: large;">사원 상세</b>
                   	</div>
                    <div class="col-sm-6 p-md-0 justify-content-sm-end mt-2 mt-sm-0 d-flex">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item">조직 관리</li>
                            <li class="breadcrumb-item active">사원 상세</li>
                        </ol>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body">
                           		<div class="member-info">
                                    <form action="${ contextPath }/admin/mupdate.ad" method="post">
                                    	<div class="email-left-box px-0 mb-5">
		                                	<div class="profile-photo">
		                                    	<c:if test="${ member.imgChangeName eq null }">
				                                	<img src="${contextPath}/resources/assets/images/empty-profile.png" alt="profile-image">
				                               	</c:if>
				                               	<c:if test="${ member.imgChangeName ne null }">
				                                 	<img src="${contextPath}/resources/uploadFiles/${ member.imgChangeName }" alt="profile-image">
				                               	</c:if>
				                       		</div>
		                               	</div>	
		                               	<br>
		                               	<div class="email-right-box ml-0 ml-sm-4 ml-sm-0">
			                               	<label class="col-form-label">이름</label>${ member.mName }
			                               	<br>
			                               	<label class="col-form-label">아이디</label>${ member.mId }
			                               	<input type="hidden" name="mId" value="${ member.mId }">
											<br>
			                               	<label class="col-form-label">이메일</label>${ member.email }
			                               	<br>
			                               	<label class="col-form-label">생년월일</label>${ member.birthDate }
			                               	<br>
			                               	<label class="col-form-label">전화번호</label>${ member.phone }
			                               	<br>
			                               	<label class="col-form-label">주소</label>${ member.address }
			                               	<br>
			                               	<div class="form-group row">
	                                             <label class="form-col col-form-label">자기소개</label>
	                                             <div class="col-lg-6">
	                                                 <textarea rows="3" class="form-control" style="resize: none; width: 400px;" disabled>${ member.profile }</textarea>
	                                             </div>
	                                        </div>
	                                        <label class="col-form-label">부서</label>
	                                        <select class="form-control" name="deptId">
	                                        	<option value="">부서 선택</option>
	                                        	<c:forEach var="d" items="${ dList }">
	                                        		<c:if test="${ member.deptId == d.deptId }">
	                                        			<option value="${ d.deptId }" selected>${ d.deptName }</option>
	                                        		</c:if>
	                                        		<c:if test="${ member.deptId != d.deptId }">
	                                        			<option value="${ d.deptId }">${ d.deptName }</option>
	                                        		</c:if>	                                        		
	                                        	</c:forEach>
	                                        </select>
	                                        <br>
	                                        <label class="col-form-label">직위</label>
	                                        <select class="form-control" name="jobId">
	                                        	<option value="">직위 선택</option>
						                    	<c:forEach var="j" items="${ jList }">
						                    		<c:if test="${ member.jobId == j.jobId }">
						                    			<option value="${ j.jobId }" selected>${ j.jobName }</option>
						                    		</c:if>
						                    		<c:if test="${ member.jobId != j.jobId }">
						                    			<option value="${ j.jobId }">${ j.jobName }</option>
						                    		</c:if>
						                    	</c:forEach>	                                        	
	                                        </select>
	                                        <br>
	                                        <label class="col-form-label">입사일</label>
	                                        <input type="text" id="hireDate" class="form-control" name="inputHireDate" value="${ member.hireDate }" readonly>
	                                        <br>                                        
	                                        <label class="col-form-label">퇴사일</label>
	                                        <input type="text" id="endDate" class="form-control" name="inputEndDate" value="${ member.endDate }" readonly>
	                                        <br>                   
	                                        <label class="col-form-label">계정 상태</label>
	                                        <c:if test="${ member.status == 0 }">
	                                        	<input id="normal" type="radio" name="status" value="0" checked> 정상&nbsp;&nbsp; &nbsp;
	                                        	<input id="pause" type="radio" name="status" value="1"> 중지
	                                        </c:if>
	                                        <c:if test="${ member.status == 1 }">
	                                        	<input id="normal" type="radio" name="status" value="0"> 정상&nbsp;&nbsp; &nbsp;
	                                        	<input id="pause" type="radio" name="status" value="1" checked> 중지
	                                        </c:if>
	                                        <c:if test="${ member.status == 2 }">
	                                        	<input type="hidden" name="status" value="2"> 승인 대기
	                                        </c:if>                                        
	                                        <br>
	                                       
	                                        <c:if test="${ member.managerYn == 'Y' && member.status != 2 && member.mId != 'admin'}">
	                                        	<label class="col-form-label">관리자 여부</label>
	                                        	<input type="checkbox" name="managerYn" value="Y" checked> 
	                                        </c:if>
	                                        <c:if test="${ member.managerYn != 'Y' && member.status != 2 && member.mId != 'admin'}">
	                                        	<label class="col-form-label">관리자 여부</label>
	                                        	<input type="checkbox" name="managerYn" value="Y"> 
	                                        </c:if>
	                                        <c:if test="${ member.mId == 'admin' }"> <!-- 최초 관리자 계정은 관리자 설정 해제 불가 -->
	                                        	<label class="col-form-label">관리자 여부</label>
	                                        	<input type="checkbox" name="managerYn" value="Y" checked disabled="disabled">
	                                        </c:if>	
	                                        <c:if test="${ member.status == 2 }">
	                                        	<input type="hidden" name="managerYn" value="N">
	                                        </c:if>		                                        	                                                                            
	                                        <br><br>
                                       </div>
                                       <input type="hidden" name="page" value="${ page }">
                                       <c:if test="${ searchValue != null }">
									   	   <input type="hidden" name="selectDept" value="${ selectDept }">
	                                       <input type="hidden" name="selectJob" value="${ selectJob }">
	                                       <input type="hidden" name="searchValue" value="${ searchValue }">		
                                       </c:if>
                                        <div align="center">
                                        	<button class="btn btn-primary" id="btnSubmit">저장</button>
	                                        <button type="reset" class="btn btn-outline-primary">취소</button>
	                                        <c:if test="${ searchValue != null }"> 
		                                        <c:url value="msearch.ad" var="msearch">
		                                        	<c:param name="page" value="${ page }"/>
													<c:param name="selectDept" value="${ selectDept }"/>
													<c:param name="selectJob" value="${ selectJob }"/>
													<c:param name="searchValue" value="${ searchValue }"/>
		                                        </c:url>
		                                        <button type="button" class="btn btn-outline-primary" onclick="location.href='${ msearch }'">목록으로</button>
	                                        </c:if>
	                                        <c:if test="${ searchValue == null }">
	                                        	<button type="button" class="btn btn-outline-primary" onclick="location.href='mlist.ad?page=' + '${ page }'">목록으로</button>
	                                        </c:if>
                                        </div>
                                    </form>
                                </div>
                                <script>
									$('#pause').on('click', function(){
										if($(this).val() == 1 && $('input[name=managerYn]').prop('checked')) {
											Swal.fire('계정을 중지시키려면\n 먼저 관리자 설정을 해제하여 주세요.');
											$('#normal').prop('checked', true);
										} 
									});                 
                                	
									$('input[name=managerYn]').on('click', function(){
										if($('#pause').prop('checked') && $(this).prop('checked')) {
											Swal.fire('관리자로 설정하려면\n 계정 상태가 정상이어야 합니다.');
											$(this).prop('checked', false);
										} 
									}); 
									
									// 수정 성공시 success 알럿창 띄우기
		                			$(function(){
		                				console.log('${selectDept}')
		                				if ('${message}' != '') {
		                					Swal.fire({
			  	                				position: 'top',
			  	                				icon: 'success',
			  	                				title: "변경이 완료되었습니다.",
			  	                				showConfirmButton: false,
			  	                				timer: 1500
			  	                			});
		                					<c:remove var="message" scope="request"/>
		                					
		                					var url = location.pathname + "?mId=" + '${member.mId}' + "&page=" + '${page}';
											if ('${searchValue}' != 'null') {
												url += "&selectDept=" + '${selectDept}' + "&selectJob=" + '${selectJob}' + "&searchValue=" + '${searchValue}';
											}
		                					history.replaceState({}, null, url);
		                				}
		                			});
                                </script>
                                
                                <!-- datepicker cdn  -->
								<script src="http://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
                                <script>
                                	$(function(){
                                		var old_fn = $.datepicker._updateDatepicker;
                                		
                                		$.datepicker._updateDatepicker = function(inst) {
                                			old_fn.call(this, inst);
                                			
                                			var buttonPane = $(this).datepicker("widget").find(".ui-datepicker-buttonpane");
                                    		
                                    		$("<button type='button' class='ui-datepicker-clean ui-state-default ui-priority-primary ui-corner-all'>지우기</button>").appendTo(buttonPane).click(function(ev) {
                                    			$.datepicker._clearDate(inst.input);
                                    		});
                                		}
                                	});
                                	
                                	// 입사일은 퇴사일 이전 날짜만 선택 가능
	                            	$('#hireDate').datepicker({
	                            		dateFormat : 'yy-mm-dd',
	                            		prevText : '이전 달',
	                            		nextText : '다음 달',
	                            		cleanText : '지우기',
	                            		monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월',
	                            				'10월', '11월', '12월' ],
	                            		monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월',
	                            				'9월', '10월', '11월', '12월' ],
	                            		dayNames : [ '일', '월', '화', '수', '목', '금', '토' ],
	                            		dayNamesShort : [ '일', '월', '화', '수', '목', '금', '토' ],
	                            		dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
	                            		showMonthAfterYear : true,
	                            		yearSuffix : '년',
	                            		buttonImageOnly : true,
	                            		changeMonth : true,
	                            		changeYear : true,
	                            		maxDate : new Date('${ member.endDate }'),
	                            		showButtonPanel : true,
	                            		currentText : '오늘 날짜',
	                            		closeText : '닫기',
	                            		showAnim : "slide",
	                            		regional : "ko"
	                            	}).on('change', function() {
	                            		$('#endDate').datepicker("option", "minDate", new Date($(this).val()));
	                            	});
                                	
	                            	// 퇴사일은 입사일 이후 날짜만 선택 가능
	                            	$('#endDate').datepicker({
	                            		dateFormat : 'yy-mm-dd',
	                            		prevText : '이전 달',
	                            		nextText : '다음 달',
	                            		cleanText : '지우기',
	                            		monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월',
	                            				'10월', '11월', '12월' ],
	                            		monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월',
	                            				'9월', '10월', '11월', '12월' ],
	                            		dayNames : [ '일', '월', '화', '수', '목', '금', '토' ],
	                            		dayNamesShort : [ '일', '월', '화', '수', '목', '금', '토' ],
	                            		dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
	                            		showMonthAfterYear : true,
	                            		yearSuffix : '년',
	                            		buttonImageOnly : true,
	                            		changeMonth : true,
	                            		changeYear : true,
	                            		minDate : new Date('${ member.hireDate }'),
	                            		showButtonPanel : true,
	                            		currentText : '오늘 날짜',
	                            		closeText : '닫기',
	                            		showAnim : "slide",
	                            		regional : "ko" 
	                            	}).on('change', function() {
	                            		$('#hireDate').datepicker("option", "maxDate", new Date($(this).val()));
	                            	});
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
                <p>Copyright © Designed &amp; Developed by <a href="#" target="_blank">CODEUS</a> 2021</p>
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