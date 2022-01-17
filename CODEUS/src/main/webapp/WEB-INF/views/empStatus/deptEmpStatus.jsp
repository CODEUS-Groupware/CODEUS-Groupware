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
    <!-- CSS only -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
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
.sec_cal {
    width: 360px;
    margin: 0 auto;
    font-family: "NotoSansR";
}

.sec_cal .cal_nav {
    display: flex;
    justify-content: center;
    align-items: center;
    font-weight: 700;
    font-size: 48px;
    line-height: 78px;
}

.sec_cal .cal_nav .year-month {
    width: 300px;
    text-align: center;
    line-height: 1;
}

.sec_cal .cal_nav .nav {
    display: flex;
    border: 1px solid #333333;
    border-radius: 5px;
}

.sec_cal .cal_nav .go-prev,
.sec_cal .cal_nav .go-next {
    display: block;
    width: 50px;
    height: 78px;
    font-size: 0;
    display: flex;
    justify-content: center;
    align-items: center;
}

.sec_cal .cal_nav .go-prev::before,
.sec_cal .cal_nav .go-next::before {
    content: "";
    display: block;
    width: 20px;
    height: 20px;
    border: 3px solid #000;
    border-width: 3px 3px 0 0;
    transition: border 0.1s;
}

.sec_cal .cal_nav .go-prev:hover::before,
.sec_cal .cal_nav .go-next:hover::before {
    border-color: #ed2a61;
}

.sec_cal .cal_nav .go-prev::before {
    transform: rotate(-135deg);
}

.sec_cal .cal_nav .go-next::before {
    transform: rotate(45deg);
}

.sec_cal .cal_wrap {
    padding-top: 40px;
    position: relative;
    margin: 0 auto;
}

.sec_cal .cal_wrap .days {
    display: flex;
    margin-bottom: 20px;
    padding-bottom: 20px;
    border-bottom: 1px solid #ddd;
}

.sec_cal .cal_wrap::after {
    top: 368px;
}

.sec_cal .cal_wrap .day {
    display:flex;
    align-items: center;
    justify-content: center;
    width: calc(100% / 7);
    text-align: left;
    color: #999;
    font-size: 12px;
    text-align: center;
    border-radius:5px
}

.current.today {background: rgb(242 242 242);}

.sec_cal .cal_wrap .dates {
    display: flex;
    flex-flow: wrap;
    height: 290px;
}

.sec_cal .cal_wrap .day:nth-child(7n -1) {
    color: #3c6ffa;
}

.sec_cal .cal_wrap .day:nth-child(7n) {
    color: #ed2a61;
}

.sec_cal .cal_wrap .day.disable {
    color: #ddd;
}

