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
	a:hover{cursor: pointer;}
	.guide{margin-left: 110px;}
	.col-form-label{font-weight: bolder; width: 100px;}
	.form-col{padding-left: 15px;}
	.dept-detail{color: black; font-size: medium;}
	.dept-detail input[type=text], .dept-detail input[type=search], .dept-detail select{display: inline;  width: 150px;}
	.tree-div{overflow-x: hidden; color: black;}
	.card-body{min-height: 800px;}
</style>
	<!-- tree viewer CSS
		============================================ -->
    <link rel="stylesheet" href="${contextPath}/resources/assets/vendor/deptList/css/tree-viewer.css">
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
<!--                 	<div class="col-lg-3"> -->
<!--                         <div class="card"> -->
<!--                             <div class="card-body"> -->
<!--                                 <h4 class="card-intro-title" style="font-weight: bold;">부서 목록</h4> -->

<!--                                 <div class=""> -->
<!--                                     <div id="external-events" class="my-3"> -->
<!--                                         <p>Drag and drop your event or click in the calendar</p> -->
<!--                                         <div class="external-event" data-class="bg-primary"><i class="fa fa-move"></i>New Theme Release</div> -->
<!--                                         <div class="external-event" data-class="bg-success"><i class="fa fa-move"></i>My Event -->
<!--                                         </div> -->
<!--                                         <div class="external-event" data-class="bg-warning"><i class="fa fa-move"></i>Meet manager</div> -->
<!--                                         <div class="external-event" data-class="bg-dark"><i class="fa fa-move"></i>Create New theme</div> -->
<!--                                     </div> -->
<!--                                     checkbox -->
<!--                                     <div class="checkbox checkbox-event pt-3 pb-5"> -->
<!--                                         <input id="drop-remove" class="styled-checkbox" type="checkbox"> -->
<!--                                         <label class="ml-2 mb-0" for="drop-remove">Remove After Drop</label> -->
<!--                                     </div> -->
<!--                                     <a href="javascript:void()" data-toggle="modal" data-target="#add-category" class="btn btn-primary btn-event w-100"> -->
<!--                                         <span class="align-middle"><i class="ti-plus"></i></span> Create New -->
<!--                                     </a> -->
<!--                                 </div> -->
<!--                             </div> -->
<!--                         </div> -->
<!--                     </div> -->
                    
                    <div class="col-lg-4 card1">
                       <!--  <div class="sparkline9-list shadow-reset responsive-mg-b-30"> -->
                    	<div class="card">
                           	<div class="card-body tree-div">
                               <h4 class="card-intro-title" style="font-weight: bold;">부서 목록</h4>
							   <br>
	                           <div class="sparkline9-graph">
	                                <div class="edu-content res-tree-ov">
	                                    <div id="jstree1">
	                                        <ul>
	                                            <li class="jstree-open">${ dList[0].deptName }
	                                            	<ul>
	                                            	<c:forEach var="d2" items="${ dList }">
	                                            		<c:if test="${ d2.deptLevel == 2}">
	                                            			<li>${ d2.deptName }
	                                            				<ul>
		                                            			<c:forEach var="d3" items="${ dList }">
		                                            				<c:if test="${ d3.upperDept == d2.deptId }">
			                                                            <li>${ d3.deptName }
			                                                            	<ul>
			                                                            	<c:forEach var="d4" items="${ dList }">
			                                                            		<c:if test="${ d4.upperDept == d3.deptId }">
		                                            							
		                                            								<li>${ d4.deptName }
		                                            								</li>
			                                                       			 	</c:if>
			                                                            	</c:forEach>
			                                                            	</ul>
			                                                            </li>
			                                                        </c:if>	
		                                            			</c:forEach>
		                                            			</ul>
	                                            			</li>
	                                            		</c:if>
	                                            	</c:forEach>
	                                            	</ul>
	                                            	
