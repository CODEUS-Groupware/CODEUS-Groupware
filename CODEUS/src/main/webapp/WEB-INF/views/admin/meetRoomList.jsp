<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회의실 목록</title>
<style>
	.col-form-label{width: 100px;}
	a:hover{cursor: pointer;}
	.fa-camera:hover{cursor: pointer;}
	.profile-photo img{width: 240px; height: 200px; margin-left: 10px;}
	.profile-photo{position: relative;}
	.profile-photo label{display: inline; position: absolute; top: 180px; left: 220px;}
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
                            <li class="breadcrumb-item">회의실 관리</li>
                            <li class="breadcrumb-item active">회의실 목록</li>
                        </ol>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title" style="font-weight: bold;">회의실 목록</h3>
                            </div>
                            <div class="card-body">
	                        	<div style="float: right; margin-bottom: 10px;">
		                            <!-- Button trigger modal -->
			                       	<button type="button" class="btn btn-primary" id="insertBtnModal" data-toggle="modal" data-target="#insertMeetRoom">회의실 등록</button>
	                            </div>
					              
	                            <!-- Insert Modal -->
	                            <div class="modal fade" id="insertMeetRoom">
	                            	<div class="modal-dialog modal-dialog-centered modal-lg" role="document">
	                                	<div class="modal-content">
		                                	<form id="insertForm" action="meetinsert.ad" method="post" encType="multipart/form-data" onsubmit="return check();">
		                                    	<div class="modal-header">
		                                        	<h5 class="modal-title">회의실 등록</h5>
		                                            <button type="button" class="close" data-dismiss="modal"><span>&times;</span>
		                                            </button>
		                                        </div>
		                                        <div class="modal-body" style="color: black;">
			                                        	<div class="email-left-box px-0 mb-5" style="margin-right: 20px;">
			                                        		<div class="profile-photo">
						                                		<img id="profile-image" src="${contextPath}/resources/assets/images/empty-photo.jpg" alt="profile-image">
						                                		<label for="input-image">
															        <i class="fa fa-camera" style="color: black; font-size: xx-large;"></i>
															    </label>
															    <input type="file" id="input-image" name="uploadFile" accept=".jpg,.jpeg,.png,.gif" style="display: none;"/>
								                       			<div><span style="color: red; margin-left: 10px">*</span><span>회의실 사진</span></div> 
								                       		</div>
						                               	</div>	
				                                        <div class="email-right-box ml-0 ml-sm-4 ml-sm-0 meet-info">
							                               	<span style="color: red;">*</span><label class="col-form-label">회의실 명</label> 
							                               	<input id="meetRoomName" type="text" class="form-control" name="meet_name" maxlength="10" required>
							                               	<span style="color: red;">*</span><label class="form-col col-form-label">회의실 정보</label>
							                               	<textarea rows="5" class="form-control" id="meetInfo" name="meet_info" maxlength="160"></textarea>
					                                        <br>
			                                       		</div>
			                                     </div>
			                                     <div class="modal-footer">
			                                         <button class="btn btn-primary" id="insertBtn">저장</button>
			                                         <button type="button" class="btn btn-light" data-dismiss="modal">취소</button>
			                                     </div>
			                                </form>
	                                    </div>
	                            	</div>
	                          	</div>
	                          	<script>
	                        		// 회의실 등록 버튼 클릭시 모닮창 내용 초기화
	                       			$('#insertBtnModal').on('click', function(){
	                       				$('#profile-image').attr('src', '${contextPath}/resources/assets/images/empty-photo.jpg');
	                       				$('#input-image').val('');
	                       				$('#meetRoomName').val('');
	                       				$('#meetInfo').val('');
	                       			});
	                          		
	                       			$('#meetRoomName').on('change', function(){
	                       				$('#meetRoomName').val($('#meetRoomName').val().trim());
	                       			});
	                       			
	                       			$('#meetInfo').on('change', function(){
	                       				$('#meetInfo').val($('#meetInfo').val().trim());
	                       			});
	                        		
	                          		// 회의실 저장 버튼 클릭시 실행
	                          		function check() {
	                          			
	                          			if ($('#meetRoomName').val().trim() == "") {
	                          				alert('회의실 명은 필수 입력사항입니다.');
	                          				return false;
	                          			} else if ($('#meetInfo').val().trim() == "") {
	                          				alert('회의실 정보는 필수 입력사항입니다.');
	                          				return false;
	                          			} else if ($('#input-image').val() == '') {
	        								alert('회의실 사진 첨부는 필수 사항입니다.');
	        								return false;
	        							} 
	        							return true;
	                          		}
	                          	
	                          	</script>
	                          	<!-- 파일을 읽어서 원하는 영역에 사진 미리보기 띄움 -->
	                          	<script>
		                			function readImage(input) {
		                				if(input.files && input.files[0]) {
	
		                					const reader = new FileReader();
	
		                					reader.onload = function(e){
		                						const previewImage = document.getElementById("profile-image");
		                						previewImage.src = e.target.result;
		                					}
		                						
		                					reader.readAsDataURL(input.files[0]);
		                				}
		                			}
		                							
		                			const inputImage = document.getElementById("input-image");
		                			inputImage.addEventListener("change", function(e){readImage(e.target)});		
                            	</script>
                            	
	                          	<!-- 회의실 목록 테이블 -->
	                            <div class="table-responsive">
	                            	<table id="meetRoomList" class="table table-hover table-responsive-sm" style="color: black; text-align: center;">
	                                	<thead>
	                                    	<tr>
	                                        	<th scope="col" width="200px">회의실 명</th>
	                                        	<th scope="col" width="400px">회의실 정보</th>
	                                       		<th scope="col" width="150px">등록일</th>
	                                       </tr>
	                                  	</thead>
	                                  	<tbody>
	                                    	<c:if test="${ empty meetList }">
	                                       		<tr>
			                                		<td colspan="3">등록된 회의실이 없습니다.</td>
		                                   		</tr>
	                                        </c:if>
	                                        <c:forEach var="meet" items="${ meetList }">
		                                    	<tr>
		                                    		<c:url var="meetDetail" value="meetdetail.ad">
		                                            	<c:param name="meet_no" value="${ meet.meet_no }"/>
		                                            </c:url>
			                                        <td><a href="${ meetDetail }" style="color: black;">${ meet.meet_name }</a></td>
			                                        <td>
			                                        	<c:if test="${ fn:length(meet.meet_info) > 40 }">
			                                        		${ fn:substring(meet.meet_info,0,40) }...
			                                        	</c:if>
			                                        	<c:if test="${ fn:length(meet.meet_info) <= 40 }">
			                                        		${ meet.meet_info }
			                                        	</c:if>
			                                        </td>
			                                        <td>${ meet.meet_regi_date }</td>
		                                        </tr>
	                                       	</c:forEach>
	                                   	</tbody>
	                                </table>
	                        	</div>
	                        	<script>
		                        	
		                        	// 저장 성공시 success 알럿창 띄우기
		                			$(function(){
		                				if ('${message}' != '') {
		                					if ('${message}' == 'd') {
		                						alert('삭제되었습니다.');
		                					} else {
		                						alert('등록되었습니다.');
		                					}
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
					        				timer : 2000,
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