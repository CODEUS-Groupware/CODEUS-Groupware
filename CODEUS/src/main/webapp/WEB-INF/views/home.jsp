<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>main page-dashboard</title>
</head>
<link href="${contextPath}/resources/assets/vendor/fullcalendar/packages/core/main.css" rel='stylesheet' />
<link href="${contextPath}/resources/assets/vendor/fullcalendar/packages/daygrid/main.css" rel='stylesheet' />
<script src="${contextPath}/resources/assets/vendor/fullcalendar/packages/core/main.js"></script>
<script src="${contextPath}/resources/assets/vendor/fullcalendar/packages/daygrid/main.js"></script>
<script src="${contextPath}/resources/assets/vendor/fullcalendar/packages/interaction/main.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>

<style>
	/* 출퇴근 관련 css */
	#comTimeBtn, #offTimeBtn, #addAnnualLeave{
		 border-radius: 25px;
		 width: 100px;
		 height: 40px;
		 background: none;
	 }
	 
	 .afterPush{
	 	border: 1px solid gray; color: gray;  
	 }
	 
	 .beforePush{
		 border: 1px solid #593BDB; color: #593BDB;
	 }
 	
 	#clock{
 		font-size: x-large;
 		color: black;
 	}
 
 	/* 공지사항 관련 css */
 	
 	
 	/* 캘린더 관련 css */
 	body.stop-dragging
	{
	  -ms-user-select: none; 
	  -moz-user-select: -moz-none;
	  -khtml-user-select: none;
	  -webkit-user-select: none;
	  user-select: none;
	  height:10px;
	}
	
	.container{
		background-color: white;
		margin: 0 auto;
		margin-top: 2%;
/* 		width: 50px; */
	}
 
</style>