<!-- 	                                                <ul> -->
<!-- 	                                                    <li>css -->
<!-- 	                                                        <ul> -->
<!-- 	                                                            <li>bootstrap.min.css</li> -->
<!-- 	                                                            <li>font-awesome.min.css</li> -->
<!-- 	                                                            <li>responsive.css</li> -->
<!-- 	                                                            <li>tree-viewer.css</li> -->
<!-- 	                                                        </ul> -->
<!-- 	                                                    </li> -->
<!-- 	                                                    <li>sounds -->
<!-- 	                                                        <ul> -->
<!-- 	                                                            <li>bootstrap.min.css</li> -->
<!-- 	                                                            <li>font-awesome.min.css</li> -->
<!-- 	                                                            <li>responsive.css</li> -->
<!-- 	                                                            <li>tree-viewer.css</li> -->
<!-- 	                                                        </ul> -->
<!-- 	                                                    </li> -->
<!-- 	                                                    <li>fonts -->
<!-- 	                                                        <ul> -->
<!-- 	                                                           <li>bootstrap.min.css</li> -->
<!-- 	                                                            <li>font-awesome.min.css</li> -->
<!-- 	                                                            <li>responsive.css</li> -->
<!-- 	                                                            <li>tree-viewer.css</li> -->
<!-- 	                                                        </ul> -->
<!-- 	                                                    </li> -->
<!-- 	                                                    <li class="jstree-open">img -->
<!-- 	                                                        <ul> -->
<!-- 	                                                            <li>bootstrap.min.css</li> -->
<!-- 	                                                            <li>font-awesome.min.css</li> -->
<!-- 	                                                            <li>responsive.css</li> -->
<!-- 	                                                            <li>tree-viewer.css</li> -->
<!-- 	                                                        </ul> -->
<!-- 	                                                    </li> -->
<!-- 	                                                    <li class="jstree-open">js -->
<!-- 	                                                        <ul> -->
<!-- 	                                                            <li>bootstrap.min.css</li> -->
<!-- 	                                                            <li>font-awesome.min.css</li> -->
<!-- 	                                                            <li>responsive.css</li> -->
<!-- 	                                                            <li>tree-viewer.css</li> -->
<!-- 	                                                        </ul> -->
<!-- 	                                                    </li> -->
<!-- 	                                                    <li>bootstrap.min.css</li> -->
<!-- 	                                                    <li>font-awesome.min.css</li> -->
<!-- 	                                                    <li>responsive.css</li> -->
<!-- 	                                                    <li>tree-viewer.css</li> -->
<!-- 	                                                </ul> -->
	                                            </li>
	                                        </ul>
	                                    </div>
	                                </div>
	                            </div>
                        	</div>
                    	</div>
                   </div> 
                    
                    <div class="col-lg-8 card2">
                        <div class="card">
                            <div class="card-body">
                            	<h4 class="card-intro-title" style="font-weight: bold;">부서 정보</h4>
                            	<br>
                               	<div class="dept-detail">
                               		<input type="hidden" name="deptId" value="">
			                        <label class="col-form-label">부서명</label>
			                        <input type="text" class="form-control updateInput" name="deptName">
			                        <br>
			                        <label class="col-form-label">부서책임자</label>
			                        <input type="search" class="form-control updateInput" name="deptManager" list="memberList" placeholder="사원 아이디" autocomplete="off">
			                        <datalist id="memberList">
			                        	<c:forEach var="c" items="${ cList }">
			                        		<option value="${ c.mId }"> ${ c.jobName } ${ c.mName } </option> 
	 	                                 </c:forEach>
			                        </datalist>
									<br>
			                        <label class="col-form-label">상위부서</label> <!-- 없으면 미지정으로 표기 -->
			                        <input type="text" class="form-control" name="upperDept">
			                        <br>
			                        <label class="col-form-label">생성일</label>
			                        <br><br>
	                                
                                    <div class="update" align="center">
                                    	<button class="btn btn-primary" id="btnSubmit">저장</button>
	                                    <button type="reset" class="btn btn-outline-primary">취소</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <script>
		            	$('input[name=deptManager]').on('change', function(){
		                	console.log($('input[name=deptManager]').val());
		                    // 만약 멤버리스트에 없는 아이디 입력시 존재하는 사원의 아이디를 입력해달라 알럿창
		                });
		            </script>
		            
		            <script>
		            	$('.jstree').on('click', function(){
		            		console.log($(this).text());
		            	});
		            </script>
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title" style="font-weight: bold;">부서 목록</h3>
                            </div>
                            <div class="card-body">
	                        	<div style="float: right; margin-bottom: 10px;">
		                            <!-- Button trigger modal -->
			                       	<button type="button" class="btn btn-outline-dark" id="insertBtnModal" data-toggle="modal" data-target="#insertJob">직위 추가</button>
			                        <button type="button" class="btn btn-outline-dark" id="deleteBtn">부서 삭제</button>
	                            </div>
					              
	                            <!-- Insert Modal -->
	                            <div class="modal fade" id="insertJob">
	                            	<div class="modal-dialog modal-dialog-centered" role="document">
	                                	<div class="modal-content">
	                                    	<div class="modal-header">
	                                        	<h5 class="modal-title">부서 추가</h5>
	                                            <button type="button" class="close" data-dismiss="modal"><span>&times;</span>
	                                            </button>
	                                        </div>
	                                        <div class="modal-body" style="color: black;">
	                                        	<span class="text-danger">*</span><label class="col-form-label">명칭</label> 
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
    <script type="text/javascript">
        $(document).ready(function () {
            //[1] 리스트의 기본 모양 지정 : <ul>를 자식으로 가지지 않는 li의 블릿기호는 기본 모양
            $('li:not(:has(ul))').css({ cursor: 'default', 'list-style-image':'none'});
           
            //[2] 자식 요소를 갖는 li에 대해서는 블릿이미지를 plus.gif를 지정
            $('li:has(ul)') //자식 요소(ul)를 갖는 요소(li)에 대해서
                .css({cursor: 'pointer', 'list-style-image':'url(plus.gif)'})//+기호로 설정
                .children().hide(); //자식요소 숨기기
               
            //[3] +로 설정된 항목에 대해서 click이벤트 적용
            $('li:has(ul)').click(function(event){
                           
                //this == event.target으로 현재 선택된 개체에 대해서 처리
                if(this == event.target){
                    //숨겨진 상태면 보이고 -기호로 설정 그렇지 않으면 숨기고 + 기호로 설정
                      if ($(this).children().is(':hidden')) {
                        // 보이기
                        $(this).css('list-style-image', 'url(minus.gif)').children().slideDown();
                    }
                    else {
                        // 숨기기
                        $(this).css('list-style-image', 'url(plus.gif)').children().slideUp();
                    }
 
                }
                return false;          
            });
        });
    </script>
    
    <!--**********************************
        Main wrapper end
    ***********************************-->
    
   <!--**********************************
        Scripts
    ***********************************-->
    <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    
   <!-- Tree Viewer JS
	============================================ -->
<%--     <script src="${contextPath}/resources/assets/vendor/deptList/js/jstree.min.js"></script> --%>
<%--     <script src="${contextPath}/resources/assets/vendor/deptList/js/jstree.active.js"></script> --%>
</body>

</html>