#monthWortkTime *{
	text-align:center;
}
#deptTotalTable {
	width: 620px;
}
#deptTotalTable th, td{
	min-width: 130px!important;
    max-width: 140px!important;
    text-align: center;
}
#deptTotalTable th{
	border-bottom: 1px solid gray;
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
            
                    <!-- 누적 근태현황영역 -->
                    <div class="col-lg-9">
                        <div class="card">
                            <div class="card-header">
	                        	<span id="empTitle" class="card-title">누적 근태현황</span>	                   					
                            </div>                        		                   
                            
				<div class="sec_cal">
					  <div class="cal_nav">
					    <a href="javascript:;" class="nav-btn go-prev">prev</a>
					    <div class="year-month"></div>
					    <a href="javascript:;" class="nav-btn go-next">next</a>
					  </div>
				<div style="display:none;">
					  <div class="cal_wrap">
					    <div class="days">
					      <div class="day">MON</div>
					      <div class="day">TUE</div>
					      <div class="day">WED</div>
					      <div class="day">THU</div>
					      <div class="day">FRI</div>
					      <div class="day">SAT</div>
					      <div class="day">SUN</div>
					    </div>
					    <div class="dates"></div>
					  </div>
				</div>	  	  
				</div>		
		
                       <div class="card">
                            
                            <div class="card-body" id="deptDiv">
                               <table  id="deptTotalTable">
                               		<thead>
	                               		<th>이름</th>
	                               		<th>한달 근무시간</th>
	                               		<th>한달 초과근무시간</th>
	                               		<th id="worktable"></th>
                               		</thead>
                               		<tbody>
                               			
                               		</tbody>
                               </table>
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
                                             	<a href="deptEmpStatus.em"><p>누적 근태현황</p></a>
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
                                             	<a href="deptLeaveStatus.al"><p>연차 사용현황</p></a>
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
	    
	$(document).ready(function() {
	    calendarInit();
	});
	 var $window = $(window);
	 	var nav = $('.fixed-button');
	 	    $window.scroll(function(){
	 	        if ($window.scrollTop() >= 200) {
	 	        nav.addClass('active');
	 	    }
	 	    else {
	 	        nav.removeClass('active');
	 	    }
	 	});
	/*
	    달력 렌더링 할 때 필요한 정보 목록 

	    현재 월(초기값 : 현재 시간)
	    금월 마지막일 날짜와 요일
	    전월 마지막일 날짜와 요일
	*/
	
	var date = new Date(); // 현재 날짜(로컬 기준) 가져오기
    var utc = date.getTime() + (date.getTimezoneOffset() * 60 * 1000); // uct 표준시 도출
    var kstGap = 9 * 60 * 60 * 1000; // 한국 kst 기준시간 더하기
    var today = new Date(utc + kstGap); // 한국 시간으로 date 객체 만들기(오늘)
  
    var thisMonth = new Date(today.getFullYear(), today.getMonth(), today.getDate());
    // 달력에서 표기하는 날짜 객체
  
    
    var currentYear = thisMonth.getFullYear(); // 달력에서 표기하는 연
    var currentMonth = thisMonth.getMonth(); // 달력에서 표기하는 월
    var currentDate = thisMonth.getDate(); // 달력에서 표기하는 일

	function calendarInit() {

	    // 날짜 정보 가져오기
	    var date = new Date(); // 현재 날짜(로컬 기준) 가져오기
	    var utc = date.getTime() + (date.getTimezoneOffset() * 60 * 1000); // uct 표준시 도출
	    var kstGap = 9 * 60 * 60 * 1000; // 한국 kst 기준시간 더하기
	    var today = new Date(utc + kstGap); // 한국 시간으로 date 객체 만들기(오늘)
	  
	    var thisMonth = new Date(today.getFullYear(), today.getMonth(), today.getDate());
	    // 달력에서 표기하는 날짜 객체
	  
	    
	    var currentYear = thisMonth.getFullYear(); // 달력에서 표기하는 연
	    var currentMonth = thisMonth.getMonth(); // 달력에서 표기하는 월
	    var currentDate = thisMonth.getDate(); // 달력에서 표기하는 일
		var currentDay = thisMonth.getDay();

	    // kst 기준 현재시간
	    
	    // console.log(thisMonth);

	    // 캘린더 렌더링
	    renderCalender(thisMonth);

	    function renderCalender(thisMonth) {

	        // 렌더링을 위한 데이터 정리
	        currentYear = thisMonth.getFullYear();
	        currentMonth = thisMonth.getMonth();
	        currentDate = thisMonth.getDate();
	        currentDay = thisMonth.getDay();
	        var nowDate = new Date(currentYear, currentMonth, 1);
	        var currentYearMonth = currentYear + "" +(currentMonth+1);
	       
	        var lastDate = new Date(currentYear, currentMonth+1, 0).getDate();
	        var monthSWeek = nowDate.getDay();
	        var weekSeq = parseInt((parseInt(lastDate) + monthSWeek - 1)/7)+1;
		 	  console.log(currentYearMonth);
		 	 console.log(lastDate);
		 	 console.log("monthWeek:"+monthSWeek);
		 	  console.log(weekSeq);
	
		 	  
		 	// 이번 주 show
		 	    // 오늘 날짜에 이번달 시작하는 요일의 getDay를 더해서 한 주를 7의 배수로 만들기
		 	     var today = new Date();
		 	  //  var first = new Date(today.getFullYear(), today.getMonth(), 1);
		 	    var selectedDay = today.getDate();
		 	    var monthFirst = nowDate.getDay();
		 	    var todayWeek = Math.ceil((selectedDay + monthFirst) / 7);
		 	   	var dayList = ['일','월','화','수','목','금','토'];
		 	    var thisWeek = $('#'+todayWeek+'WeekTable').parents('.collapse');
		 	    thisWeek.addClass('show');
		 	    thisWeek.prev().find('i').removeClass('icofont-rounded-down').addClass('icofont-rounded-up');
		 	   
		 	    currentMonth1 = currentMonth+1;
		 		currentMonth1 = (currentMonth1 < 10) ? "0" + currentMonth1 : currentMonth1;
		 		console.log("현재월:"+currentMonth1);


		 	  
	        
	        $.ajax({
		    	url:'deptWorkTime.em',
		    	data:{currentYearMonth:currentYearMonth,
		    		currentYear:currentYear,
		    		currentMonth1:currentMonth1,
		    		weekSeq:weekSeq,
		    	},
		    	dataType: 'json',
		    	success:function(data){
		    		console.log("부서별 성공");
					console.log(data);	
					for(var i = 1; i <= weekSeq; i++){
						var cl = "<th>"+i+"주차"+"</th>";

                     $('#worktable').append(cl);
					}
					 $tableBody = $('#deptTotalTable tbody');
					 $tableBody.html('');
					 
					 
					
						$.ajax({
							url:'personalWorkTime.em',
					    	data:{currentYearMonth:currentYearMonth,
					    		currentYear:currentYear,
					    		currentMonth1:currentMonth1,
					    		weekSeq:weekSeq,
					    	},
					    	dataType: 'json',
					    	success:function(result){
					    		console.log("주별 성공");
								console.log(result);	
								for(var i in data){
									console.log(data[i].weekNum);
									console.log(typeof data[i].weekNum);
									console.log(data[i].monthWork);
								   $tr = $('<tr>');
									$id = $('<td>').text(data[i].mId);
									$monthWork = $('<td>').text(data[i].monthWork);
									$monthOver = $('<td>').text(data[i].monthOver);
									console.log(data[i].weekNum == 1);
									$tr.append($id);	
									$tr.append($monthWork);
									$tr.append($monthOver);
									$tableBody.append($tr);
								 
														
									
									for(var j in result){
										console.log(j+"j:"+result[j].mId);
										 if(result[j].mId == data[i].mId){
											//같은사원의 td로 출력되게 하기..
											$work = $('<td>').text(result[j].strGapTime);
											$tr.append($work);
											$tableBody.append($tr);
										} 
									}
									
									
								
								}
					    		
					    	},
					    	error:function(result){
								console.log(result);	
					    	}
						});
					
					 /* for(var i = 1; i <= weekSeq; i++){
						var cl = "<th>"+i+"주차"+"</th>";

                     $('#worktable').append(cl);
					} 
					 
					 $tableBody = $('#deptTotalTable tbody');
					 $tableBody.html('');
						 for(var i in data){
							console.log(data[i].weekNum);
							console.log(typeof data[i].weekNum);
							console.log(data[i].strGapTime);
						   $tr = $('<tr>');
							$id = $('<td>').text(data[i].mId);
							$monthWork = $('<td>').text(data[i].monthWork);
							$monthOver = $('<td>').text(data[i].monthOver);
							console.log(data[i].weekNum == 1);
								 if(data[i].weekNum == 1){
								$firstWork = $('<td>').text(data[i].strGapTime);
							}else if(data[i].weekNum == 2){
								$secondWork = $('<td>').text(data[i].strGapTime);
							}else if(data[i].weekNum == 3){
								$thirdWork = $('<td>').text(data[i].strGapTime);
							}else if(data[i].weekNum == 4){
								$forthWork = $('<td>').text(data[i].strGapTime);
							}else if(data[i].weekNum == 5){
								$fifthWork = $('<td>').text(data[i].strGapTime);
							}else if(data[i].weekNum == 6){
								$sixthWork = $('<td>').text(data[i].strGapTime);
							}else{
								$nonWeek =  $('<td>').text(data[i].strGapTime);
							}
							$tr.append($id);	
							$tr.append($monthWork);
							$tr.append($monthOver);
							$tr.append($firstWork);
							$tr.append($secondWork);
							$tr.append($thirdWork);
							$tr.append($forthWork);
							$tr.append($fifthWork);
							$tr.append($sixthWork);	 
							$tableBody.append($tr);
					 }  */
 
		    	},
		    	error:function(data){
					console.log(data);
				}
		    });

	        // 이전 달의 마지막 날 날짜와 요일 구하기
	        var startDay = new Date(currentYear, currentMonth, 0);
	        var prevDate = startDay.getDate();
	        var prevDay = startDay.getDay();

	        // 이번 달의 마지막날 날짜와 요일 구하기
	        var endDay = new Date(currentYear, currentMonth + 1, 0);
	        var nextDate = endDay.getDate();
	        var nextDay = endDay.getDay();

	        // console.log(prevDate, prevDay, nextDate, nextDay);
	    

	        // 현재 월 표기
	        $('.year-month').text(currentYear + '.' + (currentMonth + 1));
			
	        // 렌더링 html 요소 생성
	        calendar = document.querySelector('.dates')
	        calendar.innerHTML = '';
	        
	        // 지난달
	        for (var i = prevDate - prevDay + 1; i <= prevDate; i++) {
	            calendar.innerHTML = calendar.innerHTML + '<div class="day prev disable">' + i + '</div>'
	        }
	        // 이번달
	        for (var i = 1; i <= nextDate; i++) {
	            calendar.innerHTML = calendar.innerHTML + '<div class="day current">' + i + '</div>'
	        }
	        // 다음달
	        for (var i = 1; i <= (7 - nextDay == 7 ? 0 : 7 - nextDay); i++) {
	            calendar.innerHTML = calendar.innerHTML + '<div class="day next disable">' + i + '</div>'
	        }

	        // 오늘 날짜 표기
	        if (today.getMonth() == currentMonth) {
	            todayDate = today.getDate();
	            var currentMonthDate = document.querySelectorAll('.dates .current');
	            currentMonthDate[todayDate -1].classList.add('today');
	        }
	    }

	    // 이전달로 이동
	    $('.go-prev').on('click', function() {
	        thisMonth = new Date(currentYear, currentMonth - 1, 1);
	       
	        $('#worktable').children().remove();
	        renderCalender(thisMonth);
	   
	        
	     
	    });

	    // 다음달로 이동
	    $('.go-next').on('click', function() {
	        thisMonth = new Date(currentYear, currentMonth + 1, 1);
	       
	        $('#worktable').children().remove();
	        renderCalender(thisMonth); 
	       
	     
	
	    });
	} 

	
	
	</script>









</body>

</html>
