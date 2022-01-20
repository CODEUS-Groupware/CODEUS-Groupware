<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.codeusgroup.codeus.empStatus.model.vo.EmpStatus"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	EmpStatus empStatus1 = (EmpStatus)session.getAttribute("empStatus1");
	EmpStatus empOffTime = (EmpStatus)session.getAttribute("empOffTime");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>main page</title>
    <link href="${contextPath}/resources/assets/vendor/pg-calendar/css/pignose.calendar.min.css" rel="stylesheet">
    <link href="${contextPath}/resources/assets/vendor/chartist/css/chartist.min.css" rel="stylesheet">
</head>
<style>
	.container-fluid{
	
	}
	#nowDateArea{
		color:black;
	}
	
	#clock{
		font-size:35px;
		margin-bottom: 15px;
		color: black;
	}

	#statusSelect{
		width: 50%;
		height: 50px;
	}
	
	#statusSelect option{
		background-color: white;
	}

	.card-header{
		width:100%; position:relative;
	}
	#empTitle{
		font-family: 'Noto Sans KR',맑은 고딕,돋움, malgun gothic, dotum,AppleGothic,Helvetica,sans-serif;
		font-size: 30px;
		font-weight: bolder;
	}
	#totalTitle{
		font-family: 'Noto Sans KR',맑은 고딕,돋움, malgun gothic, dotum,AppleGothic,Helvetica,sans-serif;
		font-size: 30px;
		font-weight: bolder;
	}
	
	 #annualSearch input{
		display: inline;
	} 
	#searchIcon{
		height: 35px;
		padding: 0px;
		margin:0px;
	}
	#searchWordValue{
		display: inline;
		width: 200px;
	}
	#searchCondition{
		height: 35px;
		border: 1px solid #eaeaea;
	}
	#searchBtn{
		border: 0;
		outline:0;
		background-color: white;
	}
	#searchSpan{
		padding-top:7px;
	}
	#workInTime, #workOutTime{
		border:none;
		color: black;
		float: right;
	}
	#workingTime{
		font-size:25px;
	}
	#leaveContent{
		color:black;
	}
	
</style>

