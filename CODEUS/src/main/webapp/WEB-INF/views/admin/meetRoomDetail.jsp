<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회의실 상세</title>
<style>
	.profile-photo img{width: 280px; height: 240px; margin-left: 10px;}
	.profile-photo{position: relative; margin-top: 30px;}
	.profile-photo label{display: inline; position: absolute; top: 220px; left: 260px;}
	.meetRoom-detail, .meetRoom-update{color: black; font-size: medium;}
	.col-form-label{font-weight: bolder; width: 150px;}
	input. textarea{width: 500px;}
	.display-none{display: none;}
	.fa-camera:hover{cursor: pointer;}
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
                       <b style="color: black; font-size: large;">회의실 상세</b>
                   	</div>
                    <div class="col-sm-6 p-md-0 justify-content-sm-end mt-2 mt-sm-0 d-flex">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item">회의실 관리</li>
                            <li class="breadcrumb-item active">회의실 상세</li>
                        </ol>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body">
                            	<!-- 회의실 상세 정보 화면 -->
                            	<div class="meetRoom-detail">
                                    	<div class="email-left-box px-0 mb-5" style="width: 100px;">
		                                	<div class="profile-photo">
		                                    	<c:if test="${ meetRoom.img_change_name eq null }">
				                                	<img src="${contextPath}/resources/assets/images/empty-photo.jpg" alt="profile-image">
				                               	</c:if>
				                               	<c:if test="${ meetRoom.img_change_name ne null }">
				                                 	<a href="${contextPath}/resources/uploadFiles/${ meetRoom.img_change_name }"><img src="${contextPath}/resources/uploadFiles/${ meetRoom.img_change_name }" alt="profile-image"></a>
				                               	</c:if>
				                       		</div>
		                               	</div>	
		                               	<br>
		                               	<div class="email-right-box ml-0 ml-sm-4 ml-sm-0" style="width: 800px; display: inline-block;">
		                               		<label class="col-form-label">회의실 명</label><br>
		                               		${ meetRoom.meet_name } 
							                <br><br>
							                <label class="form-col col-form-label">회의실 정보</label>
					                        <textarea rows="5" class="form-control" disabled style="resize: none;">${ meetRoom.meet_info }</textarea>
					                        <br>
					                        <label class="form-col col-form-label">등록일</label><br>
					                        ${ meetRoom.meet_regi_date }
					                        <br><br><br>
                                       </div>
                                       <div align="center">
	                                       <button type="button" class="btn btn-primary" id="updateFormBtn">수정하기</button>
	                                       <form id="deleteForm" action="meetdelete.ad" method="post" style="display: inline-block;">
	                                       		<input type="hidden" name="meet_no" value="${ meetRoom.meet_no }">
	                                       		<input type="hidden" name="img_change_name" value="${ meetRoom.img_change_name }"> 
	                                       		<button type="button" class="btn btn-outline-primary" id="deleteBtn">삭제</button>
		                                   </form>
		                                   <button type="button" class="btn btn-outline-primary" onclick="location.href='meetList.ad'">목록으로</button>
	                                   </div>
                                </div>
                                <script>
                                	// 회의실 삭제
                                	$('#deleteBtn').on('click', function(){
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
                                
                                <!-- 회의실 수정 화면 -->
                           		<div class="meetRoom-update display-none">
                                    <form action="meetupdate.ad" method="post" encType="multipart/form-data" onsubmit="return check();">
                                    	<div class="email-left-box px-0 mb-5" style="width: 100px;">
		                                	<div class="profile-photo">
		                                    	<c:if test="${ meetRoom.img_change_name eq null }">
				                                	<img id="profile-image" src="${contextPath}/resources/assets/images/empty-photo.jpg" alt="profile-image">
				                               	</c:if>
				                               	<c:if test="${ meetRoom.img_change_name ne null }">
				                                 	<img id="profile-image" src="${contextPath}/resources/uploadFiles/${ meetRoom.img_change_name }" alt="profile-image">
				                               	</c:if>
				                               	<label for="input-image">
													<i class="fa fa-camera" style="color: black; font-size: xx-large;"></i>
												</label>
						                        <input type="file" id="input-image" name="reloadFile" accept=".jpg,.jpeg,.png,.gif" style="display: none;"/>
				                       		</div>
		                               	</div>	
		                               	<br>
		                               	<div class="email-right-box ml-0 ml-sm-4 ml-sm-0" style="width: 800px; display: inline-block;">
		                               		<span style="color: red;">*</span><label class="col-form-label">회의실 명</label>
							                <input id="meetRoomName" type="text" class="form-control" name="meet_name" value="${ meetRoom.meet_name }" maxlength="10" required>
							                <br>
							                <span style="color: red;">*</span><label class="form-col col-form-label">회의실 정보</label>
							                <textarea rows="5" class="form-control" id="meetInfo" name="meet_info" maxlength="160">${ meetRoom.meet_info }</textarea>
					                        <br>
					                        <label class="form-col col-form-label">등록일</label><br>
					                        ${ meetRoom.meet_regi_date }
					                        <br><br><br>
					                        <input type="hidden" name="meet_no" value="${ meetRoom.meet_no }">
					                        <input type="hidden" name="img_change_name" value="${ meetRoom.img_change_name }"> 
											<input type="hidden" name="img_origin_name" value="${ meetRoom.img_origin_name }">
                                       </div>
                                       <div align="center">
	                                       <button class="btn btn-primary" id="btnSubmit">저장</button>
		                                   <button type="button" id="cancelBtn" class="btn btn-outline-primary">취소</button>
	                                   </div>
                                    </form>
                                </div>
                                <script>
                                	// 수정하기 버튼 클릭시 수정 화면으로 보이게 함
	                                $('#updateFormBtn').on('click', function(){
	                                	$('.meetRoom-detail').hide();
	                            		$('.meetRoom-update').show();
	                            	});
	                                
	                                // 취소 버튼 클릭시 상세 화면으로 보이게 함
	                                $('#cancelBtn').on('click', function(){
	                            		$('.meetRoom-update').hide();
	                            		$('.meetRoom-detail').show();
	                                });
	                                
	                                $('#meetRoomName').on('change', function(){
		                       			$('#meetRoomName').val($('#meetRoomName').val().trim());
		                       		});
		                       			
		                       		$('#meetInfo').on('change', function(){
		                       			$('#meetInfo').val($('#meetInfo').val().trim());
		                       		});
		                        		
		                          	// 저장 버튼 클릭시
		                          	function check() {
		                          			
		                          			if ($('#meetRoomName').val().trim() == "") {
		                          				alert('회의실 명은 필수 입력사항입니다.');
		                          				return false;
		                          			} else if ($('#meetInfo').val().trim() == "") {
		                          				alert('회의실 정보는 필수 입력사항입니다.');
		                          				return false;
		                          			}
		                          			
		        							return true;
		                          	}
		                          	
		                         	// 저장 성공시 success 알럿창 띄우기
		                			$(function(){
		                				if ('${message}' != '') {
		                					alert('등록되었습니다.');
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