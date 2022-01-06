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
	#clock{
		font-size:42px;
		margin-bottom: 15px;
	}

	#statusSelect{
		width: 50%;
		height: 50px;
	}
	
	#statusSelect option{
		background-color: white;
	}
	#moreView{
		float: right;
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
	.empTable{
		width: 100%;
	}
	.year-month{
		font-size:24px;
		font-weight: bolder;
		text-align:center;
	}
	#baseDate{
		cursor: pointer;
	}
	#nowDate i{
		width: 16px;
    	height: 16px;
    	cursor: pointer;
	}
	.accordion__body--text td{
		width: 100px;
	}
	#workInTime, #workOutTime{
		border:none;
		color: #BDBDC7;
		float: right;
	}
	#workingTime{
		font-size:25px;
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
        <c:set var="year" value="<%=new java.util.Date()%>" />
        <c:set var="month" value="<%=new java.util.Date()%>" />
        
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
								<ul>
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
										<dl>
											<dt>퇴근시간
											<c:choose>
												<c:when test="${empStatus1 != null }">
													<input id="workOutTime" name="workOutTime" value="${empStatus1.getEmpOffTime()}">
												</c:when>
												<c:otherwise>
													<input id="workOutTime" name="workOutTime">
												</c:otherwise>
											</c:choose>	
											</dt>
										</dl>
									</li>
								</ul>
								<div class="basic-dropdown">
                                    <div class="dropdown">
                                         <c:choose>
	                                        <c:when  test="${empStatus1.getEmpStatus() eq '업무종료'}">
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
            
                    <!-- 누적 근태현황영역 -->
                    <div class="col-lg-9">
                        <div class="card">
                            <div class="card-header">
	                        	<span id="empTitle" class="card-title">누적 근태현황</span>	                   					
                            </div>                        		                   
                            <%--<div class="year-month">	
                            	 <c:set var="year"><fmt:formatDate value="${year}" pattern="yyyy" /></c:set>
                                <c:set var="month"><fmt:formatDate value="${month}" pattern="MM" /></c:set>
								<span class="goPrev"><i class="fa fa-angle-left"></i></span>
								<span id="baseDate"><c:out value="${year}" />.<c:out value="${month}" /></span>
								<span class="goNext"><i class="fa fa-angle-right"></i></span> 
							</div>--%>
							
							<div>

        <input type="text" id="choiceYear" style="text-align:center;" value="2022"/>

        &nbsp;년&nbsp;&nbsp;

        <select id="choiceMonth">

            <option value="01">01</option>

            <option value="02">02</option>

            <option value="03">03</option>

            <option value="04">04</option>

            <option value="05">05</option>

            <option value="06">06</option>

            <option value="07">07</option>

            <option value="08">08</option>

            <option value="09">09</option>

            <option value="10">10</option>

            <option value="11">11</option>

            <option value="12">12</option>

        </select>

        &nbsp;월&nbsp;&nbsp;

        <button type="button" onClick="searchPeriodCalculation( );">검색</button>

    </div>
							
                        <div class="card">
                            
                            <div class="card-body">
                                <div id="accordion-four" class="accordion accordion-no-gutter accordion-bordered">
                                <div id="weekDate1"></div>
                                    <div class="accordion__item">
                                        <div class="accordion__header" data-toggle="collapse" data-target="#bordered_no-gutter_collapseOne">
                                            <span class="accordion__header--text">1주차</span>
                                            <span class="accordion__header--indicator style_two"></span>
                                        </div>
                                        <div id="bordered_no-gutter_collapseOne" class="collapse accordion__body show" data-parent="#accordion-four">
                                            <div class="accordion__body--text">
                                                <table class="empTable1">
                                                	<tr clss="weekDate1">
                                                		<td>일자</td>
                                                		<td>업무시작</td>
                                                		<td>업무종료</td>
                                                		<td>총근무시간</td>
                                                		<td>근무시간 상세</td>
                                                	</tr>
                                                	<!-- DB에서 불러와서 append하기 -->
                                                	<tr>
                                                	
                                                	</tr>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="accordion__item">
                                        <div class="accordion__header collapsed" data-toggle="collapse" data-target="#bordered_no-gutter_collapseTwo">
                                            <span class="accordion__header--text">2주차</span>
                                            <span class="accordion__header--indicator style_two"></span>
                                        </div>
                                        <div id="bordered_no-gutter_collapseTwo" class="collapse accordion__body" data-parent="#accordion-four">
                                            <div class="accordion__body--text">
                                                <table class="empTable2">
                                                	<tr clss="weekDate2">
                                                		<td>일자</td>
                                                		<td>업무시작</td>
                                                		<td>업무종료</td>
                                                		<td>총근무시간</td>
                                                		<td>근무시간 상세</td>
                                                	</tr>
                                                	<!-- DB에서 불러와서 append하기 -->
                                                	<tr>
                                                		<td>10:00</td>
                                                		<td>19:00</td>
                                                		<td>8시간</td>
                                                		<td>기본 8시간/ 초과 0시간</td>
                                                	</tr>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="accordion__item">
                                        <div class="accordion__header collapsed" data-toggle="collapse" data-target="#bordered_no-gutter_collapseThree">
                                            <span class="accordion__header--text">3주차</span>
                                            <span class="accordion__header--indicator style_two"></span>
                                        </div>
                                        <div id="bordered_no-gutter_collapseThree" class="collapse accordion__body" data-parent="#accordion-four">
                                            <div class="accordion__body--text">
                                               <table class="empTable3">
                                                	<tr clss="weekDate3">
                                                		<td>일자</td>
                                                		<td>업무시작</td>
                                                		<td>업무종료</td>
                                                		<td>총근무시간</td>
                                                		<td>근무시간 상세</td>
                                                	</tr>
                                                	<!-- DB에서 불러와서 append하기 -->
                                                	<tr>
                                                		<td>10:00</td>
                                                		<td>19:00</td>
                                                		<td>8시간</td>
                                                		<td>기본 8시간/ 초과 0시간</td>
                                                	</tr>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="accordion__item">
                                        <div class="accordion__header collapsed" data-toggle="collapse" data-target="#bordered_no-gutter_collapseFour">
                                            <span class="accordion__header--text">4주차</span>
                                            <span class="accordion__header--indicator style_two"></span>
                                        </div>
                                        <div id="bordered_no-gutter_collapseFour" class="collapse accordion__body" data-parent="#accordion-four">
                                            <div class="accordion__body--text">
                                               <table class="empTable4">
                                                	<tr clss="weekDate4">
                                                		<td>일자</td>
                                                		<td>업무시작</td>
                                                		<td>업무종료</td>
                                                		<td>총근무시간</td>
                                                		<td>근무시간 상세</td>
                                                	</tr>
                                                	<!-- DB에서 불러와서 append하기 -->
                                                	<tr>
                                                		<td>10:00</td>
                                                		<td>19:00</td>
                                                		<td>8시간</td>
                                                		<td>기본 8시간/ 초과 0시간</td>
                                                	</tr>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                       <div class="accordion__item">
                                        <div class="accordion__header collapsed" data-toggle="collapse" data-target="#bordered_no-gutter_collapseFive">
                                            <span class="accordion__header--text">5주차</span>
                                            <span class="accordion__header--indicator style_two"></span>
                                        </div>
                                        <div id="bordered_no-gutter_collapseFive" class="collapse accordion__body" data-parent="#accordion-four">
                                            <div class="accordion__body--text">
                                                <table class="empTable5">
                                                	<tr clss="weekDate5">
                                                		<td>일자</td>
                                                		<td>업무시작</td>
                                                		<td>업무종료</td>
                                                		<td>총근무시간</td>
                                                		<td>근무시간 상세</td>
                                                	</tr>
                                                	<!-- DB에서 불러와서 append하기 -->
                                                	<tr>
                                                		<td>10:00</td>
                                                		<td>19:00</td>
                                                		<td>8시간</td>
                                                		<td>기본 8시간/ 초과 0시간</td>
                                                	</tr>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
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
                                                 <a href="empStatusTotal.em"><p>누적 근태현황</p></a>
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
                                                <a href="annualLeaveMain.al"><p>연차 사용현황</p></a>
                                                <a href="annualLeaveTotal.al"> <p>연차 신청현황</p></a>
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
                                             	<p>누적 근태현황</p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="accordion__item">
                                        <div class="accordion__header collapsed" data-toggle="collapse" data-target="#default_collapseFour">
                                            <span class="accordion__header--text">내 부서 연차현황</span>
                                            <span class="accordion__header--indicator"></span>
                                        </div>
                                        <div id="default_collapseFour" class="collapse accordion__body" data-parent="#accordion-one">
                                            <div class="accordion__body--text">
                                             	<p>연차 사용현황</p>
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
	
	
	
	// 기준요일에 따른 주차구하는 함수.

	    // 해당 주차 / 해당주차 시작날짜 / 해당주차 끝나는날짜를 리턴.
	    
	 function searchPeriodCalculation() {
		//입력한 년도, 월을 가지고 옴
		 let cYear = document.getElementById("choiceYear").value;
	     let cMonth = document.getElementById("choiceMonth").value.replace(/(^0+)/, "") - 1;
	     
	     let date = new Date(cYear, cMonth);
	     let firstDay = new Date(date.getFullYear(), date.getMonth(), 1);
	     let lastDay = new Date(date.getFullYear(), date.getMonth() + 1, 0);
	     var day = lastDay.getDate();
	     //
	     const prevLast = new Date(cYear, cMonth, 0);
	     const thisLast = new Date(cYear, cMonth + 1, 0);

	     const PLDate = prevLast.getDate();//지난달의 마지막날
	     const PLDay = prevLast.getDay();//요일

	     const TLDate = thisLast.getDate();
	     const TLDay = thisLast.getDay();
	     	     
	     console.log("지난달:"+PLDay);
	     
	     for(var i = 0; i < day; i++){
	    	 firstDay.setDate(firstDay.getDate()+i);
	    	console.log(firstDay);
	    	firstDay = new Date(date.getFullYear(), date.getMonth(), 1);
	     }
	     
		
	}
	    
	    
	    
	    
	    
	    
	    

