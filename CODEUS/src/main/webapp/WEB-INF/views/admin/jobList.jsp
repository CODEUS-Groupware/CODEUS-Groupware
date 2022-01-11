<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style>
	.modal input{display: inline; width: 150px;}
	.col-form-label{width: 100px;}
	a:hover{cursor: pointer;}
	.guide{margin-left: 110px;}
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
                                <h3 class="card-title" style="font-weight: bold;">직위 목록</h3>
                            </div>
                            <div class="card-body">
	                        	<div style="float: right; margin-bottom: 10px;">
		                            <!-- Button trigger modal -->
			                       	<button type="button" class="btn btn-outline-dark" id="insertBtnModal" data-toggle="modal" data-target="#insertJob">직위 추가</button>
			                        <button type="button" class="btn btn-outline-dark" id="deleteBtn">직위 삭제</button>
	                            </div>
					              
	                            <!-- Insert Modal -->
	                            <div class="modal fade" id="insertJob">
	                            	<div class="modal-dialog modal-dialog-centered" role="document">
	                                	<div class="modal-content">
	                                    	<div class="modal-header">
	                                        	<h5 class="modal-title">직위 추가</h5>
	                                            <button type="button" class="close" data-dismiss="modal"><span>&times;</span>
	                                            </button>
	                                        </div>
	                                        <div class="modal-body" style="color: black;">
	                                        	<span style="color: red;">*</span><label class="col-form-label">명칭</label> 
	                                            <input id="jobName1" type="text" class="form-control" name="jobName" maxlength="10"><br>
	                                            <span id="jobNameGuide1" class="guide text-danger"></span><br>
	                                            <span class="text-danger">*</span><label class="col-form-label">정렬 순서</label>
	                                            <input id="jobOrder1" type="number" class="form-control" name="jobOrder" step="1" min="1"><br>
	                                            <span id="jobOrderGuide1" class="guide text-danger"></span><br>
	                                        </div>
	                                        <div class="modal-footer">
	                                            <button type="button" class="btn btn-primary" id="insertBtn">저장</button>
	                                            <button type="button" class="btn btn-light" data-dismiss="modal">취소</button>
	                                        </div>
	                                    </div>
	                            	</div>
	                          	</div>
	                          	
	                            <!-- Update Modal -->
	                            <div class="modal fade" id="updateJob">
	                                <div class="modal-dialog modal-dialog-centered" role="document">
	                                	<div class="modal-content">
	                                    	<div class="modal-header">
	                                        	<h5 class="modal-title">직위 수정</h5>
	                                            <button type="button" class="close" data-dismiss="modal"><span>&times;</span>
	                                            </button>
	                                   		</div>
	                                        <div class="modal-body" style="color: black;">
	                                        	<span class="text-danger">*</span><label class="col-form-label">명칭</label>
	                                            <input id="jobName2" type="text" class="form-control" name="jobName" maxlength="10"><br>
	                                            <span id="jobNameGuide2" class="guide text-danger"></span><br>
	                                            <span class="text-danger">*</span><label class="col-form-label">정렬 순서</label>
	                                            <input id="jobOrder2" type="number" class="form-control" name="jobOrder" step="1" min="1"><br>
	                                            <span id="jobOrderGuide2" class="guide text-danger"></span><br>
	                                        </div>
	                                        <input id="jobId" type="hidden" name="jobId">
	                                        <div class="modal-footer">
	                                        	<button type="button" class="btn btn-primary" id="updateBtn">저장</button>
	                                            <button type="button" class="btn btn-light" data-dismiss="modal">취소</button>
	                                        </div>
	                                    </div>
	                                </div>
	                         	</div>
	                            <div class="table-responsive">
	                            	<table id="jobList" class="table table-hover table-responsive-sm" style="color: black; text-align: center;">
	                                	<thead>
	                                    	<tr>
	                                        	<th scope="col" width="30px"><input type="checkbox" id="checkAll"></th>
	                                       		<th scope="col" width="200px">명칭</th>
	                                            <th scope="col" width="100px">정렬 순서</th>
	                                            <th scope="col" width="100px">사용 인원수</th>
	                                       </tr>
	                                  	</thead>
	                                  	<tbody>
	                                    	<c:if test="${ empty jList }">
	                                       		<tr>
			                                		<td colspan="4">등록된 직위가 없습니다.</td>
		                                   		</tr>
	                                        </c:if>
	                                        <c:forEach var="j" items="${ jList }">
		                                    	<tr>
			                                		<td><input type="checkbox" class="checkJ" name="jobId" value="${ j.jobId }"></td>
			                                        <td><a class="updateBtnModal" data-toggle="modal" data-target="#updateJob">${ j.jobName }</a></td>
			                                        <td>${ j.jobOrder }</td>
			                                        <td>${ j.memberCount }</td>
		                                        </tr>
	                                       	</c:forEach>
	                                   	</tbody>
	                                </table>
	                        	</div>
	                        	<script>
	                       			// 체크박스 선택 js
	                       			$('#checkAll').on('change', function(){
	                       				var checkAll = $(this).prop('checked');
	                       				
	                       				if (checkAll) {
	                       					$('.checkJ').prop('checked', true);
	                       				} else {
	                       					$('.checkJ').prop('checked', false);
	                       				}
	                       			});
	                       			
	                       			$(document).on('change', '.checkJ', function(){
	                       				var checkJ = document.getElementsByClassName('checkJ');
	                       				
	                       				var checkFlag = true;
	                       				for (var i in checkJ) {
	                       					if(checkJ[i].checked == false) {
	                       						checkFlag = false;
	                       					}
	                       				}
	                       				
	                       				if(checkFlag) {
	                       					$('#checkAll').prop('checked', true);
	                       				} else {
	                       					$('#checkAll').prop('checked', false);
	                       				}
	                       			});	
	                       			
	                       			// 직위 추가시 직위 명칭 중복 검사 및 핖수 입력 안내
	                       			var dupCheck = false;
	                       			
					        		$('#insertBtnModal').on('click', function(){ // 직위 추가 모달창 열시 input 값 초기화
					        			$('#insertJob').find('input').val('');
					        			$('#insertJob').find('.guide').text('');
					        			dupCheck = false;
					        		});
	                       			
	                       			$('#jobName1').on('change', function(){
	                       				dupCheck = false;
	                       				var jobName = document.getElementById('jobName1');
	                       				jobName.value = jobName.value.trim();
	                       				var jobNameArr = document.getElementsByClassName('updateBtnModal');
	                       				
	                       				if(jobName.value.trim().length < 1 || jobName.value.trim().length > 10) {									        			
	                       					$('#jobNameGuide1').text('1~10자리까지 입력해주세요.');
	                       					jobName.focus();
	                       				} else {
	                       					for (var i in jobNameArr) {
	                       						if(jobName.value.trim() == jobNameArr[i].text) {
			                       					dupCheck = true;
			                       				}
	                       					}
	                       				
		                       				if (dupCheck) {
		                       					$('#jobNameGuide1').text('이미 사용 중인 직위 명칭입니다.');
		                       					jobName.focus();
		                       				} else {
		                       					$('#jobNameGuide1').text('');
		                       				}
		                       			}
	                       				
	                       			});
	                       			
	                       			$('#jobOrder1').on('change', function(){
	                       				var jobOrder = document.getElementById('jobOrder1');
	                       				
	                       				if (jobOrder.value == "" || jobOrder.value < 1) {
	                       					$('#jobOrderGuide1').text('1 이상의 숫자를 입력해주세요.');
	                       					jobOrder.focus();
	                       				} else {
	                       					$('#jobOrderGuide1').text('');
	                       				}
	                       			});
	                       			
					        		// 직위 추가
					        		$(document).on('click', '#insertBtn', function(){
										var jobName = document.getElementById('jobName1');
										var jobOrder = document.getElementById('jobOrder1');
											
										if(jobName.value.trim().length < 1 || jobName.value.trim().length > 10) {	
	                       					jobName.focus();
	                       				} else if (jobOrder.value == "" || jobOrder.value < 1) {
	                       					jobOrder.focus();
	                       				} else if (dupCheck) {
	                       					jobName.focus();
	                       				} else {
											$.ajax({
												url: 'jinsert.ad',
		                       					dataType: 'json',
		                       					data: {jobName:jobName.value, jobOrder:jobOrder.value},
		                       					type: 'POST',
		                       					success: function(data){
		                       						
		                       						var jobList = $('#jobList tbody');
		                       						jobList.html('');
		                       						
		                       						var html = "";
		                       						if(data.length > 0) {
		                       							for(var i in data) {
		                       								html += '<tr><td><input type="checkbox" class="checkJ" name="jobId" value="' + data[i].jobId + '"></td>'
		                       									 	+ '<td><a class="updateBtnModal" data-toggle="modal" data-target="#updateJob">' + data[i].jobName + '</a></td>'
		                       									 	+ '<td>' + data[i].jobOrder + '</td>'
		                       									 	+ '<td>' + data[i].memberCount + '</td></tr>';
		                       								$('#checkAll').prop('checked', false);
		                       							}
		                       						} else {
		                       							html = '<tr><td colspan="4">등록된 직위가 없습니다.</td></tr>';
		                       						}
		                       						
		                       						jobList.append(html);
		                       						$('#insertJob').modal('hide');
		                       						
		                       						alert('저장되었습니다.');		                       						
		                       					},
		                       					error: function(data){
		                       						console.log(data);
		                       						$('#insertJob').modal('hide');
		                       						alert('알 수 없는 오류가 발생했습니다.', '', 'error');
		                       					}
	                       					});
	                       				}
					        		});
					        		
					        		// 직위 수정
					        		var originJobName = "";
					        		
					        		$(document).on('click', '.updateBtnModal', function(){ // 수정 모달창 열릴시 해당 항목 값으로 초기화
					        			$('#updateJob').find('input').val('');
					        			$('#updateJob').find('.guide').text('');
					        			
					        			originJobName = $(this).text();
					        			$('#jobName2').val($(this).text());
					        			$('#jobOrder2').val($(this).parent().parent().children().eq(2).text());
					        			$('#jobId').val($(this).parent().parent().children().eq(0).children().val());
					        			dupCheck = false;
					        		});
					        		
	                       			$('#jobName2').on('change', function(){
	                       				dupCheck = false;
	                       				
	                       				var jobName = document.getElementById('jobName2');
	                       				var jobNameArr = document.getElementsByClassName('updateBtnModal');
	                       				
	                       				if(jobName.value.trim().length < 1 || jobName.value.trim().length > 10) {									        			
	                       					$('#jobNameGuide2').text('1~10자리까지 입력해주세요.');
	                       					jobName.focus();
	                       				} else {
	                       					for (var i in jobNameArr) {
	                       						if(jobName.value.trim() == jobNameArr[i].text && jobName.value.trim() != originJobName) {
			                       					dupCheck = true;
			                       				}
	                       					}
	                       				
		                       				if (dupCheck) {
		                       					$('#jobNameGuide2').text('이미 사용 중인 직위 명칭입니다.');
		                       					jobName.focus();
		                       				} else {
		                       					$('#jobNameGuide2').text('');
		                       				}
		                       			}
	                       				
	                       			});
	                       			
	                       			$('#jobOrder2').on('change', function(){
	                       				var jobOrder = document.getElementById('jobOrder2');
	                       				
	                       				if (jobOrder.value == "" || jobOrder.value < 1) {
	                       					$('#jobOrderGuide2').text('1 이상의 숫자를 입력해주세요.');
	                       					jobOrder.focus();
	                       				} else {
	                       					$('#jobOrderGuide2').text('');
	                       				}
	                       			});
	                       			
					        		$(document).on('click', '#updateBtn', function(){
										var jobName = document.getElementById('jobName2');
										var jobOrder = document.getElementById('jobOrder2');
											
										if(jobName.value.trim().length < 1 || jobName.value.trim().length > 10) {	
	                       					jobName.focus();
	                       				} else if (jobOrder.value == "" || jobOrder.value < 1) {
	                       					jobOrder.focus();
	                       				} else if (dupCheck) {
	                       					jobName.focus();
	                       				} else {
											$.ajax({
												url: 'jupdate.ad',
		                       					dataType: 'json',
		                       					data: {jobId:$('#jobId').val(), jobName:jobName.value, jobOrder:jobOrder.value},
		                       					type: 'POST',
		                       					success: function(data){
		                       						
		                       						var jobList = $('#jobList tbody');
		                       						jobList.html('');
		                       						
		                       						var html = "";
		                       						if(data.length > 0) {
		                       							for(var i in data) {
		                       								html += '<tr><td><input type="checkbox" class="checkJ" name="jobId" value="' + data[i].jobId + '"></td>'
		                       									 	+ '<td><a class="updateBtnModal" data-toggle="modal" data-target="#updateJob">' + data[i].jobName + '</a></td>'
		                       									 	+ '<td>' + data[i].jobOrder + '</td>'
		                       									 	+ '<td>' + data[i].memberCount + '</td></tr>';
		                       								$('#checkAll').prop('checked', false);
		                       							}
		                       						} else {
		                       							html = '<tr><td colspan="4">등록된 직위가 없습니다.</td></tr>';
		                       						}
		                       						
		                       						jobList.append(html);
		                       						$('#updateJob').modal('hide');
		                       						
		                       						alert('변경되었습니다.');	                       						
		                       					},
		                       					error: function(data){
		                       						console.log(data);
		                       						$('#updateJob').modal('hide');
		                       						alert('알 수 없는 오류가 발생했습니다.', '', 'error');
		                       					}
	                       					});
	                       				}
					        		});
					        		
					        		
					        		// 직위 삭제
					        		$(document).on('click', '#deleteBtn', function(){
					        			var checkJ = document.getElementsByClassName('checkJ');
					        			
					        			var jobIdArr = [];
					        			var userCheck = false;
					        			for(var i in checkJ) {
					        				console.log(checkJ[i]);
					        				if(checkJ[i].checked) {
					        					jobIdArr.push(checkJ[i].value);
												
					        					if($('#jobList').find('input[value=' + checkJ[i].value + ']').parent().parent().children().eq(3).text() > 0 ){
					        						userCheck = true;
					        					}
					        				}
					        			}
					        			
					        			if (jobIdArr.length > 0 && !userCheck) {
					        				Swal.fire({
						        				title: jobIdArr.length + '개의 항목을 삭제하시겠습니까?',
				                       			text: '삭제 후 복구할 수 없습니다.',
				                       			// icon: 'warning',
				                       			showCancelButton: true,
				                       			confirmButtonColor: '#CD5C5C',
				                       			cancelButtonColor: 'gray',
				                       			confirmButtonText: '삭제',
				                       		 	cancelButtonText: '취소'	
					        				}).then((result) => {
			                       				if (result.value) {
				                       				$.ajax({
				                       					url: 'jdelete.ad',
				                       					dataType: 'json',
				                       					traditional : true, // 배열 전송 위한 옵션
				                       					data: {jobIdArr:jobIdArr},
				                       					type: 'POST',
				                       					success: function(data){
				                       						
				                       						var jobList = $('#jobList tbody');
				                       						jobList.html('');
				                       						
				                       						var html = "";
				                       						if(data.length > 0) {
				                       							for(var i in data) {
				                       								html += '<tr><td><input type="checkbox" class="checkJ" name="jobId" value="' + data[i].jobId + '"></td>'
				                       									 	+ '<td><a class="updateBtnModal" data-toggle="modal" data-target="#updateJob">' + data[i].jobName + '</a></td>'
				                       									 	+ '<td>' + data[i].jobOrder + '</td>'
				                       									 	+ '<td>' + data[i].memberCount + '</td></tr>';
				                       								$('#checkAll').prop('checked', false);
				                       							}
				                       						} else {
				                       							html = '<tr><td colspan="4">등록된 직위가 없습니다.</td></tr>';
				                       						}
				                       						
				                       						jobList.append(html);
				                       						alert("삭제되었습니다.");
				                       						
				                       					},
				                       					error: function(data){
				                       						console.log(data);
				                       						alert('알 수 없는 오류가 발생했습니다.', '', 'error');
				                       					}
				                       				});
				                       			}
			                       			});
					        			} else if (userCheck){
					        				alert('사용 인원이 있는 직위는 삭제할 수 없습니다.');
					        			} else {
							       			alert('삭제할 항목을 선택하세요.');
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