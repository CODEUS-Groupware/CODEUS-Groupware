<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style>
	.modal input{display: inline; width: 150px;}
	a:hover{cursor: pointer;}
	.guide{margin-left: 110px;}
	.col-form-label{width: 100px;}
	.form-col{padding-left: 15px;}
	.dept-detail{color: black;}
	.dept-detail input[type=text], .dept-detail input[type=search], .dept-detail select{display: inline;  width: 150px;}
	.tree-div{overflow-x: hidden; color: black;}
	.card-body{min-height: 800px;}
	.bi-person-fill{color: gray;}
	.badge i{color: black;}
	.bi-building{font-weight: bolder;}
	.guide-display{display: none;}
	 .update-guide{margin-left: 140px;}
	#droppable{width: 150px; height: 150px; padding: 0.5em; float: left; margin: 10px;}
	.selectDept{background: #FFE4B5; border:1px dotted #F4A460;}
	.hoverDept{background: #FDF5E6; border:1px dotted #F4A460;}
	.update-form{margin-right: 30px;}
	.dept-label{margin-right: 25px;}
</style>

	<!-- tree viewer CSS
		============================================ -->
	<link rel="stylesheet" href="${contextPath}/resources/assets/vendor/deptList/css/jquery.treeview.css">
	
	<!--  drag and drop 관련 css -->
	<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
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
                            <li class="breadcrumb-item active"><a href="deptlist.ad">부서 관리</a></li>
                        </ol>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-4 card1">
                    	<div class="card">
                           	<div class="card-body tree-div">
                               <h4 class="card-intro-title" style="font-weight: bold;">조직도</h4>
							   <br>
							   <div style="float: right;">
								   <b>부서</b> 
								   <a class="badge badge-light" id="insertDeptBtn" data-toggle="modal" data-target="#insertDeptModal">
								   	<i class="bi bi-plus-lg"></i> 추가
								   </a>
								   <a class="badge badge-light" id="deleteDeptBtn" ><i class="bi bi-dash-lg"></i> 삭제</a>
								   <form id="deleteForm" action="${ contextPath }/admin/ddelete.ad" method="post">
								   		<input id="deleteDeptId" type="hidden" name="deptId">
								   </form>					              
		                            <!-- 부서 추가  Modal창 -->
		                            <div class="modal fade" id="insertDeptModal">
		                            	<div class="modal-dialog modal-dialog-centered" role="document">
		                                	<div class="modal-content">
		                                    	<div class="modal-header">
		                                        	<h5 class="modal-title">부서 추가</h5>
		                                            <button type="button" class="close" data-dismiss="modal"><span>&times;</span>
		                                            </button>
		                                        </div>
		                                        <div class="modal-body" style="color: black;">
		                                        	<span class="text-danger">*</span><label class="col-form-label">부서명</label> 
		                                            <input id="insertDeptName" type="text" class="form-control insertInput" name="deptName" maxlength="10"><br>
		                                            <span id="insertDeptNameGuide" class="guide text-danger"></span><br>
		                                            &nbsp;<label class="col-form-label">부서책임자</label>
		                                            <input id="insertDeptMgr" type="search" class="form-control insertInput" name="deptManager" list="memberList" placeholder="사원 아이디" autocomplete="off">
							                        <datalist id="memberList">
							                        	<c:forEach var="m" items="${ mList }">
							                        		<option value="${ m.mId }">${ m.mName } ${ m.jobName }</option> 
					 	                                 </c:forEach>
							                        </datalist><br>
		                                            <span id="insertDeptMgrGuide" class="guide text-danger"></span><br>
		                                        </div>
		                                        <div class="modal-footer">
		                                            <button type="button" class="btn btn-primary" id="insertBtn">저장</button>
		                                            <button type="button" class="btn btn-light" data-dismiss="modal">취소</button>
		                                        </div>
		                                    </div>
		                            	</div>
		                          </div>
								  <script>
								  	  // 모달창 여는 버튼 클릭시 모달창 안의 내용 초기화
								  	  let existenceCheck = false;
								  	  $('#insertDeptBtn').on('click', function(){
									      $('#insertDeptModal').find('input').val('');
									  	  $('#insertDeptModal').find('.guide').text('');
									  	  existenceCheck = false;
								  	  });
								  	  
								  	  // 부서 추가 모달창에서 부서명 기입시 안내 문구 츨략
								  	  $('#insertDeptName').on('change', function(){
								  		  $(this).val($(this).val().trim()); //  공백 입력시 자동으로 공백 제거되게 함
						                  let deptName = $(this).val();  
								  		  
						                  if (deptName.length < 2 || deptName.length > 10) {
						                	  $('#insertDeptNameGuide').text('2~10자리까지 입력해주세요.');
						                	  $(this).focus();
						                  } else {
						                	  $('#insertDeptNameGuide').text('');
						                  }
								  	  });
								  	  
								  	  // 부서 추가 모달창에서 부서책임자 아이디 입력시 존재하는 사원인지 검증
									  $('#insertDeptMgr').on('change', function(){
									  	  existenceCheck = false; // 부서책임자 입력 값에 변화가 있을시 false로 초기화
									  	  $(this).val($(this).val().trim()); // 공백 입력시 자동으로 공백 제거되게 함
									  	  let deptManager = $(this).val();  
									  	  
									  	  // 입력한 사원 아이디가 존재하는 아이디인지 검증
			                              <c:forEach var="m" items="${ mList }">
								          	if ("${ m.mId }" == deptManager) {
								          		existenceCheck = true;
								          	}
					 	                  </c:forEach>
					 	                  
					 	                  // 만약 멤버리스트에 없는 아이디 입력시 존재하지 않는 사원이라는 안내 문구 출력
						                  if (!existenceCheck && deptManager != "") {
						                	  $('#insertDeptMgrGuide').text('중지된 계정 또는 존재하지 않는 계정입니다.');
						                	  $(this).focus();
						                  } else {
						                	  $('#insertDeptMgrGuide').text('');
						                  }
						              });
								  	  
								  	  // 부서 추가 모달창에서 저장 버튼 클릭시 실행하는 함수
								  	  $(document).on('click', '#insertBtn', function(){
								  		 let upperDept = $('#deptId').val();
								  		 let deptLevel = "";
								  		 
								  		 // 회사 이름 및 부서가 존재하지 않았을시 값 초기화
								  		 if (upperDept == "") {
								  			upperDept = null;
								  			deptLevel = 1;
								  		 } 
								  		 let deptName = $('#insertDeptName').val().trim();  
								  		 let deptManager = $('#insertDeptMgr').val().trim();  
								  		 
								  		 for(let i in deptArr) {
								  		 	if (upperDept == deptArr[i].deptId) {
								  		 		deptLevel = Number(deptArr[i].deptLevel) + 1;
								  		 	}
								  		 }
								  		 
								  		 if (deptName.length < 2 || deptName.length > 10) {
						                	  $('#insertDeptNameGuide').text('2~10자리까지 입력해주세요.');
						                	  $('#insertDeptName').focus();
						                 } else if (!existenceCheck && deptManager != "") {
						                	 $('#insertDeptMgr').focus();
						                 } else {
						                	 $.ajax({
						                		 url: 'dinsert.ad',
						                		 dataType: 'json',
						                		 data: {upperDept:upperDept, deptName:deptName, deptManager:deptManager, deptLevel:deptLevel},
						                	 	 type: 'POST',
						                	 	 success: function(data) {
						                	 		console.log(data);
						                	 		$("#deptList").treeview({});
						                	 		
						                	 		let $rootNode = $('#deptList').find('input[value=' + upperDept + ']').parent().children().last();
						                	 		let $parentLi = $('#deptList').find('input[value=' + upperDept + ']').parent();
						                	 		let $div;
						                	 		let $li;
						            				let $input;
						            				let $a;
						            				let $ul;
						            				if (data != null) {
						            					if (upperDept == null || deptLevel == 2) {
						            						location.reload();
						            					} else if(!$rootNode.hasClass('hasChildren')) {
						            						if ($parentLi.children().find('input').hasClass('newDept') || $parentLi.hasClass('last')) {
						            							$parentLi.addClass('expandable').addClass('lastExpandable').removeClass('last');
						            							$div = $('<div class="hitarea expandable-hitarea lastExpandable-hitarea">');
						            						} else {
						            							$parentLi.addClass('expandable').removeClass('last');
						            							$div = $('<div class="hitarea expandable-hitarea">');
						            						}
						            						
						            						$ul = '<ul class="hasChildren"></ul>';
						            						$parentLi.prepend($div);
						            						$parentLi.append($ul);
						            					} else {
						            						$rootNode.children().last().removeClass('last');
						            						$rootNode.children().last().removeClass('lastExpandable').removeClass('lastCollapsable');
						            						$rootNode.children().last().children().find('div').removeClass('lastExpandable-hitarea');

						            						$li = $('<li class="last">');	
							            					$input = '<input class="newDept" type="hidden" name="deptId" value="' + data.deptId + '">'
							            					$a = '<a class="dept draggable dropable">' + data.deptName + '</a>';
							            					$li.append($input);
							            					$li.append($a);
							            				
										            		$rootNode.append($li);
						            					}
						            					
						            					$('#deptList').find('input[value=' + upperDept + ']').removeClass('lv');
						            					$("#deptList").treeview({});
						            					
									            		deptArr.push(data); // 새로 추가된 요소를 부서 정보가 저장된 객체배열에 추가

									            		$('#insertDeptModal').modal('hide');
						            					alert(data.deptName + " 저장되었습니다.");
						            				}
						                	 	 },
						                	 	 error: function(data) {
						                	 		console.log(data);
						                	 		$('#insertDeptModal').modal('hide');
						                	 		alert("알 수 없는 오류가 발생했습니다.","","error");
						                	 	 }
						                	 })
						                 }
								  	  });
								  	 
								  	// 부서 삭제 버튼 클릭시 실행하는 함수
								  	$(document).on('click', '#deleteDeptBtn', function(){
								  		let deptId = $('#deptId').val().trim();
								  		
								  		let subDeptCount = 0;
								  		for(let i in deptArr) {
			 		            			if(deptId == deptArr[i].upperDept) {
			 		            				subDeptCount++;
			 		            			}
			 		            		}
								  		
								  		let deptMemberCount = 0;
								  		<c:forEach var="m" items="${mList}">
			 		            			if(deptId == '${m.deptId}') {
			 		            				deptMemberCount++;
			 		            			}
			 		            		</c:forEach>
								  		
			 		            		console.log(deptMemberCount);
								  		if (deptId == "") {
								  			alert('삭제할 부서를 선택해주세요.');
								  		} else if (deptId == '${ dList[0].deptId }') {
								  			alert('삭제할 수 없습니다.');
								  		} else if (subDeptCount > 0 ) {
								  			alert('하위 부서를 삭제한 후 삭제 가능합니다.');
								  		} else if (deptMemberCount > 0) {
								  			alert('부서원 부서 이동 후 삭제 가능합니다.');
								  		} else {
								  			Swal.fire({
				                       			title: '정말 삭제하시겠습니까?',
				                       			showCancelButton: true,
				                       			confirmButtonColor: '#CD5C5C',
				                       			cancelButtonColor: 'gray',
				                       			confirmButtonText: '삭제',
				                       		 	cancelButtonText: '취소'	
					        				}).then((result) => {
					        					if (result.value) {
					        						$('#deleteDeptId').val(deptId);
						        					$('#deleteForm').submit();
			                       				}
					        				});
								  		}
								  		
								  	});
								 	 	 
								 	// 삭제 성공시 success 알럿창 띄우기
		                			$(function(){
		                				if ('${message}' != '') {
		                					alert('삭제되었습니다.');
		                					<c:remove var="message" scope="request"/>
			                				history.replaceState({}, null, location.pathname);
		                				}
		                			});
								  </script>
							   </div>
							   <br>
							   <hr>
	                           <div id="treeView">
	                           		<ul id="deptList">
	                           		<c:if test="${ fn:length(dList) != 0 }">
	                                	<li><i class="lv lv1 bi bi-building"></i>
	                                		<input class="lv lv1" type="hidden" name="deptId" value="${ dList[0].deptId }">
	                                		<a class="dept selectDept dropable">${ dList[0].deptName }</a>
		                                	<c:set var="hasChildren" value="false"/> 
		                                    <c:forEach var="m" items="${ mList }">
							                    <c:if test="${ m.deptId == dList[0].deptId }">
							                    	<c:set var="hasChildren" value="true"/> 
							                    </c:if>
				 	                        </c:forEach>
	                                        <c:if test="${ dList[0].hasChildren == 0 || hasChildren }">
	                                        	<c:set var="hasChildren" value="false"/> 
		                                    	<ul class="hasChildren">
		                                        	<c:forEach var="m" items="${ mList }">
									                 	<c:if test="${ m.deptId == dList[0].deptId }">
									                    	<li><span><i class="bi bi-person-fill"></i>${ m.mName } ${ m.jobName }</span></li>
									                    </c:if>
							 	                    </c:forEach>
		                                            <c:forEach var="d2" items="${ dList }" varStatus="vs">
		                                            	<c:if test="${ d2.upperDept == dList[0].deptId }">
			                                            	<li>
		                                            			<input class="lv lv2" type="hidden" name="deptId" value="${ d2.deptId }">
		                                            			<a class="dept draggable dropable">${ d2.deptName }</a>
		                                            			<c:forEach var="m" items="${ mList }">
												                    <c:if test="${ m.deptId == d2.deptId }">
												                    	<c:set var="hasChildren" value="true"/> 
												                    </c:if>
								 	                        	</c:forEach>
			                                            		<c:if test="${ d2.hasChildren == 0 || hasChildren }">
			                                            			<c:set var="hasChildren" value="false"/> 
			                                            			<ul class="hasChildren">
				                                            			<c:forEach var="m" items="${ mList }">
														                 	<c:if test="${ m.deptId ==  d2.deptId }">
														                    	<li><span><i class="bi bi-person-fill"></i>${ m.mName } ${ m.jobName }</span></li>
														                    </c:if>
												 	                    </c:forEach>
												 	                    <c:set var="lastIndex" value="0"/>
												 	                    <c:forEach var="d3" items="${ dList }" varStatus="vs">
				                                            				<c:if test="${ d3.upperDept == d2.deptId }">
				                                            					 <c:set var="lastIndex" value="${ vs.index }"/>
				                                            				</c:if>
				                                            			</c:forEach>
				                                            			<c:forEach var="d3" items="${ dList }" varStatus="vs">
				                                            				<c:if test="${ d3.upperDept == d2.deptId }">
					                                                            <c:forEach var="m" items="${ mList }">
																	            	<c:if test="${ m.deptId == d3.deptId }">
																	                	<c:set var="hasChildren" value="true"/> 
																	            	</c:if>
													 	                        </c:forEach>
					                                                        	<c:if test="${ (d3.hasChildren == 0 || hasChildren) && vs.index != lastIndex }">
					                                                            	<li class="expandable d3">
					                                                            </c:if>
					                                                            <c:if test="${ (d3.hasChildren == 0 || hasChildren) && vs.index == lastIndex }">
					                                                            	<li class="expandable lastExpandable d3">
					                                                            </c:if>
					                                                            <c:if test="${ d3.hasChildren != 0 && !hasChildren }">
					                                                            	<li>
					                                                            </c:if>
					                                                            	<input type="hidden" name="deptId" value="${ d3.deptId }">
					                                                            	<a class="dept draggable dropable">${ d3.deptName }</a>
						                                                            <c:forEach var="m" items="${ mList }">
																	                    <c:if test="${ m.deptId == d3.deptId }">
																	                    	<c:set var="hasChildren" value="true"/> 
																	                    </c:if>
													 	                        	</c:forEach>
						                                                            <c:if test="${ d3.hasChildren == 0 || hasChildren }">
						                                                            	<c:set var="hasChildren" value="false"/> 
						                                                            	<ul class="hasChildren">
						                                                            	</ul>
						                                                            </c:if>
						                                                           </li>
						                                                    </c:if>	
					                                            		</c:forEach>
				                                            		</ul>
				                                            	</c:if>
		                                            		</li>
		                                            	</c:if>
								 	                    <c:if test="${ vs.last }">
								 	                    	<c:forEach var="m" items="${ mList }">
													        	<c:if test="${ m.deptId == null }">
													            	<c:set var="hasChildren" value="true"/> 
													            </c:if>
								 	                   		</c:forEach>
									 	                    <li><input class="lv lv2" type="hidden" name="deptId" value="${ null }">
									 	                   		<i class="bi bi-folder-fill" style="color: gray"></i><a class="noDept"> 부서 미지정</a>
				                                            	<c:if test="${ hasChildren }">
				                                            	<c:set var="hasChildren" value="false"/> 
						                                        	<ul class="hasChildren">
								                                    	<c:forEach var="m" items="${ mList }">
															            <c:if test="${ m.deptId == null }">
															            	<li><span><i class="bi bi-person-fill"></i>${ m.mName } ${ m.jobName }</span></li>
															            </c:if>
													 	                </c:forEach>
												 	             	</ul>
				                                            	</c:if>
			                                            	 </li>
		                                            	 </c:if>
		                                            </c:forEach>
		                                    	</ul>
	                                    	</c:if>
	                                	</li>
	                               	</c:if>
	                            	</ul>
	                        	</div>
	                        	<input id="selectDeptId" type="hidden" name="selectDeptId">
                        	</div>
                    	</div>
                   </div> 
		           <script>
		           		// 조직도 treeview
		           		var deptArr = new Array();
		            	$(function(){
		            		$("#deptList").treeview({});
		            		
		            		let deptObj = {};
		            		<c:forEach var="d" items="${ dList }">
		            			deptObj = {
		            				deptId: '${ d.deptId }',
		            				deptName: '${ d.deptName }',
		            				deptManager: '${ d.deptManager }',
		            				deptManagerName: '${ d.deptManagerName }',
		            				deptManagerJob: '${ d.deptManagerJob }',
		            				upperDept: '${ d.upperDept }',
		            				deptLevel: '${ d.deptLevel }',
		            				deptOrder: '${ d.deptOrder }',
		            				createDate: '${ d.createDate }'
		            			}
		            			
		            			deptArr.push(deptObj);
	            			</c:forEach>
		            	});
		            	
		            	// 부서 이름에 미우스 호버시 css 적용
		            	$(document).on('mouseenter', '.dept', function(){
		            		$(this).toggleClass('hoverDept');
		            	}).on('mouseout', '.hoverDept', function(){
		            		$(this).toggleClass('hoverDept');
		            	});
		            	
		            	// 부서 이름 클릭시 선택 효과 css 적용, 부서 상세 화면 값 변경
 		            	$(document).on('click', '.dept', function(){
 		            		$('.dept').removeClass('selectDept');
		            		$(this).toggleClass('selectDept');
		            		
		            		let deptId = $(this).prev().val();
		            		if (deptId != "") {
			            		$('.update').prop('hidden', true);
	                    		$('.beforeUpdate').prop('hidden', false);
	                    		
		            			let deptName = "";
	 		            		let deptManager = "";
	 		            		let deptManagerName = "";
	 		            		let upperDept = "";
	 		            		let upperDeptName = "";
	 		            		let createDate = "";
	 		            		
	 		            		for(let i in deptArr) {
	 		            			if(deptId == deptArr[i].deptId) {
	 		            				deptName = deptArr[i].deptName;
	 		            				deptManager = deptArr[i].deptManager == null ? "" : deptArr[i].deptManager;
	 		            				deptManagerName = deptArr[i].deptManagerName  == null ? "" :  deptArr[i].deptManagerName;
	 		            				deptManagerJob = deptArr[i].deptManagerJob  == null ? "" :  deptArr[i].deptManagerJob + " ";
	 		            				upperDept = deptArr[i].upperDept;
	 		            				createDate = deptArr[i].createDate;
	 		            			}
	 		            		}
	 		            		
	 		            		for(let i in deptArr) {
	 		            			if(upperDept == deptArr[i].deptId) {
			            				upperDeptName =  deptArr[i].deptName;
			            			}
	 		            		}
			            		$('#deptId').val(deptId);
			            		$('#deptNameSpan').text(deptName);
			            		$('#deptNameInput').val(deptName);
			            		$('#deptMgrSpan').text(deptManagerName == "" ? "미지정" : deptManagerName + " " + deptManagerJob);
			            		$('#deptMgrInput').val(deptManager);
			            		$('#upperDeptSpan').text(upperDeptName == "" ? "미지정" : upperDeptName);
			            		$('#createDateSpan').text(createDate);
		            		}
 		            		
 		            	});
		            	
 		            	// 트리뷰의 + 버튼 클릭시 하위 부서 및 부서원 목록 조회를 위해 실행되는 함수
		            	$(document).on('click', '.hitarea', function(){
		            		let $hitarea = $(this);
		            		let upperDept = $(this).next().val();
		            		let $rootNode = $(this).parent().find('ul');

		            		// level이 3 이상인 부서는 처음 페이지가 로드될 때 부서 목록에 보이게 하고, 
		            		// level4부터는 부서이름 옆의 확장 버튼을 클릭했을 때 해당 부서의 하위 부서 목록을 ajax로 불러옴
		            		// newNode라는 클래스명을 포함하고 있으면 ajax 호출하여 새로 생성된 요소를 의미. 이미 생성된 요소를 중복하여 불러오지 않게 하기 위하여 조건 추가
		            		if (!$(this).next().hasClass('lv') && !$rootNode.hasClass('newNode')) {
		            			if ($(this).parent().hasClass('expandable') || $rootNode.css('display') == 'none') {
		            				console.log($(this).parent().hasClass('expandable'));
		            				$.ajax({
				            			url: 'subDeptList.ad',
				            			dataType: 'json',
				            			data: {upperDept:upperDept},
				            			type: 'GET',
				            			success: function(data) {
				            				console.log(data);
				            				$rootNode.html('');
				            				$("#deptList").treeview({});
				            				
				            				var $li;
				            				var $span;
				            				var $a;
				            				var $input;
				            				var $ul;
				            				if (data.length > 0) {
				            					for (var i in data) {
				            						if (data[i].nodeType == 'member') {
				            							$li = $('<li>');
														if (i == data.length - 1) {
							            					$li.attr('class', 'last');
														}
														var jobName = data[i].jobName == null ? "" : data[i].jobName;
				            							$span = $('<span>').html('<i class="bi bi-person-fill"></i>' + data[i].nodeName + ' ' + jobName);
				            							$li.append($span);
				            							$rootNode.append($li);
				            						} else {
					            						var hasChildren = false;
				            							<c:forEach var="m" items="${ mList }">
										                    if ('${ m.deptId }' == data[i].nodeId) {
										                    	hasChildren = true;
										                    }
						 	                       		</c:forEach>
					            						
				            							if (data[i].hasChildren == 0 || hasChildren) {
				            								$li = $('<li class="expandable">');
				            								$div =  $('<div class="hitarea expandable-hitarea">');
															if (i == data.length - 1) {
																$li = $('<li class="expandable lastExpandable">');
																$div = $('<div class="hitarea expandable-hitarea lastExpandable-hitarea">');
															}
					            							
							            					$input = '<input type="hidden" name="deptId" value="' + data[i].nodeId + '">'
							            					$a = '<a class="dept draggable dropable">' + data[i].nodeName + '</a>';
							            					$ul = '<ul class="hasChildren"></ul>';
							            					
							            					$li.append($div);
							            					$li.append($input);
							            					$li.append($a);
							            					$li.append($ul);
							            					$rootNode.append($li);
															
				            							} else {
				            								$li = $('<li>');
															if (i == data.length - 1) {
							            						$li.attr('class', 'last');
															}
							            					$input = '<input type="hidden" name="deptId" value="' + data[i].nodeId + '">'
							            					$a = '<a class="dept draggable dropable">' + data[i].nodeName + '</a>';
							            					$li.append($input);
							            					$li.append($a);
							            					
							            					$rootNode.append($li);
				            							}
				            						}

				            					}
				            					
				            					$hitarea.addClass('collapsable-hitarea').removeClass('expandable-hitarea');
					            				$hitarea.parent().addClass('collapsable').removeClass('expandable');
												if ($hitarea.parent().hasClass('lastExpandable')) {
													$hitarea.addClass('lastCollapsable-hitarea').removeClass('lastExpandable-hitarea');
													$hitarea.parent().addClass('lastCollapsable').removeClass('lastExpandable');
												}
												$rootNode.css('display', 'block');
												$rootNode.addClass('newNode'); // +버튼 클릭시 최초 한 번만 불러올 수 있도록 해당 ul태그에 newNode라는 클래스명 추가
				            					
				            					$("#deptList").treeview({});
				            				} 
				            				
				            			},
				            			error: function(data) {
				            				console.log(data);
				            				alert('알 수 없는 오류가 발생했습니다.', '', 'error');
				            			},
				            		});
		            				
		            			} 
		            		}
		            	});
		  
		            </script>
					<script>
                 		// drag and drop function
                 		$(function(){
                 			let upperDeptId = "";
                 			let moveDeptId = "";
	
		                    //boolean to revert check
		                    let isRevert = false;
	
		                    //droppable target 
		                    $contain= $(".dropable");
	
		                    //draggable target
		                    $object = $(".draggable");
	
		                	//움직일 객체
		                    $object.draggable(
		                        {
		                            //드래그가 끝난뒤 제자리로 돌아오게 하는 속성값
		                            revert:function(event,ui){
		                                //droppable 객체가 아닌곳에 드래그 됫을때
		                                if(event==false){
		                                    isRevert=false;
		                                    return true;
		                                //droppable 객체에 들어갓을때
		                                } else{
		                                    isRevert=true;
		                                }
	
		                            },
	
		                            //드래그되는 객체가 본인 자체일지 아니면 그외 다른것일지
		                            //해당 함수의 return 값이 드래그되어서 움직임
		                            helper:function(){
		                                $helper=$(this).clone();
		                                return $helper; 
	
		                            },
	
		                            //드래그가 시작됬을때 발생
		                            start:function(event,ui){
		                                //최종 더해질 객체
		                                $final=$(this).clone();
		                                //잠시 더해져서 에니메이션을 보여줄 객체
		                                $clone=$(this).clone();
	
		                            },
	
		                            //드래그가 중지됬을때 발생
		                            stop:function(event,ui){

		                                moveDeptId = $(this).prev().val();
		                                
		                                //제대로 droppable 객체 안에 들어갔을때
		                                if(isRevert && upperDeptId != "" && moveDeptId != ""){

			                                let upperDeptLevel = 0;
		                                	let moveDeptLevel = 0;
		                                	let originUpperDept = 0;
		                                	for(let i in deptArr) {
									  		 	if (upperDeptId == deptArr[i].deptId) {
									  		 		upperDeptLevel = Number(deptArr[i].deptLevel);
									  		 	}
									  		 	if (moveDeptId == deptArr[i].deptId) {
									  		 		moveDeptLevel = Number(deptArr[i].deptLevel);
									  		 		originUpperDept = Number(deptArr[i].upperDept);
									  		 	}
									  		}
		                                	
		                                	if (upperDeptLevel <= moveDeptLevel) {
		                                		if (originUpperDept != upperDeptId) {
		                                			$.ajax({
														url: 'dmove.ad',
								                		data: {moveDeptId:moveDeptId, upperDeptId:upperDeptId, upperDeptLevel:upperDeptLevel},
								                		type: 'POST',
								                		success: function(data){
								                			console.log(data);
								                			if (data.length > 0) {
								                				location.reload();
								                			}
								                		},
								                		error: function(data){
								                			console.log(data);
								                			alert('알 수 없는 오류가 발생했습니다.', '', 'error');
								                		}
													});
		                                		}
		                                	} else {
		                                		alert('하위 부서로 이동할 수 없습니다.');
		                                	}
										  	         
		                                }
		                            }

	                        	});
		                    	
		                    	$contain.droppable({
			                    	 accept:".draggable",
								     drop: function( event, ui ) {  // drop function : draggable의 stop function이 종료된 후에 발생
								    	 upperDeptId = $(this).prev().val();
							     	}
								});
						});  
                 		
                 		$(document).on('drag', '.draggable', function(){ // 새롭게 생성된 객체도 적용될 수 있게 $(document).on()사용
                 			let upperDeptId = "";
                 			let moveDeptId = "";
                 			let count = 0;
	
		                    //boolean to revert check
		                    let isRevert = false;
	
		                    //droppable target 
		                    $contain= $(".dropable");
	
		                    //draggable target
		                    $object = $(".draggable");
	
		                	//움직일 객체
		                    $object.draggable(
		                        {
		                            //드래그가 끝난뒤 제자리로 돌아오게 하는 속성값
		                            revert:function(event,ui){
		                                //droppable 객체가 아닌곳에 드래그 됫을때
		                                if(event==false){
		                                    isRevert=false;
		                                    return true;
		                                //droppable 객체에 들어갓을때
		                                } else{
		                                    isRevert=true;
		                                }
	
		                            },
	
		                            //드래그되는 객체가 본인 자체일지 아니면 그외 다른것일지
		                            //해당 함수의 return 값이 드래그되어서 움직임
		                            helper:function(){
		                                $helper=$(this).clone();
		                                return $helper; 
	
		                            },
	
		                            //드래그가 시작됬을때 발생
		                            start:function(event,ui){
		                                //최종 더해질 객체
		                                $final=$(this).clone();
		                                //잠시 더해져서 에니메이션을 보여줄 객체
		                                $clone=$(this).clone();
	
		                            },
	
		                            //드래그가 중지됬을때 발생
		                            stop:function(event,ui){
		                                
		                                moveDeptId = $(this).prev().val();
		                                
		                                //제대로 droppable 객체 안에 들어갔을때
		                                if(isRevert && upperDeptId != "" && moveDeptId != ""){

			                                let upperDeptLevel = 0;
		                                	let moveDeptLevel = 0;
		                                	let originUpperDept = 0;
		                                	for(let i in deptArr) {
									  		 	if (upperDeptId == deptArr[i].deptId) {
									  		 		upperDeptLevel = Number(deptArr[i].deptLevel);
									  		 	}
									  		 	if (moveDeptId == deptArr[i].deptId) {
									  		 		moveDeptLevel = Number(deptArr[i].deptLevel);
									  		 		originUpperDept = Number(deptArr[i].upperDept);
									  		 	}
									  		}
		                                	
		                                	if (upperDeptLevel <= moveDeptLevel) {
		                                		if (originUpperDept != upperDeptId) {
		                                			$.ajax({
														url: 'dmove.ad',
								                		data: {moveDeptId:moveDeptId, upperDeptId:upperDeptId, upperDeptLevel:upperDeptLevel},
								                		type: 'POST',
								                		success: function(data){
								                			console.log(data);
								                			if (data.length > 0) {
								                				location.reload();
								                			}
								                		},
								                		error: function(data){
								                			console.log(data);
								                			alert('알 수 없는 오류가 발생했습니다.', '', 'error');
								                		}
													})
		                                		}
		                                	} else {
		                                		alert('하위 부서로 이동할 수 없습니다.');
		                                	}
		                                }
		                            }

	                        	});			
		                	
			                    $contain.droppable({
	                				 accept:".draggable",
								     drop: function( event, ui ) {  // drop function : draggable의 stop function이 종료된 후에 발생
								    	 if (count == 0) {
								    		 upperDeptId = $(this).prev().val();
								    	 }
								    	 count++;
							     	}
								});
                 		});
                 		
                 	</script>
                    <div class="col-lg-8 card2">
                        <div class="card">
                            <div class="card-body">
                            	<input id="deptId" type="hidden" name="deptId" value="${ dList[0].deptId }">
                            <c:if test="${ fn:length(dList) != 0 }">
                            	<h4 class="card-intro-title" style="font-weight: bold;">부서 정보</h4>
                            	<br><br><br>
                               	<div class="dept-detail">
				                     <span class="text-danger update" hidden="true">*</span>
				                     <span class="text-danger beforeUpdate">&nbsp;</span>
				                     <label class="col-form-label update-form dept-label">부서명</label><span id="deptNameSpan" class="beforeUpdate"> ${ dList[0].deptName }</span>
				                     <input id="deptNameInput" type="text" class="form-control update" name="deptName" value="${ dList[0].deptName }" hidden="true">
				                     <br>
				                     <div class="guide-display"><span id="deptNameGuide" class="guide update-guide text-danger">2~10자리까지 입력해주세요.</span><br></div>
				                      &nbsp;<label class="col-form-label update-form">부서 책임자</label><span id="deptMgrSpan" class="beforeUpdate">${ dList[0].deptManagerName == null ? "미지정" : dList[0].deptManagerName} ${dList[0].deptManagerJob }</span>
				                     <input id="deptMgrInput" type="search" class="form-control update" name="deptManager" value="${ dList[0].deptManager }" list="memberList" placeholder="사원 아이디" autocomplete="off" hidden="true">
				                     <datalist id="memberList">
				                     	<c:forEach var="m" items="${ mList }">
				                      		<option value="${ m.mId }">${ m.mName } ${ m.jobName }</option> 
		 	                            </c:forEach>
				                     </datalist><br>
								 	 <div class="guide-display"><span id="deptMgrGuide" class="guide update-guide text-danger">중지된 계정 또는 존재하지 않는 계정입니다.</span><br></div>
				                      &nbsp;<label class="col-form-label update-form">상위부서</label><span id="upperDeptSpan">미지정</span>
				                     <br>
				                      &nbsp;<label class="col-form-label update-form">생성일</label><span id="createDateSpan">${ dList[0].createDate }</span>
				                     <br><br>
                               		</div>
	                                <div align="center" class="beforeUpdate">
	                                	 <button type="button" class="btn btn-primary" id="updateFormBtn">수정하기</button>
	                                </div>
                                    <div id="updateBtnArea" class="update" align="center" hidden="true">
                                    	<button type="button" class="btn btn-primary" id="updateBtn">저장</button>
	                                    <button type="button" class="btn btn-outline-primary" id="cancelBtn">수정 취소</button>
                            	</div>
                           	</c:if>
                        	</div>
                    	</div>
                 	</div>
                 </div>
                    <script>
                    	// 수정하기 버튼 클릭시 수정 화면으로 보이게 함
                    	$('#updateFormBtn').on('click', function(){
                    		$('.beforeUpdate').prop('hidden', true);
                    		$('.update').prop('hidden', false);
                    	});
                    	
                    	// 수정 취소 버튼 클릭시 수정 화면으로 보이지 않게 함
                    	$('#cancelBtn').on('click', function(){
                    		$('.update').prop('hidden', true);
                    		$('.beforeUpdate').prop('hidden', false);
                    	});
                		
					  	// 부서 수정 화면에서 부서명 기입시 안내 문구 출력
					  	$('#deptNameInput').on('change', function(){
					  		  $(this).val($(this).val().trim()); //  공백 입력시 자동으로 공백 제거되게 함
			                  let deptName = $(this).val();  
					  		  
			                  if (deptName.length < 2 || deptName.length > 10) {
			                	  $('#deptNameGuide').parent().removeClass('guide-display');
			                	  $(this).focus();
			                  } else {
			                	  $('#deptNameGuide').parent().addClass('guide-display');
			                  }
					  	});                    	
                    	
					  	let existenceCheck2 = false;
					 	// 부서 수정 화면에서 부서책임자 아이디 입력시 존재하는 사원인지 검증
		            	$('#deptMgrInput').on('change', function(){
		                    // 만약 멤버리스트에 없는 아이디 입력시 존재하는 사원의 아이디를 입력해달라고 안내 문구
		               		existenceCheck2 = false; // 부서책임자 입력 값에 변화가 있을시 false로 초기화
							$(this).val($(this).val().trim()); // 공백 입력시 자동으로 공백 제거되게 함
						    let deptManager = $(this).val();  
									  	  
							// 입력한 사원 아이디가 존재하는 아이디인지 검증
			                <c:forEach var="m" items="${ mList }">
								if ("${ m.mId }" == deptManager) {
									existenceCheck2 = true;
								}
					 	    </c:forEach>
					 	                  
					 	     // 만약 멤버리스트에 없는 아이디 입력시 존재하지 않는 사원이라는 안내 문구 출력
						     if (!existenceCheck2 && deptManager != "") {
						         $('#deptMgrGuide').parent().removeClass('guide-display');
						         $(this).focus();
						     } else {
						    	 $('#deptMgrGuide').parent().addClass('guide-display');
						     }
		            	});
		            	
					 	// 부서 정보 수정 저장 버튼 눌렀을시 실행하는 함수
					 	$(document).on('click', '#updateBtn', function(){
					 		let deptId= $('#deptId').val();
					 		let deptName = $('#deptNameInput').val();
					 		let deptManager = $('#deptMgrInput').val();
					 		let deptManagerName = "미지정";
					 		let jobName = "";
					 		
					 		// 변경 없을시 입력되어 있는 사원 아이디가 존재하는 아이디인지 검증
			                <c:forEach var="m" items="${ mList }">
								if ("${ m.mId }" == deptManager) {
									existenceCheck2 = true;
									deptManagerName = "${ m.mName }";
									jobName = "${ m.jobName }";
								}
					 	    </c:forEach>
					 		
					 		if (deptName.length < 2 || deptName.length > 10) {
					 			$('#deptNameInput').focus();
			                } else if (!existenceCheck2 && deptManager != "") {
			                	$('#deptMgrGuide').parent().removeClass('guide-display');
			                	$('#deptMgrInput').focus();
			                } else {
			                	$.ajax({
			                		url: 'dupdate.ad',
			                		data: {deptId:deptId, deptName:deptName, deptManager:deptManager},
			                		type: 'POST',
			                		success: function(data){
			                			console.log(data);
			                			$('.selectDept').text(deptName); 
			                			$('#deptNameSpan').text(deptName);
			                			$('#deptMgrSpan').text(deptManagerName + " " + jobName);
			                			$('.update').prop('hidden', true);
			                    		$('.beforeUpdate').prop('hidden', false);
			                    		
			                    		for(let i in deptArr) {
			 		            			if(deptId == deptArr[i].deptId) {
					            				deptArr[i].deptName = deptName;
					            				deptArr[i].deptManager = deptManager;
					            				deptArr[i].deptManagerName = deptManagerName
					            				deptArr[i].deptManagerJob = jobName;
					            			}
			 		            		}
			                    		
			                			alert('저장되었습니다.');
			                		},
			                		error: function(data){
			                			console.log(data);
			                			alert('알 수 없는 오류가 발생했습니다.', '', 'error');
			                		}
			                	});
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

    
   <!-- Tree Viewer JS
	============================================ -->
	<script src="${contextPath}/resources/assets/vendor/deptList/js/jquery.cookie.js"></script>
	<script src="${contextPath}/resources/assets/vendor/deptList/js/jquery.treeview.js" type="text/javascript"></script>
	<script src="${contextPath}/resources/assets/vendor/deptList/js/jquery.treeview.edit.js" type="text/javascript"></script>
	<script src="${contextPath}/resources/assets/vendor/deptList/js/jquery.treeview.async.js" type="text/javascript"></script>
	
	<!-- drag and drop 관련 js -->
	<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
</body>

</html>