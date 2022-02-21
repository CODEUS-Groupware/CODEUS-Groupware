<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자료실</title>
<style>
	.table tbody{font-size: 14px;}
	.table a{color: black; cursor: pointer}
	.modal input{display: inline; width: 200px;}
	.col-form-label{width: 100px;}
	.guide{margin-left: 110px;}
	select{width: 200px;}
	.archiveTable input[type=text]{width: 200px; display: inline-block;}
	.badge{color: black;}
	.renameArea{display: inline-block;}
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
                                <h3 class="card-title" style="font-weight: bold; font-size: large;">전사 자료실</h3>
                            </div>
                            <div class="card-body">
                            	<c:if test="${ capacity ne null }">
                            		<div id="capacityInfo" style="display: inline-block; color: black;">
										<!-- 현재 용량 파일 사이즈 표기 -->
										<c:set var="progressCapacity" value="${ capacity.currentCapacity / capacity.totalCapacity * 100 }%"/>
										 <div class="progress mt-3" style="margin-bottom: 5px;">
		                                    <div class="progress-bar bg-primary" style="width: ${ progressCapacity }; height:6px;" role="progressbar"></div>
		                                </div>
	 					                <c:set var="size" value="${ capacity.currentCapacity >= 1024 * 1024 ?  capacity.currentCapacity / 1024 / 1024 * 100 : capacity.currentCapacity / 1024 * 100 }"/>
	 					                <c:set var="unit" value="${ capacity.currentCapacity >= 1024 * 1024 ?  'MB' : 'KB' }"/> 
	 					                <fmt:formatNumber var="fileSizeFmt" value="${ size+((size%1>0.5)?(1-(size%1))%1:-(size%1)) }" type="number" pattern="0.00" />
                            			현재 용량 : <span style="color: #66CDAA; font-weight: bold;">${ fileSizeFmt / 100 } ${ unit }/</span>
                            			총 용량: <span>${ capacity.totalCapacity / 1073741824 }GB</span>
	                            			
		                            </div>	
                            	</c:if>
                            	<c:if test="${loginUser.managerYn == 'Y' }">
                            		<c:if test="${ capacity ne null }">
                            			<div id="capacityBtn" style="display: inline-block; color: black;">&nbsp;
	                            			<a type="button" class="btn btn-outline-dark modalBtn" data-toggle="modal" data-target="#updateCapacity">
		                            				총 용량 수정</a>
		                            	</div>	
	                            		<div id="btnArea" style="float: right; display: inline-block; color: black;">
	                            			<a class="addFolderModalBtn modalBtn btn btn-outline-dark" data-toggle="modal" data-target="#addFolder">
	                            				<i class="bi bi-folder-fill" style="color: gray"></i> 새 폴더</a>
	                            			<label class="button" for="input-file">
	                            				<a class="fileUploadBtn btn btn-outline-dark">
	                            					<i class="bi bi-upload"></i> 파일 업로드</a>
	                            			</label>
	                            			<form id="uploadFileForm" action="uploadFile.arch" method="post" style="display: inline-block;" enctype="multipart/form-data">
	                            				<input type="file" multiple="multiple" id="input-file" name="uploadFile" style="display: none;">
	                            				<input type="hidden" name="mId" value="${ loginUesr.mId }">
	                            				<c:if test="${ currentFolder != null }">
	                            					<input type="hidden" name="currentFolder" value="${ currentFolder }">
	                            				</c:if>
	                            			</form>
	                            			<c:if test="${fn:length(folderList) > 0}">
	                            				<a class="moveFolderModalBtn modalBtn btn btn-outline-dark" data-toggle="modal" data-target="#moveFolder">이동</a>
	                            			</c:if>
	                            			<a id="filedeleteBtn" class="btn btn-outline-dark">
	                            					<i class="bi bi-trash"></i> 삭제</a>
	                            			<c:if test="${ currentFolder != null }">
	                            				<input type="hidden" name="currentFolder" value="${ currentFolder }">
	                            			</c:if>
	                            		</div>
	                            		
	                            		<!-- addFolder Modal -->
			                            <div class="modal fade" id="addFolder">
			                                <div class="modal-dialog modal-dialog-centered" role="document">
			                                	<div class="modal-content">
			                                    	<div class="modal-header">
			                                        	<h5 class="modal-title">새 폴더</h5>
			                                            <button type="button" class="close" data-dismiss="modal"><span>&times;</span>
			                                            </button>
			                                   		</div>
			                                   		<form id="addFolderForm" action="addFolder.arch" method="post">
				                                        <div class="modal-body" style="color: black;">
				                                        	<div class="modal-body" style="color: black;">
					                                            <span class="text-danger">*</span><label class="col-form-label">폴더 이름</label>
					                                            <input id="folderName" type="text" class="form-control" name="folderName" maxlength="10">
					                                            <br>
					                                        </div>
				                                        </div>
				                                        <input type="hidden" name="upperFolderId" value="${ currentFolder }">
				                                       	<input type="hidden" name="currentFolder" value="${ currentFolder }">
				                                        <div class="modal-footer">
				                                            <button id="addFolderBtn" type="button" class="btn btn-primary">저장</button>
				                                            <button type="button" class="btn btn-light" data-dismiss="modal">취소</button>
				                                        </div>
			                                        </form>
			                                    </div>
			                                </div>
			                         	</div>
			                         	<script>
			                         		$('#addFolderBtn').on('click', function() {
			                         			let folderName = $('#folderName').val().trim();
			                         			$('#folderName').val(folderName);

			                         			if (folderName != "") {
			                         				$('#addFolderForm').submit();
			                         			} else {
			                         				alert('폴더 이름을 입력해주세요.');
			                         			}
			                         		});
			                         		
			                         	</script>
			                         	
			                         	<!-- moveFolder Modal -->
										<div class="modal fade" id="moveFolder">
											<div class="modal-dialog modal-dialog-centered" role="document">
												<div class="modal-content">
													<div class="modal-header">
														<h5 class="modal-title">대상 폴더 선택</h5>
														<button type="button" class="close" data-dismiss="modal">
															<span>&times;</span>
														</button>
													</div>
													<div class="modal-body" style="color: black;">
														<div class="modal-body" style="color: black;">
															<span class="text-danger">*</span><label class="col-form-label">대상 폴더</label> 
															<select id="folderId" name="folderId" class="form-control">
																<option value="">전사 자료실</option>
																<c:forEach var="folder"
																	items="${ hierarchicalFolderList }">
																	<option value="${ folder.folderId }">
																		&nbsp;&nbsp;&nbsp; ${fn:replace(folder.folderName, ' ', "&nbsp;&nbsp;")}
																	</option>
																</c:forEach>
															</select> 
															<span class="guide text-danger"></span><br>
														</div>
													</div>
													<div class="modal-footer">
														<button id="moveFolderBtn" type="button"
															class="btn btn-primary">저장</button>
														<button type="button" class="btn btn-light"
															data-dismiss="modal">취소</button>
													</div>
												</div>
											</div>
										</div>

										<!-- 총 용량 update Modal -->
			                            <div class="modal fade" id="updateCapacity">
			                                <div class="modal-dialog modal-dialog-centered" role="document">
			                                	<div class="modal-content">
			                                    	<div class="modal-header">
			                                        	<h5 class="modal-title">총 용량 수정</h5>
			                                            <button type="button" class="close" data-dismiss="modal"><span>&times;</span>
			                                            </button>
			                                   		</div>
			                                   		<form id="updateCapacityForm" action="capacityUpdate.arch" method="post">
				                                        <div class="modal-body" style="color: black;">
				                                        	<div class="modal-body" style="color: black;">
					                                            <span class="text-danger">*</span><label class="col-form-label">총 용량</label>
					                                            <input id="totalCapacity" type="number" class="form-control" name="totalCapacity" step="1" min="1">GB<br>
					                                            <span class="guide text-danger"></span><br>
					                                        </div>
				                                        </div>
				                                        <input type="hidden" name="currentFolder" value="${ currentFolder }">
				                                        <div class="modal-footer">
				                                            <button id="capacityUpdateBtn" type="button" class="btn btn-primary">저장</button>
				                                            <button type="button" class="btn btn-light" data-dismiss="modal">취소</button>
				                                        </div>
			                                        </form>
			                                    </div>
			                                </div>
			                         	</div>
			                         	
	                            	</c:if>
	                            	<c:if test="${ capacity eq null }">
	                            	
		                            	<div style="display: inline-block;">
		                            		<button type="button" class="btn btn-primary modalBtn" data-toggle="modal" data-target="#insertCapacity">
		                            				총 용량 설정</button>
	                            		</div>
	                            		<!-- 총 용량 insert Modal -->
			                            <div class="modal fade" id="insertCapacity">
			                            	<div class="modal-dialog modal-dialog-centered" role="document">
			                                	<div class="modal-content">
			                                    	<div class="modal-header">
			                                        	<h5 class="modal-title">총 용량 설정</h5>
			                                            <button type="button" class="close" data-dismiss="modal"><span>&times;</span>
			                                            </button>
			                                        </div>
			                                        <form id="insertCapacityForm" action="capacityInsert.arch" method="post">
				                                        <div class="modal-body" style="color: black;">
				                                            <span class="text-danger">*</span><label class="col-form-label">총 용량</label>
				                                            <input id="totalCapacity" type="number" class="form-control" name="totalCapacity" step="1" min="1">GB<br>
				                                            <span class="guide text-danger"></span><br>
				                                        </div>
				                                        <div class="modal-footer">
				                                            <button id="capacityInsertBtn" type="button" class="btn btn-primary">저장</button>
				                                            <button type="button" class="btn btn-light" data-dismiss="modal">취소</button>
				                                        </div>
			                                        </form>
			                                    </div>
			                            	</div>
			                          	</div>
                            		</c:if>
                            	</c:if>
                            	<script>
                            		
                           			//  모달창 열시 input 값 초기화
					        		$('.modalBtn').on('click', function(){ 
					        			$('#totalCapacity').val('');
					        			$('.guide').text('');
					        			$('.modal-body').find('input').val('');
					        		});
	                       			
	                       			$('#totalCapacity').on('change', function(){
	                       				let totalCapacity = document.getElementById('totalCapacity');
	                       				
	                       				if (totalCapacity.value.trim() == "" || totalCapacity.value.trim() < 1) {
	                       					$('.guide').text('1 이상의 숫자를 입력해주세요.');
	                       					totalCapacity.focus();
	                       				} else {
	                       					$('.guide').text('');
	                       				}
	                       			});
	                       			
					        		// 총 용량 등록
 					        		$('#capacityInsertBtn').on('click', function(){
 					        			let totalCapacity = document.getElementById('totalCapacity');
											
 					        			if (totalCapacity.value.trim() == "" || totalCapacity.value.trim() < 1) {
	                       					$('.guide').text('1 이상의 숫자를 입력해주세요.');
	                       					totalCapacity.focus();
	                       				} else {
	                       					$('#insertCapacityForm').submit();
	                       				}
 					        		});
					        		
					        		$('#capacityUpdateBtn').on('click', function(){
 					        			let totalCapacity = document.getElementById('totalCapacity');
 					        			let currCapacity = '${ capacity.currentCapacity }';
 					        			let togalCapacityValue = Number(totalCapacity.value.trim()) * 1073741824;
 					        			
 					        			console.log(togalCapacityValue)
 					        			console.log(currCapacity)
 					        			if (totalCapacity.value.trim() == "" || totalCapacity.value.includes(".") || totalCapacity.value.trim() < 1) {
	                       					$('.guide').text('1 이상의 정수를 입력해주세요.');
	                       					totalCapacity.focus();
	                       				} else if (togalCapacityValue < currCapacity) {
 					        				$('.guide').text('총 용량은 현재 용량보다 크게 설정해야 합니다.');
	                       					totalCapacity.focus();
 					        			} else {
	                       					$('#updateCapacityForm').submit();
	                       				}
 					        		});
					        		
					        		// 파일 업로드
					        		$('#input-file').on('change', function(){
					        			
					        			// 남은 용량(총 용량 - 현재 용량) 이하로만 등록 가능하게 제한
	                            		let currCapacity = Number('${ capacity.currentCapacity }'); // 현재 용량
	                            		let totalCapacity = Number('${ capacity.totalCapacity }'); // 총 용량
	                            		let remainingCapacity = totalCapacity - currCapacity; // 남은 용량
	                            		
			                          	let files = event.target.files;
			                			let maxSize =  1073741824; // 1GB

			                			for (let i = 0; i < files.length; i++) {
			                				
			                				let fileSize = files[i].size;
			                				let fileName = files[i].name;
			                				
			                				if (fileName.length > 80) {
			                					alert('파일의 이름이 너무 깁니다.');
			                					break;
			                				} if(fileSize > maxSize){
		                						// 용량 초과시 경고 후 해당 파일의 용량도 보여줌
		                						alert(fileName + '의 용량 : ' + (fileSize / (1000 * 1000 * 1000)).toFixed(2) + 'GB', '1GB 이하의 파일만 등록할 수 있습니다.');
		                						break;
			                				} else if (fileSize > remainingCapacity) {
		                						// 자료실의 남은 용량보다 파일 사이즈가 크면 등록 불가
		                						alert('자료실 용량 초과로 업로드할 수 없습니다.');
		                						break;
		                					} else {
		                						$('#uploadFileForm').submit();
		                					}
			                			}
			                			
			                			$("#input-file").val(''); // input-file태그 vlaue 초기화		
					        			
					        		});
					        		
					        		// 파일 또는 폴더 삭제
					        		$('#filedeleteBtn').on('click', function() {
					        			console.log(11)
										let checkArr = document.getElementsByClassName('checkOne');
										
										// 선택한 폴더의 하위 폴더가 있는지 확인
					        			let hasChildren = false;
					        			let count = 0;
					        			for(var i in checkArr) {
					        				if(checkArr[i].checked) {
					        					
					        					if (checkArr[i].name == "folderId") {
					        						
					        						<c:forEach var="folder" items="${ folderList }">
					        							if (checkArr[i].value == "${ folder.upperFolderId }") {
					        								hasChildren = true;
					        							}
                                            		</c:forEach>
					        					}
					        					count++;
					        				}
					        			}
					        			
					        			if (hasChildren) {
					        				alert('선택한 폴더 중에 하위 폴더가 존재합니다. 하위 폴더를 먼저 이동 또는 삭제해주세요.');
					        			} else if (count > 0) {
					        				Swal.fire({
						        				title: count + '개의 항목을 삭제하시겠습니까?',
				                       			text: '삭제 후 복구할 수 없습니다.',
				                       			showCancelButton: true,
				                       			confirmButtonText: '삭제',
				                       		 	cancelButtonText: '취소'	
					        				}).then((result) => {
			                       				if (result.value) {
			                       					$('#deleteFileForm').submit();
				                       			}
			                       			});
					        			} else {
							       			alert('삭제할 항목을 선택하세요.');
					        			}
					        			
					        		});
					        		
					        		// 폴더 이동
					        		$('#moveFolderBtn').on('click', function() {
					        			
					        			let targetFolder = $('#folderId').val(); // 이동 대상 폴더
					        			let currFolder = '${ currentFolder }';
					        			let upperFolder = '${ currentUpperFolder }';
					        			console.log(currFolder)
					        			console.log(targetFolder)
										let checkArr = document.getElementsByClassName('checkOne');
					        			
					        			let count = 0;
					        			let folderFlag = false; // 이동하려는 대상이 폴더가 포함되어 있는지 확인
					        			let subFolderFlag = false // 선택한 폴더의 하위폴더가 있는지 확인
					        			let sameFolderFlag = false; // 이동 대상 폴더와 선택한 폴더가 같은지 확인
					        			for(var i in checkArr) {
					        				if(checkArr[i].checked) {
					        					
					        					if(checkArr[i].name == "folderId") {
					        						folderFlag = true; 
					        						
					        						if (checkArr[i].value == targetFolder) {
					        							sameFolderFlag = true;
					        						}
					        						
					        						<c:forEach var="folder" items="${ folderList }">
					        							if (checkArr[i].value == "${ folder.upperFolderId }") {
					        								subFolderFlag = true;
					        							}
                                        			</c:forEach>
					        						
					        					}
												count++;
					        				}
					        			}
					        			
					        			if (subFolderFlag) {
					        				alert('선택한 폴더 중에 하위 폴더가 존재합니다. 하위 폴더를 먼저 이동해주세요.');
					        			} else if (currFolder == targetFolder) {
					        				alert('이동 대상 폴더가 현재 위치한 폴더와 같습니다.');
					        			} else if (sameFolderFlag) {
					        				alert('이동 대상 폴더와 선택한 폴더가 같습니다.');
					        			} else if (currFolder == "" && upperFolder == "" && folderFlag) { // 최상위 폴더는 이동할 수 업게 제한
					        				alert('최상위 폴더는 이동할 수 없습니다.');
					        			} else if (count > 0) {
					        				if (targetFolder != "") {
					        					let targetFolderInput = '<input type="hidden" name="targetFolder" value="' + targetFolder + '">'
						        				
						        				$('#deleteFileForm').append(targetFolderInput);
					        				}
					        				
					        				$('#deleteFileForm').attr('action', 'moveFolder.arch');
					        				$('#deleteFileForm').submit();
					        			} else {
							       			alert('적용할 항목을 선택하세요.');
					        			}
					        			
					        		});
                            	
                            	</script>
	                                <div class="table-responsive">
	                                <form id="deleteFileForm" action="deleteFile.arch" method="post"> 
	                                	<input type="hidden" name="currentFolder" value="${ currentFolder }">
	                                	<input type="text" style="display: none;"> <!-- 엔터키 누를때 자동 submit 방지 위한 input text 태그(text type의 input태그가 2개 이상이어야 방지됨)  -->
	                                	<input type="text" style="display: none;">
	                                    <table class="archiveTable table table-hover table-responsive-sm" style="color: black; text-align: center;">
	                                        <thead>
	                                            <tr style="font-size: large; text-align: left;">
	                                            	<th scope="col" width="30px"  style="text-align: left;"><input type="checkbox" id="checkAll"></th>
	                                                <th scope="col" width="600px">이름</th>
	                                                <th scope="col" width="100px">크기</th>
	                                                <th scope="col" width="50px">확장자</th>
	                                                <th scope="col" width="100px">등록날짜</th>
	                                            </tr>
	                                        </thead>
	                                        <tbody>
	                                        	<c:if test="${ currentFolder != null }">
		                                        		<tr style="text-align: left;">
		                                        			<td></td>
		                                        			<c:url var="archiveUpper" value="archive.arch">
			                                                    <c:param name="currentFolder" value="${ currentUpperFolder }"/>
			                                                </c:url>
		                                        			<td colspan="4"><i class="bi bi-folder-fill" style="color: gray"></i>
		                                        				<a href="${ archiveUpper }">..(상위 폴더로) </a>
		                                        			</td>
		                                        		</tr>
	                                        	</c:if>
	                                        	<c:forEach var="folder" items="${ folderList }">
	                                        		<c:if test="${ folder.upperFolderId == currentFolder }">
	                                        			<tr style="text-align: left;">
	                                        				<td><input type="checkbox" class="checkOne" name="folderId" value="${ folder.folderId }"></td>
		                                        			<c:url var="archive" value="archive.arch">
			                                                    <c:param name="currentFolder" value="${ folder.folderId }"/>
			                                                </c:url>
		                                        			<td colspan="4"><i class="bi bi-folder-fill" style="color: gray"></i>
		                                        				<a href="${ archive }">${ folder.folderName }</a>
		                                        				<c:if test="${loginUser.managerYn == 'Y' }">
		                                        					<a class="renameFolder badge badge-light">이름 수정</a>
		                                        				</c:if>
		                                        				<input type="hidden" id="folderId" value="${ folder.folderId }">
		                                        			</td>
	                                        			</tr>
	                                        		</c:if>
	                                        	</c:forEach>
	                                        	<c:if test="${ empty fileList }">
	                                        		<tr>
			                                        	<td colspan="5">등록된 파일이 없습니다.</td>
		                                         	</tr>
	                                        	</c:if>
	                                        	
	                                         	<c:forEach var="file" items="${ fileList }">
	                                         	
	                                         		<tr style="text-align: left;">
	                                         			<td><input type="checkbox" class="checkOne" name="fileNo" value="${ file.fileNo }/${ file.size }/${ file.changeName }"></td>
		                                                <td>
		                                                	${ file.originName }
		                                                	<a class="badge badge-light" href="${contextPath}/resources/uploadFiles/archive/${ file.changeName }" download> 
		                                                		<i class="bi bi-download"></i> 다운로드</a>
		                                                </td>
		                                                <!-- 현재 용량 파일 사이즈 표기 -->
					 					                <c:set var="size" value="${  file.size >= 1024 * 1024 ?  file.size / 1024 / 1024 * 100 : file.size / 1024 * 100 }"/> 
					 					                <c:set var="unit" value="${  file.size >= 1024 * 1024 ?  'MB' : 'KB' }"/> 
					 					                <fmt:formatNumber var="fileSizeFmt" value="${ size+((size%1>0.5)?(1-(size%1))%1:-(size%1)) }" type="number" pattern="0.00" />
		                                                <td>${ fileSizeFmt / 100 } ${ unit }</td>
		                                                <td>${ file.extension }</td>
		                                                <td>${ file.uploadDate }</td>
	                                            	</tr>
	                                            </c:forEach>
	                                            
	                                        </tbody>
	                                    </table>
	                                    </form>
	                                </div>
                            </div>
                        
                       		<script>
	                       		// 체크박스 선택 js
	                   			$('#checkAll').on('change', function(){
	                   				var checkAll = $(this).prop('checked');
	                   				
	                   				if (checkAll) {
	                   					$('.checkOne').prop('checked', true);
	                   				} else {
	                   					$('.checkOne').prop('checked', false);
	                   				}
	                   			});
	                   			
	                   			$(document).on('change', '.checkOne', function(){
	                   				var checkOne = document.getElementsByClassName('checkOne');
	                   				
	                   				var checkFlag = true;
	                   				for (var i in checkOne) {
	                   					if(checkOne[i].checked == false) {
	                   						checkFlag = false;
	                   					}
	                   				}
	                   				
	                   				if(checkFlag) {
	                   					$('#checkAll').prop('checked', true);
	                   				} else {
	                   					$('#checkAll').prop('checked', false);
	                   				}
	                   			});	
	                   			
	                   			// 폴더 이름 수정
	                   			$('.renameFolder').on('click', function(){
	                   				$(this).prev().hide();
	                   				$(this).hide();
	                   				let folderName = $(this).prev().text();
	                   				let folderId = $(this).next().val();
	                   				
	                   				let html = '<div class="renameArea"><input type="text" class="form-control" maxlength="10" value="' + folderName + '">'
		                       				  + '<a class="updateBtn badge badge-light">수정</a> '
		                       				  + '<a class="cancelBtn badge badge-light">취소</a>'
		      								  + '<input type="hidden" name="folderId" value="' + folderId  +  '"></div>';
	                   				
	                   				$(this).parent().append(html);
	                   			});
	                   			
	                   			// 폴더 이름 수정 정보 저장
	                   			$(document).on('click','.updateBtn', function(){
	                   				
 	                   				let newFolderName = $(this).prev().val().trim();
 	                   				let folderId = $(this).next().next().val();
 	                   				let folder = $(this).parent().prev().prev().prev();
									
 	                   				if (newFolderName != "") {
	 	                   				$.ajax({
		                   					url: 'renameFolder.arch',
		                   					method: 'POST',
		                   					data: {folderName:newFolderName, folderId:folderId},
		                   					success: function(data) {
		                   						console.log(data);
		                   						if (data == 'success') {
		                   							folder.text(newFolderName);
		                   							alert('변경되었습니다.');
		                   						} else {
		                   							alert('알 수 없는 에러가 발생했습니다.', '', 'error');
		                   						}
		                   					},
		                   					error: function(data) {
		                   						console.log(data);
		                   						alert('알 수 없는 에러가 발생했습니다.', '', 'error');
		                   					}
		                   				});
		                   				
		                   				$(this).parent().parent().children().show();
		                   				$(this).parent().remove();
 	                   				} else {
 	                   					alert('내용을 입력하세요.');
 	                   				}
	                   				
	                   			});
	                   			
	                   			
	                   			// 폴더 이름 수정 취소
	                   			$(document).on('click','.cancelBtn', function(){
	                   				$(this).parent().parent().children().show();
	                   				$(this).parent().remove();
	                   			});
	                   			
                       		
								// 작성 또는 삭제 성공시 success 알럿창 띄우기
	                			$(function(){
	                				console.log('${message}')
	                				if ('${message}' != '') {
	                					let msg = '${message}' == 'success' ? '저장되었습니다.' : '삭제되었습니다.';
	                					alert(msg);
	                					<c:remove var="message" scope="request"/>
		                				history.replaceState({}, null, location.pathname + "?currentFolder=" + '${currentFolder}');
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