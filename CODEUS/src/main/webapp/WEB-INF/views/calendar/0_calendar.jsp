<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Insert title here</title>
<!-- Favicon icon -->
<link rel="icon" type="image/png" sizes="16x16" href="${contextPath}/assets/resources/images/favicon.png">
<!-- Custom Stylesheet -->
<link href="${contextPath}/resources/assets/css/style.css" rel="stylesheet">
<link href="${contextPath}/resources/assets/vendor/fullcalendar/packages/core/main.css" rel='stylesheet' />
<link href="${contextPath}/resources/assets/vendor/fullcalendar/packages/daygrid/main.css" rel='stylesheet' />
<link href="${contextPath}/resources/assets/vendor/fullcalendar/packages/timegrid/main.min.css" rel='stylesheet' />
<script src="${contextPath}/resources/assets/vendor/fullcalendar/packages/core/main.js"></script>
<script src="${contextPath}/resources/assets/vendor/fullcalendar/packages/daygrid/main.js"></script>
<script src="${contextPath}/resources/assets/vendor/fullcalendar/packages/interaction/main.min.js"></script>
<script src="${contextPath}/resources/assets/vendor/fullcalendar/packages/timegrid/main.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>

<style type="text/css">
	body.stop-dragging
	{
	  -ms-user-select: none; 
	  -moz-user-select: -moz-none;
	  -khtml-user-select: none;
	  -webkit-user-select: none;
	  user-select: none;
	}
	
	.titleBox{
		background-color: white;
		padding: 15px;
		margin-left: 1%;
	}
	
	.titleBox h2{
		margin: 0;
		font-weight: bold;
		color: #6a6a69;
	}
	
	.add_cal_Box{
		float: right;
	}
	
	.delBtn{
		float: left;
	}
	
	.container{
		background-color: white;
		margin: 0 auto;
		margin-top: 2%;
		width: 97%;
	}
	
	.table > tbody > tr > td {
     vertical-align: middle;
	}
	
	.oneRow{
		background-color: none;
	}
	
	.oneRow:hover{
		background-color: #fffafa;
	}
	
	.editImg{
		margin-left: 1%;
		color: gray;
		cursor: pointer;
	}
	
	.dot {
	  height: 12px;
	  width: 12px;
	  background-color: #bbb;
	  border-radius: 50%;
	  display: inline-block;
	  cursor: pointer;
	}
	
	.table-borderless > tbody > tr > td,
	.table-borderless > tbody > tr > th,
	.table-borderless > tfoot > tr > td,
	.table-borderless > tfoot > tr > th,
	.table-borderless > thead > tr > td,
	.table-borderless > thead > tr > th {
	    border: none;
	}
	
	.blueBtn{
		border-radius: 4px;
		background-color: #0F4C81;
		color: white;
	}
	
	.grayBtn{
		border-radius: 4px;
		background-color: #D8D8D8;
		color: gray;
	}
	
	.redBtn{
		border-radius: 4px;
		background-color: #d53641;
		color: white;
	}
	
	.calPlueBtn{
		border-radius: 4px;
		background-color: #0F4C81;
		color: white;
		height: 30px;
	}
	
	
</style>