<body class='stop-dragging'>

    <!--**********************************
        Main wrapper start
    ***********************************-->
    <div id="main-wrapper">

		<c:import url="common/menubar.jsp"/>

        <!--**********************************
            Content body start
        ***********************************-->
        <div class="content-body">
            <div class="container-fluid">
            
				<!------------- 프로필 및 출퇴근 시작  ------------->
                <div class="row">
                    <div class="col-lg-4">
                        <div class="card">
                            <div class="card-body">
                            	<div id="memberProfile">
										


                            	
                            	</div>
                            	<br><br>
                                <div id="nowDateArea"  align="center">
                                	<!-- 현재 시간 -->
									<div id="clock" align="center"></div>
									<br>
									<!-- 출퇴근 버튼 -->
									<c:choose>
										<c:when test="${ requestScope.empStatus1.empOnTime != null && !empty requestScope.empStatus1 }"> <!-- 이미 출근 버튼 눌렀을때 -->
		                            		<input type="button" id="comTimeBtn" value="출근" class="afterPush" disabled="disabled">
		                            	</c:when>	
		                            	<c:otherwise>
		                            		<input type="button" id="comTimeBtn" onclick="comTime();" value="출근" class="beforePush">
		                            	</c:otherwise>
	                       			</c:choose>	
	                       			<c:choose>
										<c:when test="${ requestScope.empStatus1.getEmpOffTime() != null && !empty requestScope.empStatus1}"> <!-- 이미 퇴근 버튼 눌렀을때 -->
		                            		<input type="button" id="offTimeBtn" value="퇴근" class="afterPush" disabled="disabled">
		                            	</c:when>
		                            	<c:when test="${ requestScope.empStatus1.empOnTime == null }"> <!-- 출근 버튼 누르기 전에는 disabled -->
		                            		<input type="button" id="offTimeBtn" value="퇴근" class="afterPush" onclick="offTime();" disabled="disabled">
		                            	</c:when>
		                            	<c:otherwise>
		                            		<input type="button" id="offTimeBtn" class="beforePush" onclick="offTime();" value="퇴근">
		                            	</c:otherwise>		
		                            </c:choose>				
                        		</div>
                            </div>
                        </div>
                        <!-- /# card -->
                    </div>
                    <script>
	                    	$(function(){
	                    		printTime();
	                    		addAnnualLeave();
	                    	})
							
	                    	function printTime() {
							    	
								var now = new Date();// 현재시간
								var nowTime =  now.getHours() + "시" + now.getMinutes() + "분" + now.getSeconds() + "초";
								
								$('#clock').text(nowTime);// 현재시간을 출력
								setTimeout("printTime()",1000); // setTimeout(“실행할함수”,시간) 시간은1초의 경우 1000
								console.log(nowTime);
							}			
	                    	
	                    	 //연차자동생성
							 function addAnnualLeave(){
								  $.ajax({
									  url:'addAnnualLeave.al',
									  success:function(data){
											console.log(data);
										},
										error:function(data){
											console.log(data);
										}
								  });
							  }
					    
					    
						  	//출퇴근
							function comTime(){
								
								var now = new Date();
								var nowDate =  now.getFullYear() + "/" + (now.getMonth()+1)+"/"+now.getDate();
								var nowTime = now.getHours() + ":" + now.getMinutes() + ":" + now.getSeconds() ;//현재시간
								var day = new Date();
								console.log(day);
								
								console.log(nowTime);			
								
								$.ajax({
									url:'comTime.em',
									data:{day:day, nowTime:nowTime},
									dataType: 'json',
									success:function(data){
										console.log(data)
										var onTime = data.empOntime;
										var offTime = data.empOffTime;
										console.log(onTime)
										console.log(data.empOffTime)
										if(onTime != ''){
											$('#comTimeBtn').attr("disabled","disabled");
											$('#comTimeBtn').css('color','gray');
											$('#comTimeBtn').css('border-color','gray');
											$('#offTimeBtn').css({'border': '1px solid #593BDB', 'color': '#593BDB' }).prop('disabled', false);
										} else if(offTime != ''){
											$('#offTimeBtn').attr("disabled","disabled");
											$('#offTimeBtn').css('color','gray');
											$('#offTimeBtn').css('border-color','gray');
										}
										 
									},
									error:function(data){
										console.log(data);
									}
								});
					
							}
					
						  function offTime(){
								
								var now = new Date();
								var nowDate =  now.getFullYear() + "/" + (now.getMonth()+1)+"/"+now.getDate();
								var offTime = now.getHours() + ":" + now.getMinutes() + ":" + now.getSeconds() ;//현재시간
								var off = new Date();
								var status = "업무종료";
								$.ajax({
									url:'offTime.em',
									data:{off:off, 
										offTime:offTime,
										status:status
										},
									dataType: 'json',
									success:function(data){
										console.log(data);
										
										if(offTime != ''){
											$('#offTimeBtn').attr("disabled","disabled");
											$('#offTimeBtn').css('color','gray');
											$('#offTimeBtn').css('border-color','gray');
										}
										 
									},
									error:function(data){
										console.log(data);
									}
								});
					
							}
					    
					</script>
					<!------------- 프로필 및 출퇴근 끝  ------------->
					
                    <!------------- 결재문서함  시작 ------------->
                    <div class="col-lg-8">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">All Expense</h4>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table student-data-table m-t-20">
                                        <thead>
                                            <tr>
                                                <th>Expense Type</th>
                                                <th>Amount</th>
                                                <th>Status</th>
                                                <th>Email</th>
                                                <th>Date</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>

                                                <td>
                                                    Salary
                                                </td>
                                                <td>
                                                    $2000
                                                </td>
                                                <td>
                                                    <span class="badge badge-primary">Paid</span>
                                                </td>
                                                <td>
                                                    edumin@gmail.com
                                                </td>
                                                <td>
                                                    10/05/2017
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!------------- 결재문서함  끝 ------------->
                    
                    <!------------- 캘린더 시작  ------------->
                    <div class="col-lg-4">
                    	<div class="card">
							<div class="card-body">
								<div id="external-events" height="1px"class="my-3"> <!-- 없으면 캘린더 출력안됌 --> </div>
								<div id='calendar' height="10px;"></div>
							</div>
						</div>
                    </div>
                    
                    <!------------- 캘린더시작  ------------->
                    <div class="col-lg-8">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">All Expense</h4>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table student-data-table m-t-20">
                                        <thead>
                                            <tr>
                                                <th>Expense Type</th>
                                                <th>Amount</th>
                                                <th>Status</th>
                                                <th>Email</th>
                                                <th>Date</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>

                                                <td>
                                                    Salary
                                                </td>
                                                <td>
                                                    $2000
                                                </td>
                                                <td>
                                                    <span class="badge badge-primary">Paid</span>
                                                </td>
                                                <td>
                                                    edumin@gmail.com
                                                </td>
                                                <td>
                                                    10/05/2017
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!------------- 공지사항 끝  ------------->
                    
                    <!------------- 캘린더 시작  ------------->
                    <div class="col-lg-4">
                    </div>
                    <div class="col-lg-8">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">All Expense</h4>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table student-data-table m-t-20">
                                        <thead>
                                            <tr>
                                                <th>Expense Type</th>
                                                <th>Amount</th>
                                                <th>Status</th>
                                                <th>Email</th>
                                                <th>Date</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>

                                                <td>
                                                    Salary
                                                </td>
                                                <td>
                                                    $2000
                                                </td>
                                                <td>
                                                    <span class="badge badge-primary">Paid</span>
                                                </td>
                                                <td>
                                                    edumin@gmail.com
                                                </td>
                                                <td>
                                                    10/05/2017
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    
                    
                    <!------------- 캘린더 끝  ------------->
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
	 <!--**********************************
        Calendar Scripts
    ***********************************-->
    <script>
	var calendar;
	window.closeModal = function(){
	    $('.modal').modal('hide');
	};
	$(document).ready(function() {
		readCalList();
		
		$(document).on('input.calCheckbox', function() {
			checkCal();					// checkCal() 함수(체크된 체크박스 검사)
			calendar.refetchEvents();	// 캘린더 리로드(일정 다시 불러오기)
		});
	});
	document.addEventListener('DOMContentLoaded', function() {
	    var Calendar = FullCalendar.Calendar;
	    var Draggable = FullCalendarInteraction.Draggable;
	 
	    var containerEl = document.getElementById('external-events');
	    var calendarEl = document.getElementById('calendar');
	    var checkbox = document.getElementById('drop-remove');
	 
	    // initialize the external events
	    // -----------------------------------------------------------------
	    new Draggable(containerEl, {
	      itemSelector: '.fc-event',
	      eventData: function(eventEl) {
	        return {
	          title: eventEl.innerText
	        };
	      }
	    });
	 
	    // initialize the calendar
	    // -----------------------------------------------------------------
	    calendar = new Calendar(calendarEl, {
	      plugins: [ 'interaction', 'dayGrid', 'timeGrid' ],
	      header: {
	        left: 'prev viewWeekends',
	        center: 'title ',
	        right: 'next today',
	      },
	      locale: 'ko',
	      dateClick: function(info) {
				addSch();
	    	    $("input[name=startday]").val(info.dateStr);	// 클릭한 날짜를 시작날짜 끝날짜 초기값으로 지정
	    		$("input[name=endday]").val(info.dateStr);
	      },
	      eventClick: function(info) {
	  	   		viewSch(info.event.id);
	      },
	      selectable: true,
	      defaultDate: localStorage.getItem("checkDate"),	// 달력 날짜 수동 고정(아예 defaultDate를 삭제하면 현재 달 보여줌) 
	      navLinks: false, 				// 달력의 날짜 텍스트를 선택할 수 있는지 유무
	      editable: false,
	      eventLimit: false,				// 셀에 너무 많은 일정이 들어갔을 시 more로 처리 true에서 false로 수정
	      customButtons: { //주말 숨기기 & 보이기 버튼
	    	  today : {
	            text  : '오늘',
	            click : function () {
	            	calendar.today();
	            	checkDate();
	            }
	          },
	          prev : {
	        	  click : function () {
	        		  calendar.prev();
	        		  checkDate();  
				}
	          },
	          next : {
	        	  click : function () {
	        		  calendar.next();
	        		  checkDate();
				}
	          }
	      },
	         events: function (info, successCallback, failureCallback){
	        	 setCheckbox();
	        	 $.ajax({
	     			url:"<%= request.getContextPath() %>/selectSchList.ca",
	     			data:{sCalNo:localStorage.getItem("checkCal")},
	     			dataType:"JSON",
	     			success:function(json){
	     				
	     				var events = [];
						$.each(json, function(index, item){
							
							if (json.length > 0) {
								events.push({
		                            title: item.title,
		                            start: item.startday,
		                            end: item.endday,
		                            color: item.color,
		                            id: item.scheNo
		                         });
							}else{
								// 검색된 결과가 없을 때	
							}
						});
						 successCallback(events);  
	     			},
	     			error: function(request, status, error){
	     				console.log(json)
	     		 	}
	     		});
	         }
	    });
	    checkDate();
	    calendar.render();
	});
	// 로컬스토리지에 사용자가 현재 위치한 캘린더의 날짜값을 저장하는 함수
	function checkDate(){
		  
		  var date = calendar.getDate();
		  date = moment(date).format("YYYY-MM-DD");
		  
		  var checkDate = localStorage.getItem("checkDate");
		  
		  if(checkDate == null){
			  checkDate = "";
			  localStorage.setItem("checkDate", date);
		  }else{
			  localStorage.removeItem("checkDate");
			  localStorage.setItem("checkDate", date);
		  }
	}
	
		// 캘린더(내일정)를 읽어오는 함수
	function readCalList(){
		  $.ajax({
				url:"<%= request.getContextPath() %>/readCalList.ca",
				type:"get",
				dataType:"JSON",
				success:function(json){
					var html = "<div style='margin-bottom: 10px;'></div>";
					if (json.length > 0) {
						$.each(json, function(index, item){
							var name = "";
							console.log(item.name);
							if (item.name.length > 8) {                                                               
								name = item.name.substring(0,8) + "...";
							}else{
								name = item.name;
							}
							
							html += "<li>";
							html += "<p class='nav_ul_p'>";
							html += "<input id='calendar_id_" + index + "' class='calCheckbox' type='checkbox' />";
							html += "<input type='hidden' value='" + item.scheNo + "' />";
							html += "<label for='calendar_id_" + index + "' class='smallText'>&nbsp;" + name + "</label>";
							html += "<span class='btn_wrap'>";
							html += "<span class='dot' style='background-color: " + item.color + "'></span>";
							html += "</span>";
							html += "</p>";
							html += "</li>";
						});
					} $("ul.nav_ul").html(html);
						setCheckbox();
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error:yyyy "+error);
			 	}
			});
		}
	// 로컬스토리지에 저장된 캘린더 체크박스 체크유무를 가지고 체크박스에 적용시켜주는 함수
	function setCheckbox(){
		  
		  var sCalNo = localStorage.getItem("checkCal");
		  var selCalNoArr = [];
		  
		  if (sCalNo != null) {
			  selCalNoArr = sCalNo.split(",");
			  
			  $("input.calCheckbox").each(function(index) {
				  
				  var scheNo = $(this).next().val();
				  for (var i = 0; i < selCalNoArr.length; i++) {
					  if(scheNo == selCalNoArr[i]){
						  
						  $(this).prop("checked", true);
						  break;
					  }
				  }
			  });
			}
		}
	</script>
	<!--**********************************
	        Calendar Scripts
	    ***********************************-->
	<%--     <script src="${contextPath}/resources/assets/js/dashboard/dashboard-2.js"></script> --%>
<!-- 캘린더 script -->
<%-- 	    <script src="${contextPath}/resources/assets/vendor/global/global.min.js"></script> --%>
<%-- 	    <script src="${contextPath}/resources/assets/js/quixnav-init.js"></script> --%>
<%-- 	    <script src="${contextPath}/resources/assets/js/custom.min.js"></script>      --%>


    <!-- Circle progress -->

</body>
</html>