<body onload="printClock()">
	
    <!--**********************************
        Main wrapper start
    ***********************************-->
    <div id="main-wrapper">

		<c:import url="../common/menubar.jsp"/>

        <!--**********************************
            Content body start
        ***********************************-->
       
        <c:set var="today" value="<%=new java.util.Date()%>" />
        
        <div class="content-body">
            <div class="container-fluid">
				<div class="col-xl-12 col-xxl-6 col-lg-6 col-md-12">
                	<div class="row">
                	
                    </div>
                </div>
            
            <!-- 출,퇴근시간 영역 -->
                <div class="row">
              
                    <div class="col-lg-3">
                        <div class="card">
                            <div class="card-body" id="nowDateDiv">
                                <div id="nowDateArea">
                                	<c:set var="date"><fmt:formatDate value="${today}" pattern="yyyy-MM-dd(E)" /></c:set>
									 <c:out value="${date}" />
									 <div id="clock"></div>
								</div>
								<ul style="color:black;">
									<li>
										출근시간
										<c:choose>
											<c:when test="${empStatus1 != null }">
												<input id="workInTime" name="workInTime" value="${empStatus1.getEmpOnTime()}">
											</c:when>
											<c:otherwise>
												<input id="workInTime" name="workInTime">
											</c:otherwise>
										</c:choose>											
									</li>
									<li>
										퇴근시간
										<c:choose>
											<c:when test="${empStatus1 != null }">
												<input id="workOutTime" name="workOutTime" value="${empStatus1.getEmpOffTime()}">
											</c:when>
											<c:otherwise>
												<input id="workOutTime" name="workOutTime">
											</c:otherwise>
										</c:choose>	
									</li>
								</ul>
								<div class="basic-dropdown">
                                    <div class="dropdown">
                                        <c:choose>
	                                       <c:when  test="${empStatus1.getEmpStatus() eq '업무종료' || empStatus1.getEmpOffTime() ne null}">
		                                        <select id="changeStatus" disabled="disabled">
		                                        	<option value="업무상태선택">업무상태선택</option>
		                                        	<option value="업무">업무</option>
		                                        	<option value="업무종료" selected="selected">업무종료</option>
		                                        	<option value="외근">외근</option>
		                                        	<option value="출장">출장</option>
		                                        	<option value="반차">반차</option>
		                                        </select>
	                                        </c:when>
	                                         
	                                        <c:otherwise>
	                                        	<select id="changeStatus">
	                                        	<option value="업무상태선택">업무상태선택</option>	                                        
	                                        	<option value="업무" <c:if test="${empStatus1.getEmpStatus() eq '업무'}">selected</c:if>>업무</option>
	                                        	<option value="업무종료">업무종료</option>
	                                        	<option value="외근" <c:if test="${empStatus1.getEmpStatus() eq '외근'}">selected</c:if>>외근</option>
	                                        	<option value="출장" <c:if test="${empStatus1.getEmpStatus() eq '출장'}">selected</c:if>>출장</option>
	                                        	<option value="반차" <c:if test="${empStatus1.getEmpStatus() eq '반차'}">selected</c:if>>반차</option>
	                                        </select>
	                                        </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
								
                            </div>
                        </div>
                    </div>
            
                    <!-- 일일 근태현황영역 -->
                    <div class="col-lg-9">
                        <div class="card">
                            <div class="card-header">
	                            <span id="empTitle" class="card-title">내 연차 신청현황</span>		                                                   					
                            </div>  
                            <!-- 게시물 검색 -->                      		                   
                            <div class="card-body">
	                            <div id="annualSearch" class="search_bar dropdown">
	                            	<form action="${ contextPath }/leaveSearch.al" method="get" class="form-inline">
	                            		
					                    <select class="form-control" id="searchCondition" name="searchCondition" >
											<option value="status">결재상태</option>
											<option value="title">제목</option>
											<option value="content">내용</option>
										</select>
					                    <input type="search" id="searchValue" class="form-control" name="searchValue" placeholder="검색" required autocomplete="off">
					                    <span id="searchSpan" class="search_icon c-pointer">
					                   		 <button id="searchBtn"><i id="searchIcon" class="mdi mdi-magnify"></i></button>
					                    </span> 		 
		                            </form>
	                            </div>
                                <div class="table-responsive">
                                	<table id="leaveContent" class="table table-hover table-responsive-sm" style="color: black; text-align: center;">
                                   		<thead>	
                                   			 <tr>
                                            	<th style="width: 100px;">
													결재번호
                                                </th> 
                                                <th style="width: 100px;">
													상태
                                                </th> 
                                                <th style="width: 150px;">
													신청날짜
                                                </th>
                                                <th style="width: 150px;">
													결재양식
                                                </th> 
                                                <th>
													제목
                                                </th>                                               
                                            </tr>
                                        </thead>
                                        <tbody>
                                        	<c:if test="${lrList ne null }">
	                                            <c:forEach var="lr" items="${ lrList }">
	                                            <tr>
	                                            	<td>
														${lr.leaveNum }
	                                                </td> 
	                                                <td>
														${lr.leaveStatus }
	                                                </td> 
	                                                <td>
														 ${lr.enrollDate}
	                                                </td> 
	                                                <td>
														 ${lr.formName }
	                                                </td>
	                                                <td>
														 ${lr.leaveName }
	                                                </td>                                               
	                                            </tr>
	                                            </c:forEach>
	                                       </c:if>
	                                       <c:if test="${empty lrList}">
	                                       	<tr>
	                                       		<td colspan="5">등록된 결재가 없습니다.</td>
	                                       	</tr>
	                                       </c:if>     
                                         </tbody>                                                                                           
                                    </table>
                                </div>
                                <script>
								$(function(){
									$('#leaveContent td').mouseenter(function(){
										$(this).parent().css({'color':'yellowgreen', 'font-weight':'bold', 'cursor':'pointer'});
									}).mouseout(function(){
										$(this).parent().css({'color':'black','font-weight':'normal'});
									}).click(function(){
										var bId = $(this).parent().children().eq(0).text();
										location.href="bdetail.bo?bId=" + bId + '&page=' + ${pi.currentPage};
									});
								});
							
						
						</script> 
                            </div>
                            <!-- 페이징 처리 -->
							<div id="paginationArea" style="margin-left: auto; margin-right: auto;">
		                       <nav>
		                             <ul class="pagination pagination-xs pagination-circle">
												
									<!-- [이전] -->
									<c:if test="${ pi.currentPage <= 1 }">
									<li class="page-item page-indicator disabled">
			                        <a class="page-link">
			                            <i class="icon-arrow-left"></i>
			                        </a>                                     
		                            </li>
									</c:if>
									<c:if test="${ pi.currentPage > 1 }">
										<c:url var="before" value="${loc}">
											<c:param name="page" value="${ pi.currentPage - 1 }"/>
											<c:if test="${ searchValue ne null }">
												<c:param name="searchSelectWord" value="${ searchCondition }"/>
												<c:param name="searchWordValue" value="${ searchValue }"/>
											</c:if>
										</c:url>
									<li class="page-item page-indicator">
		                               <a class="page-link" href="${ before }">
		                                  <i class="icon-arrow-left"></i>
		                              </a>
		                            </li> 	
									</c:if>
														
									<!-- 페이지 -->
									<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
										<c:if test="${ p eq pi.currentPage }">
											<li class="page-item active"><a class="page-link">${ p }</a></li>
										</c:if>														
										<c:if test="${ p ne pi.currentPage }">
											<c:url var="pagination" value="${ loc }">
												<c:param name="page" value="${ p }"/>
												<c:if test="${ searchCondition ne null }">
												 	<c:param name="searchSelectWord" value="${ searchCondition }"/>
													<c:param name="searchWordValue" value="${ searchValue }"/>
												</c:if>
											</c:url>
											<li class="page-item"><a class="page-link" href="${ pagination }">${ p }</a></li>
										</c:if>
									</c:forEach>													
									<!-- [다음] -->
									<c:if test="${ pi.currentPage >= pi.maxPage }">
										<li class="page-item page-indicator disabled">
	                                        <a class="page-link">
	                                           <i class="icon-arrow-right"></i>
	                                        </a>
	                                    </li>
									</c:if>
									<c:if test="${ pi.currentPage < pi.maxPage }">
										<c:url var="after" value="${ loc }">
											<c:param name="page" value="${ pi.currentPage + 1 }"/>
											<c:if test="${ searchCondition ne null }">
											 	<c:param name="searchSelectWord" value="${ searchCondition }"/>
												<c:param name="searchWordValue" value="${ searchValue }"/>
											</c:if>
										</c:url> 
										<li class="page-item page-indicator">
	                                       <a class="page-link" href="${ after }">
	                                           <i class="icon-arrow-right"></i>
	                                      </a>
	                                    </li>
									</c:if>
								</ul>
			                 </nav>
			               </div>
                        </div>
                    </div>
                    <div class="col-xl-12 col-xxl-6 col-lg-6 col-md-12">
                	<div class="row">
                    </div>
                </div>
            </div>
                 <div class="row">
                    <div class="col-lg-3">
                        <div class="card">
                            <div class="card-body">
                                <!-- Default accordion -->
                                <div id="accordion-one" class="accordion">
                                    <div class="accordion__item">
                                        <div class="accordion__header collapsed" data-toggle="collapse" data-target="#default_collapseOne">
                                            <span class="accordion__header--text">내 근태현황</span>
                                            <span class="accordion__header--indicator"></span>
                                        </div>
                                        <div id="default_collapseOne" class="collapse accordion__body" data-parent="#accordion-one">
                                            <div class="accordion__body--text">
                                                <a href="empStatusTotal.em" style="color:black;"><p>누적 근태현황</p></a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="accordion__item">
                                        <div class="accordion__header collapsed" data-toggle="collapse" data-target="#default_collapseTwo">
                                            <span class="accordion__header--text">내 연차현황</span>
                                            <span class="accordion__header--indicator"></span>
                                        </div>
                                        <div id="default_collapseTwo" class="collapse accordion__body" data-parent="#accordion-one">
                                            <div class="accordion__body--text">
                                                  <a href="annualLeaveMain.al" style="color:black;"><p>연차 사용현황</p></a>
                                                  <a href="annualLeaveTotal.al" style="color:black;"> <p>연차 신청현황</p></a>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- 부서장이 로그인 할 경우 아래 2개 영역 보이게 하기 -->
                                    <div class="accordion__item">
                                        <div class="accordion__header collapsed" data-toggle="collapse" data-target="#default_collapseThree">
                                            <span class="accordion__header--text">내 부서 근태현황</span>
                                            <span class="accordion__header--indicator"></span>
                                        </div>
                                        <div id="default_collapseThree" class="collapse accordion__body" data-parent="#accordion-one">
                                            <div class="accordion__body--text">
                                             	<a href="deptEmpStatus.em" style="color:black;"><p>누적 근태현황</p></a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                           
                        </div>
                        <!-- /# card -->
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

        <!--**********************************
           Support ticket button start
        ***********************************-->

        <!--**********************************
           Support ticket button end
        ***********************************-->


    </div>
    <!--**********************************
        Main wrapper end
    ***********************************-->

    <!--**********************************
        Scripts
    ***********************************-->
    <script src="${contextPath}/resources/assets/vendor/chartist/js/chartist.min.js"></script>

    <script src="${contextPath}/resources/assets/vendor/moment/moment.min.js"></script>
    <script src="${contextPath}/resources/assets/vendor/pg-calendar/js/pignose.calendar.min.js"></script>


    <script src="${contextPath}/resources/assets/js/dashboard/dashboard-2.js"></script>
    
    <script>
	//현재시간 출력
	function printTime() {
	
		var clock = document.getElementById("clock");// 출력할 장소 선택
	    var now = new Date();// 현재시간
	    var nowTime =  now.getHours() + "시" + now.getMinutes() + "분" + now.getSeconds() + "초";
	
	    clock.innerHTML = nowTime;// 현재시간을 출력
	    setTimeout("printTime()",1000); // setTimeout(“실행할함수”,시간) 시간은1초의 경우 1000
	}
	
	window.onload = function() {// 페이지가 로딩되면 실행
		printTime();
	}
	
	//출근시간 출력
	var onClock = document.getElementById("workInTime");// 출력할 장소 선택
	var now = new Date();
	var nowTime =  now.getHours() + "시" + now.getMinutes() + "분" + now.getSeconds() + "초";//현재시간
	workInTime.innerHTML = nowTime;

	
	//업무상태변경 클릭시 해당 상태로 출력
	$('#selectStatus li').on('click', function(){
		console.log(123);
		var selectedStatus = $(this).text();
		var a = $('#changeStatus').text(selectedStatus);
		console.log(selectedStatus);
	});
	
	
	//일일 누적시간 계산
	var now = new Date();
	var nowTime = now.getHours() + "시" + now.getMinutes() + "분" + now.getSeconds() + "초";//현재시간
	var onTime = workInTime.innerHTML;//출근시간(DB에서 가져오기)
	var 간격 = nowTime - onTime;
	console.log("현재시간:"+nowTime);
	console.log("onTime:"+nowTime);
	
	//*****누적시간 계산하기....
	//console.log(now.getHours() - nowTime.getHours());
	
	$('#changeStatus').on('change', function(){
		var offClock = document.getElementById("workOutTime");
		var statusValue = $(this).val();
		console.log(statusValue);
		 if(statusValue=="업무종료"){
			$('#changeStatus').prop("disabled",  true);
		} 
		
		var now = new Date();
		var nowDate =  now.getFullYear() + "/" + (now.getMonth()+1)+"/"+now.getDate();
		var offTime = now.getHours() + ":" + now.getMinutes() + ":" + now.getSeconds() ;//현재시간
		var off = new Date();
		
			$.ajax({
				url:'updateStatus.em',
				data:{
					statusValue:statusValue, 
					offTime:offTime,
					off:off
					},
				dataType: 'json',
				success:function(data){
					console.log(data);	
	
					if(statusValue == "업무종료"){
						$('#changeStatus').prop("disabled",  true);
						var date = new Date(data.empOffTime);
						 var month = date.getMonth() + 1;
						 var day = date.getDate();
						 var hour = date.getHours();
						 var minute = date.getMinutes();
						 var second = date.getSeconds();

				        month = month >= 10 ? month : '0' + month;
				        day = day >= 10 ? day : '0' + day;
				        hour = hour >= 10 ? hour : '0' + hour;
				        minute = minute >= 10 ? minute : '0' + minute;
				        second = second >= 10 ? second : '0' + second;

				        var offDate = date.getFullYear() + '-' + month + '-' + day + ' ' + hour + ':' + minute + ':' + second;
						
				        console.log("툌:"+offDate);

						$('#workOutTime').val(offDate);
					}else{
						console.log("실패");
					}
										
					
				},
				error:function(data){
					console.log("+++++++++");
					console.log(data);
				}
			});
		
		
	});
	//게시글 클릭시 detail로 이동
	$(function(){
		$('#leaveContent td').click(function(){
			var bId = $(this).parent().children().eq(0).text();
			location.href="leaveDetail.al?mId=" + mId + '&page=' + ${pi.currentPage};
		});
	});


	</script>









</body>

</html>
