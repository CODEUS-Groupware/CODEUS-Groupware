<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.codeusgroup.codeus.empStatus.model.vo.EmpStatus"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


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
		color:black;
	}

	.dropdown{
		color: 
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
	#workInTime, #workOutTime{
		border:none;
		color: #BDBDC7;
		float: right;
		color:black;
	}
	#workingTime, #workingTime1{
		font-size:25px;
	}
	#WorkTable th, td{
		color:black;
	
	}
	#workTable td{
			border-top:1px solid black;
	}
	#dailyDateArea{
		float:left;
	}
	

	

</style>

<body>
	
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
                                       <!--  <button type="button" id="changeStatus"class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
                                           	 업무상태변경
                                        </button>
                                        <div id="selectStatus" class="dropdown-menu">
                                            <li class="dropdown-item">업무</li>
                                            <li class="dropdown-item">업무종료</li>
                                            <li class="dropdown-item">외근</li>
                                            <li class="dropdown-item">출장</li>
                                            <li class="dropdown-item">반차</li>
                                        </div> -->
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
	                                        	<option value="업무종료" <c:if test="${empStatus1.getEmpStatus() eq '업무종료'}">selected</c:if>>업무종료</option>
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
	                                <span id="empTitle" class="card-title">일일 근태현황</span>	                   					
                            </div>                        		                   
                            <div class="card-body">
                                <div class="table-responsive">
                                	<table id="WorkTable" class="table table-hover table-responsive-sm" style="color: black; text-align: center;">                              
                                        <thead>
                                            <tr>
                                                <th>
                                                	<div id="dailyDateArea">
					                                	<c:set var="date"><fmt:formatDate value="${today}" pattern="yyyy-MM-dd(E)" /></c:set>
														 <c:out value="${date}" />
														 <div id="clock"></div>
													</div>
												</th>
                                            </tr>
                                        </thead>
                                        <tbody style="color:black;">
                                            <tr>
                                                <td>
													업무시간
                                                </td> 
                                                <td>
													초과근무시간
                                                </td>                                               
                                            </tr>
                                            <tr>
                                            <c:choose>
                                            	<c:when test="${empStatus1.getEmpStatus() eq '업무종료' && empStatus1.getEmpOffTime() ne null}">                                           		                                            			
			                                           <td style="height: 90px;" id="workingTime">
			                                                	${ empStatus1.strGapTime }
			                                           </td>
			                                       <c:choose>
			                                            <c:when test="${empStatus1.getOverTime() ne null}">
			                                                <td id="overTime">
																 ${ empStatus1.strOverTime }
			                                                </td>
			                                            </c:when>
			                                            <c:otherwise>
			                                            	<td id="overTime">
																 
			                                                </td>
			                                            </c:otherwise> 
		                                            </c:choose>
	                                            </c:when>
	                                            <c:otherwise>
	                                            	<td style="height: 90px;" id="workingTime1">
																
			                                        </td>
			                                        <td id="overTime">
																 
			                                        </td>
	                                            </c:otherwise>
                                            </c:choose>                                                  
                                            </tr>
                                        </tbody>
                                    </table>
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
                     <div class="col-lg-9">
                        <div class="card">
                            <div class="card-header">
                                <span id="totalTitle" class="card-title">누적 근태현황</span>
                   				<span class="breadcrumb-item active"><a id="moreView" href="empStatusTotal.em">더보기</a></span>		
                            </div>
                            
                            <div class="card-body">
                                <div class="table-responsive">
                                <table id="totalWorkTime" class="table table-hover table-responsive-sm" style="color: black; text-align: center;">                              
                                        <thead>                                        
                                            <tr>
                                                <th>
													이번 주 업무시간
                                                </th> 
                                                <th> 
													이번 주 초과근무시간
                                                </th>  
                                                <th>
													이번 달 업무시간
                                                </th> 
                                                <th>
													이번 달 초과근무시간
                                                </th>                                                
                                            </tr>
                                            <tr>
                                       </thead>
                                       <tbody>
                                          <c:choose>
                                            	<c:when test="${empWeekTime.strGapTime ne '::' || empWeekTime.strGapTime ne null}">
	                                                <td style="height: 90px; font-size:25px;">
														${empWeekTime.strGapTime }
	                                                </td>
	                                            </c:when>
	                                            <c:otherwise>
	                                            	<td style="height: 90px;">
														
	                                                </td>
	                                            </c:otherwise>
                                            </c:choose> 
                                            <c:choose>
                                            	<c:when test="${empWeekTime.strOverTime ne '::'|| empWeekTime.strOverTime ne null}">
	                                                <td style="height: 90px; font-size:25px;">
														${empWeekTime.strOverTime }
	                                                </td>
	                                            </c:when>
	                                            <c:otherwise>
	                                            	<td>
	                                                </td>
	                                            </c:otherwise>
                                            </c:choose> 
                                            <%--  <td style="height: 90px; font-size:25px;">
													${empWeekTime.strGapTime }
                                                </td> 
                                                <td style="height: 90px; font-size:25px;">
													${empWeekTime.strOverTime }
                                                </td>   --%>
                                                 <td style="height: 90px; font-size:25px;" >
													${empMonthTime.strGapTime }
                                                </td> 
                                                <td style="height: 90px; font-size:25px;">
													${empMonthTime.strOverTime }
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
         var nowTime = now.getHours() + "시" + now.getMinutes() + "분" + now.getSeconds() + "초";
         clock.innerHTML = nowTime;// 현재시간을 출력
         setTimeout("printTime()",1000);// setTimeout(“실행할함수”,시간) 시간은1초의 경우 1000
	}

	 window.onload = function() { // 페이지가 로딩되면 실행
    	printTime();
    	workTime();
	} 
	
	//업무상태변경 클릭시 해당 상태로 출력
	/* $('#selectStatus li').on('click', function(){
		var selectedStatus = $(this).text();
		var a = $('#changeStatus').text(selectedStatus);
		console.log(selectedStatus);
	}); */

	
	//업무시간 계산

	 var gap = document.getElementById("workingTime1");
	 var statusValue = $('#changeStatus').val();
	  function workTime(){
		 
			var gap = document.getElementById("workingTime1");// 출력할 장소 선택
			var overTimePrint = document.getElementById("overTime");
			var workingTime =  document.getElementById("workInTime");
			var wtVal = workingTime.value;	
			
			var date = new Date();
			
			var hours = ('0' + date.getHours()).slice(-2); 
			var minutes = ('0' + date.getMinutes()).slice(-2);
			var seconds = ('0' + date.getSeconds()).slice(-2); 

			var timeString = hours + ':' + minutes  + ':' + seconds;			

			var wtDate = new Date(wtVal);

			var timeGap = date.getTime() - wtDate.getTime();
			console.log("timeGap:"+timeGap);
			//시간을 시,분,초로 계산
			pDay = timeGap / (60*60*24*1000);

	        strDay = Math.floor(pDay);

	        pHour = (timeGap - (strDay * (60*60*24*1000))) / (60*60*1000);

	        strHour = Math.floor(pHour);

	        strMinute = Math.floor((timeGap - (strDay * (60*60*24*1000)) - (strHour * (60*60*1000))) / (60*1000));
	        
	        strSec = Math.floor((timeGap - (strDay * (60*60*24*1000)) - (strHour * (60*60*1000)) - (strMinute * (60*1000))) / (1000));
	        console.log(strDay + " 일 " + strHour + " 시간 " + strMinute + " 분" + strSec + " 초");
	        var gapTime = strHour + " : " + strMinute + ":" + strSec;
	        console.log(wtVal);
	      
	        if(wtVal !='' ){	        	
	        	
	        	gap.innerHTML = gapTime;
	       }
	        var statusValue = $('#changeStatus').val();

    		if(statusValue!="업무종료"){

    			 setTimeout("workTime()",1000);
    		}else if(statusValue=="업무종료"){				
    			clearTimeout("workTime()");    
    			
    			
    		}
	  }

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
					gbl_data = data.strGapTime;
					console.log(data);	
					
					 if(statusValue == "업무종료"){
						 $('#changeStatus').attr("disabled","disabled");
						//input에는 text, innerhtml이 아니라 val를 써서 화면에 출력해야함
						var gap = document.getElementById("workingTime1");// 
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
						//gap.innerHTML = data.strGapTime;
						 
					} 
				},
				error:function(data){
					console.log(data);
				}
			});
		
				
	});
	 
	/*  
	 $(function(){
		 
 		  workTime();
 		console.log("펀션1:"+statusValue);
 		  if(statusValue=="업무종료"){
 			console.log("펀션2:"+statusValue);
 			  clearInterval(workTime());
 		  }else{
 			  setInterval(function(){
 				 console.log("펀션3:"+statusValue);
 					workTime();
 				}, 1000);
 		  }
 			
 		});
	 */



	</script>
	









</body>

</html>
