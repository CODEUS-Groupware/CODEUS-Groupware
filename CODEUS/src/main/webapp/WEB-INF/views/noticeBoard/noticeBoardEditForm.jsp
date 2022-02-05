<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<style>
	a:hover{cursor: pointer;}
	.card-body{color: black;}
	.button:hover{cursor: pointer;}
</style>
	<!-- summernote CSS
		============================================ -->
	<link rel="stylesheet" href="${contextPath}/resources/assets/vendor/summernote/summernote-lite.css">

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
                                <h3 class="card-title" style="font-weight: bold; font-size: large;">공지사항 수정</h3>
                            </div>
	                        <div class="card-body" >
	                            		<form id="updateForm" action="nbupdate.nb" method="post">
	                            			<input type="hidden" name="bNum" value="${ board.bNum }">
	                            			<input type="hidden" name="page" value="${ page }">
			                                <c:if test="${ searchValue ne null }">
				                               <input type="hidden" name="searchCondition" value="${ searchCondition }">
		                            		   <input type="hidden" name="searchValue" value="${ searchValue }">
											</c:if>	
	                            			
											<table class="table" style="color: black;">
												<tbody>
													<tr>
														<td> &nbsp;&nbsp;&nbsp;제목</td>
														<td> 
															<input type="text" class="form-control" id="bTitle" name="bTitle" value="${ board.bTitle }">
														</td>
													</tr>
													
													<tr>
														<!-------------- 파일 첨부 영역 시작 -------------->
														<td> 
															<div class="uploadArea" align="center">
																<span style="margin-bottom: 10px;">
																	&nbsp;파일 첨부 
																	<!-- 파일 첨부 관련 안내문구 Popover -->
																	<a data-container="body" data-toggle="popover" data-placement="top" data-content="100MB 이하의 파일로 최대 2개를첨부할 수 있습니다.">
																	<i class="bi bi-question-circle-fill" style="color: gray;"></i></a> 
																</span>
															</div>
														</td>
														<td> 
															<div id="fileUploadArea" style="border: 1px dotted lightgray; min-width: 1000px; min-height: 70px;">
																<div id="uploadBtnArea" align="center" style="margin-top: 10px;">
																	<a class="badge badge-light" id="uploadFileBtn">
																		<label class="button" for="input-file" style="height: 10px;"><i class="bi bi-upload"></i> &nbsp;파일 등록</label>
																	</a>
																	<input type="file" multiple="multiple" id="input-file" accept="" style="display: none;"/>
																</div>
																<div id="fileArea" style="margin-left: 10px;"> <!-- 파일 미리보기 영역  -->
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
								                             			
								                             			<div id="originFile${ f.fileNo }" class="file">
								                             				<input type="hidden" name="deleteYn" value="N">
								                             				<input type="hidden" name="fileOriginName" value="${ f.fileOriginName }">
																			<input type="hidden" name="fileChangeName" value="${ f.fileChangeName }">
																			<input type="hidden" name="filePath" value="${ f.filePath }">
																			<input type="hidden" name="fileSize" value="${ f.fileSize }">
																			<input type="hidden" name="fileNo" value="${ f.fileNo }">
								                             			
									                             			<!-- 이미지 파일인 경우 -->
									                             			<c:if test="${ imgFlag }">
									                             				<!-- 이미지 미리보기  -->
										 					              		<img id="img${ f.fileNo }" src="${contextPath}/resources/uploadFiles/${ f.fileChangeName }" width="100" height="100" download><br>
										 					                	 <a class="badge-s badge-outline-light" onclick="originFileDelete(${ f.fileNo })"><i class="bi bi-x"></i></a>
									 										</c:if>
									 										<!-- 이미지 파일이 아닌 경우-->
									 										<c:if test="${ !imgFlag }">
									 					                	    <a class="badge-s badge-outline-light" onclick="originFileDelete(${ f.fileNo })"><i class="bi bi-x"></i></a>
															                    <!-- 파일 아이콘 결정 -->
															                    <c:set var="iconType" value="${ ext == 'pdf' ? '-pdf' : ext == 'txt' ? '-text' :  ext == 'docx' ? '-word' : '' }"/> 
															                    <i class="bi bi-file-earmark${ iconType }" style="color: #D2B48C;"></i>
								 											</c:if>
								 											<span>${ f.fileOriginName }</span> 
								 											<!-- 파일 사이즈 표기 -->
								 					                		<c:set var="size" value="${  f.fileSize >= 1024 * 1024 ?  f.fileSize / 1024 / 1024 * 100 : f.fileSize / 1024 * 100 }"/> 
								 					                		<c:set var="unit" value="${  f.fileSize >= 1024 * 1024 ?  'MB' : 'KB' }"/> 
								 					                		<fmt:formatNumber var="fileSizeFmt" value="${ size+((size%1>0.5)?(1-(size%1))%1:-(size%1)) }" type="number" pattern="0.00" />
								 					                		<span style="color: gray"> (${ fileSizeFmt / 100 } ${ unit })</span>
								 					                	</div>
								                        			</c:forEach>
																</div>
															</div>
														</td>
														<!-------------- 파일 첨부 영역 끝 -------------->
													</tr>
													<tr>
														<!-------------- summernote 에디터 시작 -------------->
														<td colspan="2">
															<textarea id="summernote" name="bContent">${ board.bContent }</textarea>
														</td>
														<!-------------- summernote 에디터 끝 -------------->		
													</tr>
													<tr>
														<td>상단 고정</td>
														<td>
															<c:if test="${ board.pin == 'Y' }">
																<input type="checkbox" name="pin" value="Y" checked>  
															</c:if>
															<c:if test="${ board.pin != 'Y' }">
																<input type="checkbox" name="pin" value="Y">  
															</c:if>
															<span style="color: gray; font-size: small">&nbsp;상단 고정</span>
														</td>
													</tr>									
												</tbody>
											</table>
											<input type="hidden" name="mId" value="${ loginUser.mId }">
											<div id="btnArea" align="center">
												<button id="submitBtn" type="button" class="btn btn-primary">저장</button>
											</div>
	                            		</form>
	                            		
	                            		<!-------------- 파일 첨부 관련 js 시작 -------------->
			                          	<script>
			                          	
				                          	/**
		                            		 * 다중파일 등록 로직(multiple file upload) - 첨부파일 개수 제한, 용량 제한
		                            		 * 파일명, 사이즈, 이미지 미리보기 제공
		                            		*/
		                            		$(document).on("change", "#input-file", addFile);
				                          	
			                          		// 현재 업로드된 파일 개수
			                          		let fileCount = 0;
			                          		// 최대 파일 개수
			                          		let totalCount = 2;
			                          		// file 고유 번호
			                          		let fileNo = 0;
			                         		// 첨부파일 배열
			                          		let filesArr = new Array();
			                         		
			                         		$(function() {
			                         			fileCount = Number('${ fn:length(fileList) }');
			                         			console.log(fileCount)
			                         		});
				                			
				                          	function addFile(e) {
				                          		let files = e.target.files;
				                				let tempFilesArr = Array.prototype.slice.call(files); // 매개변수로 넘어온 값들을 array로 변환
				                				let maxSize =  1024 * 1024 * 100;
				                				
												console.log(tempFilesArr);
												
												// 현재 업로드된 개수가  최대 파일 개수를 넘었다면 알럿창 띄우고 파일 업로드 제한
												if(fileCount >= totalCount) {
													alert("최대  " + totalCount + "개의 파일을 첨부할 수 있습니다.");
												} else if (files.length > 0) { // 최대 파일 개수 넘지 않고 파일이 제대로 들어왔을시 실행
													
													let loopCount = files.length; // for문 반복 횟수 설정

													// 파일 입력 개수 2개로 제한
				                					if (fileCount + files.length > totalCount) {
				                						 alert("최대  " + totalCount + "개의 파일을 첨부할 수 있습니다.");
				                						 loopCount = totalCount - fileCount; // 최대 2개만 업로드될 수 있게 loopCount 조정
				                					}
													
													// 선택한 파일 filesArr배열에 담고 화면에 표시
 													for (let i = 0; i < loopCount; i++) {
 														let fileSize = tempFilesArr[i].size;
 														let ext = tempFilesArr[i].name.substring(tempFilesArr[i].name.indexOf(".") + 1);
 														
 														// 파일 용량 제한
 					                			 		if(fileSize > maxSize){
 					                						// 용량 초과시 경고후 해당 파일의 용량도 보여줌
 					                						alert(tempFilesArr[i].name + '의 용량 : ' + (Math.round(fileSize / 1024 / 1024*100) / 100) + 'MB', '100MB 이하의 파일만 등록할 수 있습니다.');
 					                					} else if ($.inArray(ext, ['exe', 'zip']) == 1) {
 					                						alert('확장자가 [exe, zip]인 파일은 첨부할 수 없습니다.');
 					                					} else {
 					                						filesArr.push(tempFilesArr[i]); // file배열에 push
 					                						fileNo++;
 					                						fileCount++;
 					                						
 					                						// 파일 사이즈 표기
 					                						if(fileSize >= 1024*1024) { // 104857 B = 1024 KB = 1 MB 
 					                							fileSize = (Math.round(fileSize / 1024 / 1024*100) / 100) + 'MB';
 					                						} else {
 					                							fileSize = (Math.round(fileSize / 1024*100) / 100) + 'KB';
 					                						}
 					                						
 					                						// 파일 div 영역에 append
 					                						// 파일 확장자에 따른 아이콘 표기
 					                						let icon = ext == 'pdf' ? '-pdf' : ext == 'txt' ? '-text' :  ext == 'docx' ? '-word' : '';
 					                						
 					                						let html = "";
 					                						if (tempFilesArr[i].type.includes('image')) {
 							                					
 					                							html += '<div id="file' + fileNo + '">'
 					                									 + '<img id="img' + fileNo + '" src="" width="100" height="100"><br>'
 					                									 + '<a class="badge-s badge-outline-light" onclick="fileDelete(' + fileNo + ')"><i class="bi bi-x"></i></a>';
 					                						} else {
 					                							html += '<div id="file' + fileNo + '"><a class="badge-s badge-outline-light" onclick="fileDelete(' + fileNo + ')"><i class="bi bi-x"></i></a>'
	 					                								 + '<i class="bi bi-file-earmark' + icon +  '" style="color: #D2B48C;"></i>';
 					                						}
 					                						
 					                						html +=  '<span> ' + tempFilesArr[i].name + '</span>'
			                							     		  + '<span style="color: gray"> (' + fileSize  + ')</span></div>';
 					                						
 					                						$('#fileArea').append(html);
 					                						
 					                						if (tempFilesArr[i].type.includes('image')) { 
 					                							previewImage(tempFilesArr[i], "img" + fileNo);
 					                						}
 					                					}
 														
													}
				                				} 
												
												$("#input-file").val(''); // input-file태그 vlaue 초기화
				                          	}
				                          	
				                       		// 이미지 미리보기
				                          	function previewImage(file, elementId) {
												const reader = new FileReader();
												
		                						reader.readAsDataURL(file);
	                							
			                					reader.onload = function(e){
			                						let previewImg = document.getElementById(elementId);
			                						previewImg.src = e.target.result;	
			                					}
				                          	}
				                       		
				                       		// 기존 파일 삭제 체크
				                       		function originFileDelete(fileNo) {
				                       			console.log(fileNo);
				                       			
				                       			$('#originFile' + fileNo).find('input[name=deleteYn]').remove();
				                       			$('#originFile' + fileNo).prepend('<input type="hidden" name="deleteYn" value="Y">');
				                       			$('#originFile' + fileNo).hide();
				                       			console.log(fileNo);
				                       			fileCount--;
				                       		}
				                       		
				                       		// 파일 삭제(새로 업로드된 파일)
				                       		function fileDelete(fileNo) {
				                       			$('#file' + fileNo).remove();
				                       			filesArr[fileNo - 1].isDelete = true;
				                       			fileCount--;
				                       		}
				                          	
				                			// 제목 공백 제거
			                          		$('#bTitle').on('change', function(){
			                          			$(this).val($(this).val().trim());
			                          		});
			                          		
			                          		// 등록 버튼 클릭시 실행하는 함수(multiple file upload)
			                          		$('#submitBtn').on('click', function() {
			                          			let content = $('#summernote').val();
			                          			let replaceStr = content.replace(/<p>|&nbsp;|<br>|<\/p>/gi, ''); // 내용이 비어있는지 확인
			                          			
			                          			if($('#bTitle').val().trim() == "") {
			                          				alert('제목이 비어있습니다.');
			                          				$('#bTitle').focus();
			                          			} else if (replaceStr.trim() == "") {
			                          				alert('내용이 비어있습니다.');
			                          			} else {
			                          				
			                          				// 삭제했던 썸머노트 에디터 내 이미지파일 드라이브에서도 삭제
                            						for(let i in summernoteDeleteFileArr) {
                            							deleteFile(summernoteDeleteFileArr[i]);
                            						}
			                          				
			                          				// 첨부파일이 존재하면
													if (filesArr.length > 0) {
														
														// ajax로 파일 upload
				                          				fileData = new FormData();
				                          				
														let fileExist = false;
														for (let i = 0; i < filesArr.length; i++) {
															// 삭제하지 않은 것만 담음
															if(!filesArr[i].isDelete){
																fileData.append("files",  filesArr[i]);
																fileExist = true;
															}
														}
														
														if (fileExist) {
															$.ajax({
					                          					url: "uploadFiles.nb",
					                          					data: fileData,
					                          					dataType: 'json',
					                          					type : "POST",
					                            				contentType : false,
					                            				processData : false,
					                            				enctype : 'multipart/form-data',
					                            				success: function(data) {
					                            					console.log(data);
					                            					
					                            					// 파일 저장 성공하면 DB에 파일 정보 저장하기 위해 form에 파일 정보를 value로 가지는 input태그 추가
					                            					if (data.length > 0) {
					                            						let html = "";
					                            						for (let i in data) {
					                            							html += '<input type="hidden" name="fileOriginName" value="' + data[i].fileOriginName + '">'
					                            								 	+ '<input type="hidden" name="fileChangeName" value="' + data[i].fileChangeName + '">'
					                            								 	+ '<input type="hidden" name="filePath" value="' + data[i].filePath + '">'
					                            									+ '<input type="hidden" name="fileSize" value="' + data[i].fileSize + '">'
							                            							+ '<input type="hidden" name="fileNo" value="0">'
							                            							+ '<input type="hidden" name="deleteYn" value="NEW">';
					                            						}
					                            						
					                            						$('#updateForm').append(html);
					                            						$('#updateForm').submit();
					                            					} else {
					                            						alert('알 수 없는 에러가 발생했습니다.','','error');
					                            					}
					                            				},
					                            				error: function(data) {
					                            					console.log(data);
					                            					alert('알 수 없는 에러가 발생했습니다.','','error');
					                            				}
					                          				});
														} else {
															$('#updateForm').submit();
														}
													} else {
														 $('#updateForm').submit();
													}
			                          			}
			                          		});
				                          	
											// Bootstrap Popover
				                          	$(function () {
											  $('[data-toggle="popover"]').popover({
												  trigger: 'hover' // 마우스 호버시 실행
											  });
											})
											
		                            	</script>
		                            	<!-------------- 파일 첨부 관련 js 끝 -------------->
	                            		    
										<!--**********************************
										       Summernote  Scripts
										***********************************-->
		                            	<script src="${contextPath}/resources/assets/vendor/summernote/summernote-lite.js"></script>
										<script src="${contextPath}/resources/assets/vendor/summernote/lang/summernote-ko-KR.js"></script>
		                            	<script>
		                            	
		                            		let summernoteDeleteFileArr = new Array();
		                            		$(document).ready(function() {
		                            			/**
		                            			*  Summernote toolbar 설정, 에디터 내 파일 업로드 관련 설정
		                            			*/
		                            			$('#summernote').summernote({
		                            				  toolbar: [
		                            				    // [groupName, [list of button]]
		                            				    ['style', ['borderBtn', 'style', 'bold', 'italic', 'underline','strikethrough', 'clear']],
		                            				    ['fontname', ['fontname']],
		                            				    ['fontsize', ['fontsize']],
		                            				    ['color', ['forecolor','color']],
		                            				    ['table', ['table']],
		                            				    ['para', ['ul', 'ol', 'paragraph']],
		                            				    ['height', ['height']],
		                            				    ['insert',['picture','link','video']],
		                            				    ['view', ['fullscreen', 'codeview', 'help']],
		                            				  ],
		                            				  fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋움체','바탕체'],
		                            				  fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72'],
		                            				  height: 350,                 // 에디터 높이
		                            				  minHeight: null,             // 최소 높이
		                            				  maxHeight: null,             // 최대 높이
		                            				  focus: true,                 // 에디터 로딩후 포커스를 맞출지 여부
		                            				  lang: "ko-KR",			   // 한글 설정
		                            				  // placeholder: '최대 2048자까지 쓸 수 있습니다',
		                            		          callbacks: {	
		                            		        	  	// 이미지 첨부
															onImageUpload : function(files, editor, welEditable) {
					                            		            // 파일 업로드(다중업로드를 위해 반복문 사용)
					                            		            for (var i = files.length - 1; i >= 0; i--) {
						                            		            uploadSummernoteImageFile(files[i], this);
			                            		            		}
			                            		            },
															onPaste: function (e) {
																	var clipboardData = e.originalEvent.clipboardData;
																	if (clipboardData && clipboardData.items && clipboardData.items.length) {
																		var item = clipboardData.items[0];
																		if (item.kind === 'file' && item.type.indexOf('image/') !== -1) {
																			e.preventDefault();
																		}
																	}
															},
															onMediaDelete : function(target, editor) {
																summernoteDeleteFileArr.push(target[0].src);
													            editor.focus();
													            console.log(summernoteDeleteFileArr);
															}
													  }
		                            			});
		                            		});
		                            		

	                            			/**
	                            			* summernote 이미지 파일 업로드
	                            			*/
	                            			function uploadSummernoteImageFile(file, editor) {
	                            				
	                            				// let acceptExtArr = ['jpg', 'jpeg', 'png', 'gif', 'svg'];
	                            				// let ext = file.name.substring(file.name.indexOf(".") + 1);
	                            				// if (acceptExtArr.indexOf(ext) != -1) {}
	                            				console.log(file);
	                            				
	                            				let imgMaxSize = 1024 * 1024 * 10; // 10MB이하로 제한
	                            				let fileSize = (Math.round(file.size / 1024 / 1024*100) / 100) +'MB';
	                            				let fileName = file.name;
	                            				
	                            				if (!file.type.includes('image')) {
	                            					alert('이미지만 첨부할 수 있습니다.');
	                            				} else if (file.size > imgMaxSize) {
	                            					alert('10MB 이하의 이미지만 첨부할 수 있습니다.');
	                            				} else {
	                            					data = new FormData();
		                            				data.append("file", file);
		                            				$.ajax({
		                            					data : data,
		                            					type : "POST",
		                            					url : "uploadSummernoteImageFile.nb",
		                            					contentType : false,
		                            					processData : false,
		                            					enctype : 'multipart/form-data',
		                            					success : function(data) {
		                            		            	// 업로드된 파일의 url
		                            						$(editor).summernote('insertImage', data.url);
		                            		            	console.log(data.url);
		                            					}
		                            				});
	                            				}
	                            			}
	                            			
											// summernote 이미지 drag and drop
		                            		$("div.note-editable").on('drop',function(e){
										         for(i=0; i< e.originalEvent.dataTransfer.files.length; i++){
										         	uploadSummernoteImageFile(e.originalEvent.dataTransfer.files[i],$("#summernote")[0]);
										         }
										        e.preventDefault();
										    });
											
											
		                            		// summernote 이미지 파일 삭제
		                            		function deleteFile(src) {
		                            		    $.ajax({
		                            		        data: {src : src},
		                            		        type: "POST",
		                            		        url: "deleteSummernoteFile.nb",
		                            		        cache: false,
		                            		        success: function(resp) {
		                            		            console.log(resp);
		                            		        }
		                            		    });
		                            		}
											
		                            		
		                            		// sweet alert customize
		            		        		let alert = function(msg, title, icon) {
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


</body>
											
</html>