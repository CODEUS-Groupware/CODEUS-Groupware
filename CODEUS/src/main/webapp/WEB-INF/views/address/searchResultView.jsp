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
                        <div class="card" style="height:500px;">
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table student-data-table m-t-20" style="color : black; text-align: center;">
                                        <thead>
                                            <tr>
                                                <th>
                                                <div class="media-left">
                                            		<a href="#"><img src="/codeus/resources/assets/images/empty-profile.png" class="img-fluid rounded-circle" alt="" style="width: 150px"></a>
                                        		</div>
                                        		</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td id="mName">사원 이름<br></td>
                                            </tr>
                                            <tr>
                                                <td id="mJob">직위</td>
                                            </tr>
                                            <tr>
                                                <td id="mDept">부서</td>
                                            </tr>
                                            <tr>
                                                <td id="mPhone">연락처</td>
                                            </tr>
                                            <tr>
                                                <td id="mEmail">이메일</td>
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
                        <div class="card" style="height:500px;">
                            <div class="card-header">
                                <form name="searchform" method="post" action="research.addr" style="width: 100%">
                                <table style="border: none; width: 100%">
		                        	<tr>
		                        		<td>
		                        			<select id="field" name="field" class="form-control" style="background: #593bdb; color: white;">
                                                <option selected value="name">이름</option>
                                                <option value="job">직급</option>
                                                <option value="dept">부서</option>
											</select>
		                        		</td>
		                        		<td><input id="input" name="input" type="text" class="form-control input-default" placeholder="검색어 입력" value="${ input }"></td>
		                        		<td>
		                        			<button id="searchBtn" class="form-control input-default" style="background: #593bdb; color: white;" type="submit">
		                        				<i class="bi bi-search"></i>
		                        			</button>
		                        		</td>
		                        	</tr>
                       	 		</table>
                       	 		</form>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table id="mSearchList" class="table student-data-table m-t-20" style="color : black; text-align: center; border: none;">
                                        <thead>
                                            <tr>
                                            	<th></th>
                                                <th>이름</th>
                                                <th>직위</th>
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
	                                            <tr id="info">
	                                            	<td></td>
	                                                <td id="name">${ addr.mName }
	                                               		<input type="hidden" class="mId" value="${ addr.mId }">	
	                                                </td>
	                                                <td id="job">${ addr.jobName }</td>
	                                                <td id="dept">${ addr.deptName }</td>
	                                                <td id="phone">${ addr.phone }</td>
	                                                <td id="email">${ addr.email }</td>
	                                                <td><button class="form-control input-default addrPlus" style="background: #593bdb; color: white;">&nbsp+&nbsp</button></td>
	                                            </tr>
                                            </c:if>
                                        </c:forEach>
                                        	<tr>
                                        		<td style="text-align:center" colspan="7">
                                        			<div style="display:inline-block;">
					                                    <nav>
						                                    <ul class="pagination pagination-xs pagination-circle">
						                                    	
						                                    	<!-- 이전 -->
						                                        <li class="page-item page-indicator">
						                                        	<c:if test="${ pi.currentPage <= 1 }">
						                                        		<i class="icon-arrow-left"></i>
						                                        	</c:if>
						                                        	<c:if test="${ pi.currentPage > 1 }">
						                                        		<c:url var="before" value="research.addr">
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
						                                        		<c:url var="pagination" value="research.addr">
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
						                                        		<c:url var="after" value="research.addr">
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
	    
	 // sweet alert customize
		var alert = function(msg, title, icon) {
			Swal.fire({
				position: 'top', // 상단 중앙에 띄우기
				background: '#593bdb', // 알럿창 배경색
   				color: 'white', // 글자색
				title : title, // 제목(큰 글씨)
				text : msg, // 내용(작은 글씨)
				icon: icon, // info, error 등 icon type
				timer : 3000, // 자동 종료 타이머
				customClass : 'sweet-size', 
				showConfirmButton : false // ok버튼 표시 여부
			});
		}
	    
	    // 사원 정보 누를 시 프로필 표시
		$(function() {
			$('#mSearchList td').mouseenter(function() {
				$(this).parent().css({'color':'purple', 'cursor':'pointer'});
			}).mouseout(function() {
				$(this).parent().css({'color':'black'});
			}).click(function() {
				var tdName = $(this).parent().children().eq(1).text();
				var tdJob = $(this).parent().children().eq(2).text();
				var tdDept = $(this).parent().children().eq(3).text();
				var tdPhone = $(this).parent().children().eq(4).text();
				var tdEmail = $(this).parent().children().eq(5).text();
				
				$("#mName").text(tdName);
				$("#mJob").html(tdJob);
				$("#mDept").html(tdDept);
				$("#mPhone").html(tdPhone);
				$("#mEmail").html(tdEmail);
				
			});
		});
		
		// 주소록 검색 버튼
		$("#searchBtn").click(function(){
			var input = $("#input").val();
			var field = $("#field").val();
			
			console.log(input);
			console.log(field);
			
		});
		
		// 주소록 추가 버튼
		$('.addrPlus').click(function() {
			var thisRow = $(this).closest('tr');
			var mId = thisRow.find('td:eq(1)').find('input').val();
			
			console.log(mId);
			
			$.ajax({
				url: "add.addr",
				data: {mId:mId},
				type: "POST",
				success: function(data) {
					console.log(data);
					
					if(data == "success") {
						alert("추가되었습니다.");
						location.reload();
					}
				},
				error: function() {
					console.log(data);
				}
			});
		});
	</script>
	    
    <!-- Datatable -->
    <script src="${contextPath}/resources/assets/vendor/datatables/js/jquery.dataTables.min.js"></script>
    <script src="${contextPath}/resources/assets/js/plugins-init/datatables.init.js"></script>

</body>

</html>