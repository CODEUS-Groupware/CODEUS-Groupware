<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>Focus - Bootstrap Admin Dashboard </title>
    <!-- Datatable -->
    <link href="${contextPath}/resources/assets/vendor/datatables/css/jquery.dataTables.min.css" rel="stylesheet">
</head>

<body>

    <!--**********************************
        Main wrapper start
    ***********************************-->
    <div id="main-wrapper">	

		<%@ include file="/WEB-INF/views/common/menubar.jsp" %>
    
        <!--**********************************
            Content body start
        ***********************************-->
        <div class="content-body">
            <div class="container-fluid">
                <div class="row page-titles mx-0">
                    <div class="col-sm-12 p-md-0">
                        <div class="welcome-text">
                            <h4>주소록 검색</h4>
                        </div>
                    </div>
                </div>
                
                <!-- row -->

                <div class="row">
                	<div class="col-xl-3 col-lg-2 col-xxl-2 col-md-2">
                        <div class="card">
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table student-data-table m-t-20" style="color : black; text-align: center;">
                                        <thead>
                                            <tr>
                                                <th>프로필 사진 영역
                                                <div class="media-left">
                                            		<a href="#"><img class="media-object mr-3" src="./images/avatar/4.png" alt="..."></a>
                                        		</div>
                                        		</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td id="mName">사원 이름</td>
                                            </tr>
                                            <tr>
                                                <td id="mJob">직급</td>
                                            </tr>
                                            <tr>
                                                <td id="mDept">부서</td>
                                            </tr>
                                            <tr>
                                                <td id="mPhone">연락처</td>
                                            </tr>
                                            <tr>
                                                <td id="mEamil">이메일</td>
                                            </tr>
                                            <tr>
                                                <td><button class="form-control input-default" style="background: #593bdb; color: white;">+</button></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                	
                    <div class="col-xl-9 col-lg-10 col-xxl-10 col-md-10">
                        <div class="card">
                            <div class="card-header">
                                <table style="border: none; width: 100%">
		                        	<tr>
		                        		<td>
		                        			<select id="field" name="field" class="form-control" style="background: #593bdb; color: white;">
                                                <option selected value="name">이름</option>
                                                <option value="job">직급</option>
                                                <option value="dept">부서</option>
											</select>
		                        		</td>
		                        		<td><input id="addrSearch" name="input" type="text" class="form-control input-default" placeholder="검색어 입력"></td>
		                        		<td>
		                        			<button id="searchBtn" class="form-control input-default" style="background: #593bdb; color: white;">
		                        				<i class="bi bi-search"></i>
		                        			</button>
		                        		</td>
		                        	</tr>
                       	 		</table>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table id="mSearchList" class="table student-data-table m-t-20" style="color : black; text-align: center; border: none;">
                                        <thead>
                                            <tr>
                                            	<th></th>
                                                <th>이름</th>
                                                <th>직급</th>
                                                <th>부서</th>
                                                <th>연락처</th>
                                                <th>메일</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach var="addr" items="${ list }">
                                        	<c:if test="${ empty list }">
                                        		<tr>
                                        			<td colspan="7">조회된 사원이 없습니다.</td>
                                        		</tr>
                                        	</c:if>
                                        	<c:if test="${ !empty list }">
	                                            <tr>
	                                            	<td></td>
	                                                <td>${ addr.mName }</td>
	                                                <td>${ addr.jobName }</td>
	                                                <td>${ addr.deptName }</td>
	                                                <td>${ addr.phone }</td>
	                                                <td>${ addr.email }</td>
	                                                <td><button class="form-control input-default" style="background: #593bdb; color: white;">&nbsp+&nbsp</button></td>
	                                            </tr>
                                            </c:if>
                                        </c:forEach>
                                        	<tr>
                                        		<td align="center" colspan="7">
                                        			<div>
					                                    <nav>
						                                    <ul class="pagination pagination-xs">
						                                    	
						                                    	<!-- 이전 -->
						                                        <li class="page-item page-indicator">
						                                        	<c:if test="${ pi.currentPage <= 1 }">
						                                        		<i class="icon-arrow-left"></i>
						                                        	</c:if>
						                                        	<c:if test="${ pi.currentPage > 1 }">
						                                        		<c:url var="before" value="search.addr">
																			<c:param name="page" value="${ pi.currentPage - 1 }"/>
																		</c:url>
						                                            	<a class="page-link" href="${ before }">
						                                                	<i class="icon-arrow-left"></i></a>
						                                            </c:if>
						                                        </li>
						                                        
						                                        <!-- 페이지 -->
						                                        <c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
						                                        	<c:if test="${ p eq pi.currentPage }">
						                                        		<li class="page-item active"><a class="page-link" href="javascript:void()">${ p }</a>
						                                        		</li>
						                                        	</c:if>
						                                        	
						                                        	<c:if test="${ p ne pi.currentPage }">
						                                        		<c:url var="pagination" value="search.addr">
																			<c:param name="page" value="${ p }"/>
																		</c:url>
						                                        		<li class="page-item"><a class="page-link" href="${ pagination }">${ p }</a></li>
						                                        	</c:if>
						                                        </c:forEach>
						                                        
						                                        <!-- 다음 -->
						                                        <li class="page-item page-indicator">
						                                        	<c:if test="${ pi.currentPage >= pi.maxPage }">
						                                        		<i class="icon-arrow-right"></i>
						                                        	</c:if>
						                                        	<c:if test="${ pi.currentPage < pi.maxPage }">
						                                        		<c:url var="after" value="search.addr">
																			<c:param name="page" value="${ pi.currentPage + 1 }"/>
																		</c:url>
						                                            	<a class="page-link" href="${ after }">
						                                                	<i class="icon-arrow-right"></i></a>
						                                            </c:if>
						                                        </li>
						                                    </ul>
						                                </nav>
				                                    </div>
                                        		</td>
                                        	</tr>
                                        </tbody>
                                    </table>
                                    
                                    
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
	    
	    <script>
		$(function() {
			$('#mSearchList td').mouseenter(function() {
				$(this).parent().css({'color':'purple', 'cursor':'pointer'});
			}).mouseout(function() {
				$(this).parent().css({'color':'black'});
			}).click(function() {
				
			});
		});
		
		document.getElementById("searchBtn").onclick = function(){
			var input = document.getElementById("addrSearch").value;
			var field = document.getElementById('field').value;
			
			console.log(search);
			console.log(field);
			
			location.href='${ contextPath }/search.re?field=' + field + '&input=' + input;													
		}
	</script>
	    
    <!-- Datatable -->
    <script src="${contextPath}/resources/assets/vendor/datatables/js/jquery.dataTables.min.js"></script>
    <script src="${contextPath}/resources/assets/js/plugins-init/datatables.init.js"></script>

</body>

</html>