<script>
/*
 	================ 캘린더 함수 정리 ================
 	
	info.dateStr
	info.event.title
 		
	calendar.refetchEvents() => 모든 소스의 이벤트를 다시 가져와 화면에 다시 렌더링
	calendar.addEvent( {'title':'evt4', 'start':'2020-12-04', 'end':'2020-12-04'});  ==> 이벤트를 추가하는 함수
	calendar.gotoDate (날짜) => 달력을 임의의 날짜로 이동
	
	
	var date = calendar.getDate(); ==> 현재 날짜 받기
	alert(date.toString()); ==> 현재 날짜 출력?(date.toString())
	date = moment(date).format("YYYY-MM");  ==> 받은 날짜를 원하는 형식으로 변경(cdn 추가해야 함)
	
	allDay 는 event.push 안에 title, start 처럼 줘야 함
	
*/
// 캘린더 전역변수 설정
	var calendar;
	//전체 모달 닫기(전역함수인듯)
	window.closeModal = function(){
	    $('.modal').modal('hide');
	};
	$(document).ready(function() {
		
		readCalList();
		
		// 내 캘린더의 체크박스를 조작했을 때 를 실행
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
	 	// 예약은 timeGrid 사용
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
	      eventLimit: true,				// 셀에 너무 많은 일정이 들어갔을 시 more로 처리
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
	
	// 새 캘린더 추가 함수
	function addCal() {
		  var name = $("input[name=cal_name]").val();
		  
		  if (name.trim() == "") {
			  alert("캘린더명을 입력해주세요.");
			  return false;
		  }
		  
		  $.ajax({
				url:"addCal.ca",
				data: {title:title},
				dataType:"JSON",
				success:function(json){
					var html = "";
					if (json.n == 1) {
						readCalList();
					}else{
						alert("DB오류");
					}
					var name = $("input[name=cal_name]").val("");
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			 	}
			});
		  
	}
	
	
	// 일정수정 modal 생성, editCal에서도 일정 수정할 수 있게 변경
	function editMyCal(scheType){
		  $("iframe.editIframe").attr('src', '<%= request.getContextPath() %>/editTodo.ca');
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
							if (item.name.length > 8) {
								name = item.name.substring(0,8) + "...";
							}else{
								name = item.name;
							}
							
							html += "<li>";
							html += "<p class='nav_ul_p'>";
							html += "<input id='calendar_id_" + index + "' class='calCheckbox' type='checkbox' />";
							html += "<input type='hidden' value='" + item.scheType + "' />";
							html += "<label for='calendar_id_" + index + "' class='smallText'>&nbsp;" + name + "</label>";
							html += "<span class='btn_wrap'>";
							html += "<span class='dot' style='background-color: " + item.color + "'></span>";
							html += "</span>";
							html += "</p>";
							html += "</li>";
						});
					}else{
						html += "<li style='height: 20px;'> 캘린더를 생성해주세요.";
						html += "</li><br>";
					}
					
					
					
					$("ul.nav_ul").html(html);
					setCheckbox();
				},
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			 	}
			});
		  
	}
	
	// 체크된 내 캘린더를 검사하는 함수
	function checkCal(){
		  
		  var totalLength = $("input.calCheckbox:checked").length;
		  
		  var sCalNo = "";
		  var selCalNoArr = [];
		  
		  $("input.calCheckbox:checked").each(function(index) {
			  if (index+1 == totalLength) {
				  // 마지막에는 , 추가하지 않음
				  sCalNo += $(this).next().val();
			  }else{
				  sCalNo += $(this).next().val() + ",";
			  }
			  
		  });
		  
		  // 로컬 스토리지에 저장하기
		  var checkCal = localStorage.getItem("checkCal");
		  
		  if(checkCal == null){
			  localStorage.setItem("checkCal", sCalNo);
		  }
		  
		  localStorage.removeItem("checkCal");
		  localStorage.setItem("checkCal", sCalNo);
		  
	}
	
	// 로컬스토리지에 저장된 캘린더 체크박스 체크유무를 가지고 체크박스에 적용시켜주는 함수
	function setCheckbox(){
		  
		  var sCalNo = localStorage.getItem("checkCal");
		  var selCalNoArr = [];
		  if (sCalNo != null) {
			  selCalNoArr = sCalNo.split(",");
			  
			  $("input.calCheckbox").each(function(index) {
				  var scheType = $(this).next().val();
				  for (var i = 0; i < selCalNoArr.length; i++) {
					  if(scheType == selCalNoArr[i]){
						  $(this).prop("checked", true);
						  break;
					  }
				  }
			  });
		  }
		  
		  
	}
	
	
	// (modal) 일정등록 버튼을 클릭했을 때 초기값을 잡아주는 함수
	function addSch(){
		  
		  // 모달 form에 입력돼있는 정보를 모두 삭제하고 모달을 보이게 함(모달 초기화)
		  $('.modal').find('form')[0].reset();
		  $('.modal').modal('show');
		  
		  $.ajax({
			url:"<%= request.getContextPath() %>/readCalList.ca",
			type:"get",
			dataType:"JSON",
			success:function(json){
				var html = "";
				if (json.length > 0) {
					$.each(json, function(index, item){
						var name = "";
						if (item.name.length > 8) {
							name = item.name.substring(0,8) + "...";
						}else{
							name = item.name;
						}
						
						html += "<option value='" + item.scheType + "'>" + item.name + "</option>";
					});
				}else{
					html += "<option value='-9999'>캘린더를 생성해주세요.</option>";
				}
				
				$("select.addSchSelect").html(html);
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		 	}
		});
		
	}
	
	// (modal) 일정등록에서 등록버튼을 클릭했을시 실행하는 함수
	function addSchModalBtn(){
		  
		  // 입력받은 값들 유효성 검사: 시작
		  var title = $("input.title").val();
		  if (title.trim() == "") {
			  alert("일정명을 입력해주세요.");
			  $("input.title").focus();
			  return false;
		  }
		  var startday = $("input[name=startday]").val() + " " + $("select.startday_hour").val() + ":00";
		  var endday = "";
		  
		  // 종일 체크 시 시작 날짜를 기준으로 변경
		  if ($("input#allday:checked").val()) {
			  startday = $("input[name=startday]").val() + " 00:00:00";
			  endday = $("input[name=startday]").val() + " 23:59:59";
		  }else{
			  endday = $("input[name=endday]").val() + " " + $("select.endday_hour").val() + ":00";
		  }
		  
		  // true: 통과   false: 불통
		  if (!(startday < endday && startday != endday)) {
			  alert("올바른 일시를 선택해주세요.");
			  return false;
		  }
		  
		  
		  var shceNo = $("select[name=shceNo]").val();
		  if (shceNo.trim() == "" || shceNo == "-9999") {
			  alert("캘린더를 선택해주세요.");
			  return false;
		  }
		  
		  var content = $("input[name=content]").val();
		  if (content.trim() == "") {
			  alert("일정내용을 입력해주세요.");
			  $("input[name=content]").focus();
			  return false;
		  }
		  
		// 입력받은 값들 유효성 검사: 끝
		
		// db에 넣기
		$.ajax({
			url:"<%= request.getContextPath() %>/addModalSch.ca",
			data:{title:title, startday:startday, endday:endday, shceNo:shceNo, content:content},
			type:"POST",
			dataType:"JSON",
			success:function(json){
				
				if (json.n == 1) {
					window.closeModal();
					calendar.refetchEvents();
					
				}else{
					alert("DB 오류");
				}
				
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		 	}
		});
	  
		  
	}
	
	// (Modal) 일정등록 - 일정상세 입력 버튼 클릭 시 실행하는 함수
	function addDetailSchModalBtn() {
		  
		  var startday = $("input[name=startday]").val() + " " + $("select.startday_hour").val() + ":00";
		  var endday = "";
		  
		  // 종일 체크 시 시작 날짜를 기준으로 변경
		  if ($("input#allday:checked").val()) {
			  startday = $("input[name=startday]").val() + " 00:00:00";
			  endday = $("input[name=startday]").val() + " 23:59:59";
		  }else{
			  endday = $("input[name=endday]").val() + " " + $("select.endday_hour").val() + ":00";
		  }
		  $("input[name=bAllday]").val($("input[name=allday]:checked").length);
		  var frm = document.addSchFrm;
		  frm.method = "GET";
		  frm.action = "<%= request.getContextPath() %>/goAddDetailSch.ca";
		  frm.submit();
		  
	}
	
	// 이벤트를 클릭시 상세보기로 이동하는 버튼
	function viewSch(scheNo){
		  location.href = "<%= request.getContextPath() %>/editSch.ca?scheNo=" + scheNo;
	}
  