/* 	    function searchPeriodCalculation() {

	        let cYear = document.getElementById("choiceYear").value;
	        let cMonth = document.getElementById("choiceMonth").value.replace(/(^0+)/, "") - 1;

	        // 날짜형으로 데이트 포맷

	        let date = new Date(cYear, cMonth);
			//첫번째 토요일의 날짜를 구한 후 그 전날까지의 숫자 가져오기
			//
	        // 월요일을 중심으로한 주차 구하기( JS기준 : 일요일 0 월요일 1 ~ 토요일 6 )

	        let firstDay = new Date(date.getFullYear(), date.getMonth(), 1);
	        let lastDay = new Date(date.getFullYear(), date.getMonth() + 1, 0);
	        let weekObj = null;
	        let weekObjArray = new Array();
	        let weekStand = 8;  // 월요일 고정
	        let firstWeekEndDate = true;
	        let thisMonthFirstWeek = firstDay.getDay();//1일의 요일 가져옴
	        var day = lastDay.getDate();

	        var minSat = null;
	        console.log("firstDay일:"+firstDay);
	        console.log("요일:"+firstDay.getDay());
	        //myDate.setDate(myDate.getDate() + 1);
	       //firstDay.setDate(firstDay.getDate()+2);
	       
	       
	           for(var i = 1; i < day; i++){
	        	 firstDay.setDate(firstDay.getDate()+i);
	        	 
	        	  console.log("요일"+firstDay.getDay());
		        if(firstDay.getDay() == 6){//검색한 월의 요일이 6일이면
		        	console.log("첫번째토요일:"+firstDay.getDate());
		        	
		        } 
	        }    
	        
	        
	        
	        for(var num = 1; num <= 6; num++) {

	            // 마지막월과 첫번째월이 다른경우 빠져나온다.

	            if(lastDay.getMonth() != firstDay.getMonth()) {
	                break;
	            }

	            weekObj = new Object();

	            // 한주의 시작일은 월의 첫번째 월요일로 설정
	            if(firstDay.getDay() <= 1) {
	                // 한주의 시작일이 일요일이라면 날짜값을 하루 더해준다.
	                if(firstDay.getDay() == 0) { firstDay.setDate(firstDay.getDate() + 1); }

	                weekObj.weekStartDate =

	                      firstDay.getFullYear().toString()

	                    + "-"

	                    + numberPad((firstDay.getMonth() + 1).toString(), 2)

	                    + "-"

	                    + numberPad(firstDay.getDate().toString() , 2);
	            }

	            if(weekStand > thisMonthFirstWeek) {

	                if(firstWeekEndDate) {
	                    if((weekStand - firstDay.getDay()) == 1) {
	                        firstDay.setDate(firstDay.getDate() + (weekStand - firstDay.getDay()) - 1);
	                    }
	                    if((weekStand - firstDay.getDay()) > 1) {
	                        firstDay.setDate(firstDay.getDate() + (weekStand - firstDay.getDay()) - 1)
	                    }
	                    firstWeekEndDate = false;
	                } else {
	                    firstDay.setDate(firstDay.getDate() + 6);
	                }
	            } else {
	                firstDay.setDate(firstDay.getDate() + (6 - firstDay.getDay()) + weekStand);
	            }

	            // 월요일로 지정한 데이터가 존재하는 경우에만 마지막 일의 데이터를 담는다.

	            if(typeof weekObj.weekStartDate !== "undefined") {
	                weekObj.weekEndDate =
	                      firstDay.getFullYear().toString()
	                    + "-"
	                    + numberPad((firstDay.getMonth() + 1).toString(), 2)
	                    + "-"
	                    + numberPad(firstDay.getDate().toString(), 2);	                    
	                weekObjArray.push(weekObj);
	            }
	            firstDay.setDate(firstDay.getDate() + 1);
	        }

	        console.log( weekObjArray );
	        console.log( weekObjArray[0] );
	        
	        console.log("값:"+ weekObjArray[0].weekStartDate);
	        if(weekObjArray[0].weekStartDate.getDate()> 1){//만일 값이 1보다 크면 그 2주차부터 시작하기
	        	console.log("++++++++++++++");
		        for(var i = 0; i < weekObjArray.length; i++){
		        	console.log((i+1) + "주차");
		        	
		        	if(i == 0){
			        	var start = weekObjArray[0].weekStartDate;
			        	var end = weekObjArray[0].weekEndDate;
			        	var startDay = new Date(start);
			        	var endDay = new Date(end);
			        	console.log("시작일:"+ startDay);
			        	console.log("종료일:"+ endDay);
			        	console.log("gfgg"+startDay.getDate(1));
			        	var first = startDay.getDate();
			        	if(first != 1){
			        		
			        		for(var d = 1; d< first; d++){
			        			var firstdate = new Date(date.getFullYear(), date.getMonth(), 1, date.getDate()+d);//22년1월을 클릭시 22년1월1일 출력
			        			console.log("firstdate:" + firstdate);
			        		}
			        	}
			        	
			        	
			        	//시작일과 종료일 사이의 날짜 구하기
			        	var regex = RegExp(/^\d{4}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])$/);
			        	
			        	var result = [];
			        	var curDate = new Date(startDay);
			        	while(curDate <= new Date(endDay)) {
			        		result.push(curDate.toISOString().split("T")[0]);
			        		curDate.setDate(curDate.getDate() + 1);
			        	}
			        	console.log(result);
			        	
			        	for(var k in result){
			        		console.log("K:"+result[k]);
			        		var week1 = "<tr>"+
				                			"<td>"+result[k]+"</td>"+
				                			"<td>10:00</td>"+
	                                		"<td>19:00</td>"+
	                                		"<td>8시간</td>"+
	                                		"<td>기본 8시간/ 초과 0시간</td>"+
				                		"</tr>";
	                		$('.empTable1').children().append(week1);
			        	}
			        	
			        }else if(i == 1){
			        	var start = weekObjArray[1].weekStartDate;
			        	var end = weekObjArray[1].weekEndDate;
			        	var startDay = new Date(start);
			        	var endDay = new Date(end);
			        	console.log("시작일:"+ startDay);
			        	console.log("종료일:"+ endDay);
			        	//시작일과 종료일 사이의 날짜 구하기
			        	var regex = RegExp(/^\d{4}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])$/);
			        	
			        	var result = [];
			        	var curDate = new Date(startDay);
			        	while(curDate <= new Date(endDay)) {
			        		result.push(curDate.toISOString().split("T")[0]);
			        		curDate.setDate(curDate.getDate() + 1);
			        	}
			        	console.log(result);
			        	
			        	for(var k in result){
			        		console.log("K:"+result[k]);
			        		var week2 = "<tr>"+
				                			"<td>"+result[k]+"</td>"+
				                			"<td>10:00</td>"+
	                                		"<td>19:00</td>"+
	                                		"<td>8시간</td>"+
	                                		"<td>기본 8시간/ 초과 0시간</td>"+
				                		"</tr>";
	                		$('.empTable2').children().append(week2);
			        	}
			        	
			        }else if(i == 2){
			        	var start = weekObjArray[2].weekStartDate;
			        	var end = weekObjArray[2].weekEndDate;
			        	var startDay = new Date(start);
			        	var endDay = new Date(end);
			        	console.log("시작일:"+ startDay);
			        	console.log("종료일:"+ endDay);
			        	//시작일과 종료일 사이의 날짜 구하기
			        	var regex = RegExp(/^\d{4}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])$/);
			        	
			        	var result = [];
			        	var curDate = new Date(startDay);
			        	while(curDate <= new Date(endDay)) {
			        		result.push(curDate.toISOString().split("T")[0]);
			        		curDate.setDate(curDate.getDate() + 1);
			        	}
			        	console.log(result);
			        	
			        	for(var k in result){
			        		console.log("K:"+result[k]);
			        		var week3 = "<tr>"+
				                			"<td>"+result[k]+"</td>"+
				                			"<td>10:00</td>"+
	                                		"<td>19:00</td>"+
	                                		"<td>8시간</td>"+
	                                		"<td>기본 8시간/ 초과 0시간</td>"+
				                		"</tr>";
	                		$('.empTable3').children().append(week3);
			        	}
			        	
			        }else if(i == 3){
			        	var start = weekObjArray[3].weekStartDate;
			        	var end = weekObjArray[3].weekEndDate;
			        	var startDay = new Date(start);
			        	var endDay = new Date(end);
			        	console.log("시작일:"+ startDay);
			        	console.log("종료일:"+ endDay);
			        	//시작일과 종료일 사이의 날짜 구하기
			        	var regex = RegExp(/^\d{4}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])$/);
			        	
			        	var result = [];
			        	var curDate = new Date(startDay);
			        	while(curDate <= new Date(endDay)) {
			        		result.push(curDate.toISOString().split("T")[0]);
			        		curDate.setDate(curDate.getDate() + 1);
			        	}
			        	console.log(result);
			        	
			        	for(var k in result){
			        		console.log("K:"+result[k]);
			        		var week4 = "<tr>"+
				                			"<td>"+result[k]+"</td>"+
				                			"<td>10:00</td>"+
	                                		"<td>19:00</td>"+
	                                		"<td>8시간</td>"+
	                                		"<td>기본 8시간/ 초과 0시간</td>"+
				                		"</tr>";
	                		$('.empTable4').children().append(week4);
			        	}
			        }  
		        }
	        }
	    }

	    // 월, 일 날짜값 두자리( 00 )로 변경

	    function numberPad(num, width) {

	        num = String(num);

	        return num.length >= width ? num : new Array(width - num.length + 1).join("0") + num;

	    } */
	    
	    $('#changeStatus').on('change', function(){
			var offClock = document.getElementById("workOutTime");
			var statusValue = $(this).val();

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
							$('#changeStatus').attr("disabled","disabled");
							//input에는 text, innerhtml이 아니라 val를 써서 화면에 출력해야함

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
						} 
					},
					error:function(data){
						console.log(data);
					}
				});
					
		});	
		
	
	</script>









</body>

</html>