</script>

</head>
<body class='stop-dragging'>
	<c:import url="../member/menubar_1.3.jsp"/>
	<!--**********************************
	            Content body start
	***********************************-->
	 
	<!-- Left navbar-header -->
	<div class="content-body" >
		<div class="container-fluid">
			<div class="row">
				<div class="col-lg-3">
					<div class="card">
						<div class="card-body">
							<div class="navbar-default sidebar cal_sidebar" role="navigation">
								<div class="sidebar-nav navbar-collapse slimscrollsidebar">
									<h2 class="pageTitleText">
										<i class="fa fa-calendar fa-fw" aria-hidden="true"></i>캘린더
									</h2>
									<div class="center p-20" style="padding-top: 0px !important;">
										<span class="hide-menu addSchedule">
											<a class="btn btn-danger btn-block btn-rounded waves-effect waves-light" 
											   href="<%= request.getContextPath() %>/goAddDetailSch.ca">일정등록</a>
										</span>
									</div>
									<ul class="nav" id="side-menu" style="padding-left: 9%;">
										<li style="padding: 10px 0 0;">
											<span class="largeText">내 캘린더</span>
											<ul class="nav_ul"></ul>
										
											<span class="largeText">공유 캘린더</span>
											<ul class="nav_share_ul">
												<div style='margin-bottom: 10px;'></div>
												<li>
													<p class='nav_ul_p'>
													<input id='calendar_id_-9999' class='calCheckbox' type='checkbox' />
													<input type='hidden' value='-9999' />
														<label for='calendar_id_-9999' class='smallText'>&nbsp;초대받은 일정</label>
															<span class='btn_wrap'>
															<span class='dot' style='background-color: violet'></span>
														</span>
													</p>
												</li>
											</ul>
											<div class="add_calendar_box dropdown">
												<a class="add_calendar dropdown-toggle" role="button" id="dropdownMenuLink" 
												   data-toggle="dropdown" style="color: black;">
													<i class="fa fa-plus" style="padding-right: 10px;"></i>내 캘린더 추가
												</a>
												<div class="dropdown-menu" aria-labelledby="dropdownMenuLink" style="padding: 5px 0; padding-left: 20xp; padding-right: 20xp;">
													<h5 style="font-weight: bold;">&nbsp;내 캘린더 추가</h5>
													<div>
														<input type="text" maxlength="16" name="cal_name" style="margin-bottom: 10px;" />
														<br>
														<button type="button" class="btn blueBtn" onclick="addCal()">확인</button>
														<button type="button" class="btn grayBtn">취소</button>
													</div>
												</div>
											</div>
										
											<div class="add_calendar_box">
												<a class="add_calendar" href="<%= request.getContextPath() %>/editCal.os" style="color: black;">
													<i class="fa fa-cog" style="padding-right: 10px;"></i>내 캘린더 관리
												</a>
											</div>
										</li>
									</ul>
								</div>
							</div>
							<div id="external-events" class="my-3">
								<p>
									<strong>Draggable Events</strong>
								</p>
								<div class="fc-event">My Event 1</div>
								<div class="fc-event">My Event 2</div>
								<div class="fc-event">My Event 3</div>
								<div class="fc-event">My Event 4</div>
								<div class="fc-event">My Event 5</div>
								<p>
									<input type="checkbox" id="drop-remove">
									<label for="drop-remove">remove after drop</label>
								</p>
							</div>
						</div>
					</div>
				</div>
			
				<div class="col-lg-9">
					<div class="card">
						<div class="card-body">
							<div id='calendar'></div>
						</div>
					</div>
					<%-- 일정 등록 모달 --%>
					<div id="addSchModal" class="modal fade" role="dialog" data-keyboard="false" data-backdrop="static">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" onclick="window.closeModal()">&times;</button>
									<h4 class="modal-title" style="font-weight: bold;">일정등록</h4>
								</div>
								<div class="modal-body">
								 
									<div class="modal_container">
										<form name="addSchFrm">
											<input type="hidden" name="bAllday">
											<table class="table table-borderless">
												<tbody>
													<tr>
														<th>일정명</th>
														<td><input class="form-control title modal_input" maxlength="13" name="title" type="text" /></td>
													</tr>
													<tr>
														<th>일시</th>
														<td>
															<input type="date" class="datepicker" name="startday">
															<select class="startday_hour" style="width: 70px;">
																<c:set var="breakPoint" value="0" />
																	<c:forEach var="i" begin="0" end="23">
																		<c:forEach var="j" begin="0" end="1">
																			<c:if test="${(i == 24) && (j == 1)}">    
																				<c:set var="breakPoint" value="1" />                                    
																			</c:if>
																			<c:if test="${breakPoint == 0}">                           
																				<option value="<fmt:formatNumber pattern="00" value="${i}" />:<fmt:formatNumber pattern="00" value="${j*30}" />">
																				<fmt:formatNumber pattern="00" value="${i}" />:<fmt:formatNumber pattern="00" value="${j*30}" /></option>                                                                            
																			</c:if>
																		</c:forEach>
																	</c:forEach>
															</select>
																~
															<input type="date" class="datepicker" name="endday">
																<select class="endday_hour" style="width: 70px;">
																<c:set var="breakPoint" value="0" />
																	<c:forEach var="i" begin="0" end="23">
																		<c:forEach var="j" begin="0" end="1">
																			<c:if test="${(i == 24) && (j == 1)}">    
																				<c:set var="breakPoint" value="1" />                                    
																			</c:if>
																			<c:if test="${breakPoint == 0}">                           
																				<option value="<fmt:formatNumber pattern="00" value="${i}" />:<fmt:formatNumber pattern="00" value="${j*30}" />">
																				<fmt:formatNumber pattern="00" value="${i}" />:<fmt:formatNumber pattern="00" value="${j*30}" /></option>                                                                            
																			</c:if>
																		</c:forEach>
																	</c:forEach>
																</select>
															<input type="checkbox" id="allday" name="allday" /><label for="allday">종일</label>
														</td>
													</tr>
													<tr>
														<th>내 캘린더</th>
														<td><select class="addSchSelect" name="shceNo"></select></td>
													</tr>
													<tr>
														<th>일정내용</th>
														<td><input class="form-control modal_input" name="content" type="text" style="height: 30px;" /></td>
													</tr>
												</tbody>
											</table>
											<div style="float: right;">
												<button class="btn grayBtn" type="button" onclick="addDetailSchModalBtn()">일정상세 입력</button>
												<button class="btn blueBtn" type="button" onclick="addSchModalBtn()">등록</button>
											</div>
											<br style="clear: both;">
										</form>
									</div>
								</div>
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
	        Scripts
	    ***********************************-->
	    <!-- Required vendors -->
	    <script src="${contextPath}/resources/assets/vendor/global/global.min.js"></script>
	    <script src="${contextPath}/resources/assets/js/quixnav-init.js"></script>
	    <script src="${contextPath}/resources/assets/js/custom.min.js"></script>      
</body>
</html>