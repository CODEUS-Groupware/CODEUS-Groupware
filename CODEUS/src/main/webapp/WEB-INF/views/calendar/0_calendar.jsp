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
		cursor: hand;
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
	    cursor: pointer;
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
       	================ ????????? ?????? ?????? ================
 	
	info.dateStr
	info.event.title
 		
	calendar.refetchEvents() => ?????? ????????? ???????????? ?????? ????????? ????????? ?????? ?????????
	calendar.addEvent( {'title':'evt4', 'start':'2020-12-04', 'end':'2020-12-04'});  ==> ???????????? ???????????? ??????
	calendar.gotoDate (??????) => ????????? ????????? ????????? ??????
	
	
	var date = calendar.getDate(); ==> ?????? ?????? ??????
	alert(date.toString()); ==> ?????? ?????? ???????(date.toString())
	date = moment(date).format("YYYY-MM");  ==> ?????? ????????? ????????? ???????????? ??????(cdn ???????????? ???)
	
	allDay ??? event.push ?????? title, start ?????? ?????? ???
	
*/
// ????????? ???????????? ??????
	var calendar;
	//?????? ?????? ??????(??????????????????)
	window.closeModal = function(){
	    $('.modal').modal('hide');
	};
	$(document).ready(function() {
		readAdminCalList();
		
		// ??? ???????????? ??????????????? ???????????? ??? ??? ??????
		$(document).on('input.calCheckbox', function() {
			checkCal();					// checkCal() ??????(????????? ???????????? ??????)
			calendar.refetchEvents();	// ????????? ?????????(?????? ?????? ????????????)
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
	 	// ????????? timeGrid ??????
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
	    	    $("input[name=startday]").val(info.dateStr);	// ????????? ????????? ???????????? ????????? ??????????????? ??????
	    		$("input[name=endday]").val(info.dateStr);
	      },
	      eventClick: function(info) {
	  	   		viewSch(info.event.id);
	      },
	      selectable: true,
	      defaultDate: localStorage.getItem("checkDate"),	// ?????? ?????? ?????? ??????(?????? defaultDate??? ???????????? ?????? ??? ?????????) 
	      navLinks: false, 				// ????????? ?????? ???????????? ????????? ??? ????????? ??????
	      editable: false,
	      eventLimit: true,				// ?????? ?????? ?????? ????????? ???????????? ??? more??? ?????? true?????? false??? ??????
	      customButtons: { //?????? ????????? & ????????? ??????
	    	  today : {
	            text  : '??????',
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
	     			url:"<%= request.getContextPath() %>/selectadminSchList.ca",
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
								// ????????? ????????? ?????? ???	
							}
							
						});

						 successCallback(events);  
	     			},
	     			error: function(request, status, error){
	     				console.log(json);

	     		 	}
	     		});
	        	 
	         }
	    });
	    checkDate();
	    calendar.render();
	});
  
  


	// ????????????????????? ???????????? ?????? ????????? ???????????? ???????????? ???????????? ??????
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
	
	// ??? ????????? ?????? ??????
	function addCal() {
			  var name = $("input[name=cal_name]").val();
			  
			  if (name.trim() == "") {
				  alert("??????????????? ??????????????????.");
				  return false;
			  }
			  
			  $.ajax({
					url:"addCal.ca",
					data: {name: name},
					dataType:"JSON",
					success:function(json){
						var html = "";
						if (json.result == 1) {
							readAdminCalList();
						}else{
							alert("DB??????");
						}
						var name = $("input[name=cal_name]").val("");
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				 	}
				});
			  
		}
	
		// ?????????(?????????)??? ???????????? ??????
		function readAdminCalList(){
			  $.ajax({
					url:"<%= request.getContextPath() %>/readAdminCalList.ca",
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
								html += " <span class='dot' style='background-color: " + item.color + "'></span>";
								html += "</span>";
								html += "</p>";
								html += "</li>";
								console.log(item.color);
							});
						}//else{
						//	html += "<li style='height: 20px;'> ???????????? ??????????????????.";
						//	html += "</li><br>";
						//}
						
						
						
						$("ul.nav_ul").html(html);
						setCheckbox();
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error:yyyy "+error);
				 	}
				});
			  
		}
	
	// ????????? ??? ???????????? ???????????? ??????
	function checkCal(){
		  
		  var totalLength = $("input.calCheckbox:checked").length;
		  
		  var sCalNo = "";
		  var selCalNoArr = [];
		  
		  $("input.calCheckbox:checked").each(function(index) {
			  if (index+1 == totalLength) {
				  // ??????????????? , ???????????? ??????
				  sCalNo += $(this).next().val();
			  }else{
				  sCalNo += $(this).next().val() + ",";
			  }
			  
		  });
		  
		  // ?????? ??????????????? ????????????
		  var checkCal = localStorage.getItem("checkCal");
		 //alert(localStorage.getItem("checkCal"));
		  
		  if(checkCal == null){
			  localStorage.setItem("checkCal", sCalNo);
		  }
		 
		  localStorage.removeItem("checkCal");
		  localStorage.setItem("checkCal", sCalNo);
		  
	}
	
	// ????????????????????? ????????? ????????? ???????????? ??????????????? ????????? ??????????????? ?????????????????? ??????
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
	
	
	// (modal) ???????????? ????????? ???????????? ??? ???????????? ???????????? ??????
	function addSch(){
		  
		  // ?????? form??? ??????????????? ????????? ?????? ???????????? ????????? ????????? ???(?????? ?????????)
		  $('.modal').find('form')[0].reset();
		  $('.modal').modal('show');
		  
		  $.ajax({
			url:"<%= request.getContextPath() %>/readAdminCalList.ca",
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
						
						html += "<option value='" + item.scheNo + "'>" + item.name + "</option>";
					});
				}else{
					html += "<option value='-9999'>???????????? ??????????????????.</option>";
				}
				
				$("select.addSchSelect").html(html);
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		 	}
		});
		
	}

	// (modal) ?????????????????? ??????????????? ??????????????? ???????????? ??????
	function addSchModalBtn(){
		  
		  // ???????????? ?????? ????????? ??????: ??????
		  var title = $("input.title").val();
		  if (title.trim() == "") {
			  alert("???????????? ??????????????????.");
			  $("input.title").focus();
			  return false;
		  }
		  var startday = $("input[name=startday]").val() + " " + $("select.startday_hour").val() + ":00";
		  var endday = "";
		  
		  // ?????? ?????? ??? ?????? ????????? ???????????? ??????
		  if ($("input#allday:checked").val()) {
			  startday = $("input[name=startday]").val() + " 00:00:00";
			  endday = $("input[name=startday]").val() + " 21:00:00";
		  }else{
			  endday = $("input[name=endday]").val() + " " + $("select.endday_hour").val() + ":00";
		  }
		  
		  // true: ??????   false: ??????
		  if (!(startday < endday && startday != endday)) {
			  alert("????????? ????????? ??????????????????.");
			  return false;
		  }
		  
		   var scheNo = $("input[name=scheNo]").val();
		  
		  var content = $("input[name=content]").val();
		  if (content.trim() == "") {
			  alert("??????????????? ??????????????????.");
			  $("input[name=content]").focus();
			  return false;
		  }
		  var writer = $("input[name=writer]").val();
		  if (writer.trim() == "" ){
			  $("input[name=writer]").focus();
			  return false;
		  }
		  
		// ???????????? ?????? ????????? ??????: ???
		
		// db??? ??????
		$.ajax({
			url:"<%= request.getContextPath() %>/addModalSch.ca",
			data:{title:title, startday:startday, endday:endday, content:content, writer:writer},
			type:"POST",
			success:function(json){
				if (json.result == 1) {
					window.closeModal();
					location.href = "<%= request.getContextPath() %>/goCalendar.ca";
					calendar.refetchEvents();
					
				}else{
					alert("db ??????");
				}
				
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		 	}
		});
	  
		  
	}
	
	// (Modal) ???????????? - ???????????? ?????? ?????? ?????? ??? ???????????? ??????
	function addDetailSchModalBtn() {
		  
		  var startday = $("input[name=startday]").val() + " " + $("select.startday_hour").val() + ":00";
		  var endday = "";
		  
		  // ?????? ?????? ??? ?????? ????????? ???????????? ??????
		  if ($("input#allday:checked").val()) {
			  startday = $("input[name=startday]").val() + " 00:00:00";
			  endday = $("input[name=startday]").val() + " 21:00:00";
		  }else{
			  endday = $("input[name=endday]").val() + " " + $("select.endday_hour").val() + ":00";
		  }
		  $("input[name=bAllday]").val($("input[name=allday]:checked").length);
		  var frm = document.addSchFrm;
		  frm.method = "GET";
		  frm.action = "<%= request.getContextPath() %>/goAddDetailSch.ca";
		  frm.submit();
		  
	}
	
	// ???????????? ????????? ??????????????? ???????????? ??????
	function viewSch(scheNo){
		  location.href = "<%= request.getContextPath() %>/editSch.ca?scheNo=" + scheNo;
	}
  
</script>

</head>
<body class='stop-dragging'>
	<c:import url="../common/menubar.jsp"/>
	<!--**********************************
	            Content body start
	***********************************-->
	 
	<!-- Left navbar-header -->
	<div class="content-body">
		<div class="container-fluid">
			<div class="row">
				<div class="col-lg-3">
					<div class="card">
						<div class="card-body">
							<div class="navbar-default sidebar cal_sidebar" role="navigation">
								<div class="sidebar-nav navbar-collapse slimscrollsidebar">
									<h2 class="pageTitleText">
										<i class="fa fa-calendar fa-fw" aria-hidden="true"></i>?????? ?????????
									</h2>
									<c:if test="${sessionScope.loginUser.mId eq 'kimdo'}">
										<div class="center p-20" style="padding-top: 0px !important;">
											<span class="hide-menu addSchedule">
												<a class="btn btn-danger btn-block btn-rounded waves-effect waves-light" 
												   href="<%= request.getContextPath() %>/goAddCal.ca">????????????</a>
											</span>
										</div>
									</c:if>
									<ul class="nav" id="side-menu" style="padding-left: 9%;">
										<li style="padding: 10px 0 0;">
<!-- 											<span class="largeText">??? ?????????</span> -->
											<ul class="nav_ul"></ul>
										
											<!--  <span class="largeText">?????? ?????????</span> -->
											 <ul class="nav_share_ul">
												<div style='margin-bottom: 10px;'></div>
												<li>
													<p class='nav_ul_p'>
													<input id='calendar_id_-9999' class='calCheckbox' type="hidden" /><!-- value ="${calendar.scheNo}" -->
													<input type='hidden' value='-9999' />
													<!--<label for='calendar_id_-9999' class='smallText'>&nbsp;???????????? ??????</label>
														<span class='btn_wrap'>
																<span class='dot' style='background-color: violet'></span>
														</span> -->
													</p>
												</li>
											</ul>
<!-- 											<div class="add_calendar_box"> -->
<%-- 												<a class="add_calendar" href="<%= request.getContextPath() %>/editCal.ca" style="color: black;"> --%>
<!-- 													<i class="fa fa-cog" style="padding-right: 10px;"></i>??? ????????? ?????? -->
<!-- 												</a> -->
<!-- 											</div> -->
										</li>
									</ul>
								</div>
							</div>
							<div id="external-events" class="my-3">
							</div>
						</div>
					</div>
				</div>
			
				<div class="col-lg-9" >
					<div class="card">
						<div class="card-body" >
							<div id='calendar'></div>
						</div>
					</div>
					<%-- ?????? ?????? ?????? --%>
					<div id="addSchModal" class="modal fade" role="dialog" data-keyboard="false" data-backdrop="static">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" onclick="window.closeModal()">&times;</button>
									<h4 class="modal-title" style="font-weight: bold;">????????????</h4>
								</div>
								<div class="modal-body">
								 
									<div class="modal_container">
										<form name="addSchFrm">
											<input type="hidden" name="bAllday">
											<table class="table table-borderless">
												<tbody>
													<tr>
														<th>?????????</th>
														<td><input class="form-control title modal_input" maxlength="13" name="title" type="text" /></td>
													</tr>
													<tr>
														<th>??????</th>
														<td>
															<input type="date" class="datepicker" name="startday">
															<select class="startday_hour" style="width: 70px;">
																<c:set var="breakPoint" value="0" />
																	<c:forEach var="i" begin="0" end="20">
																		<c:forEach var="j" begin="0" end="1">
																			<c:if test="${(i == 21) && (j == 1)}">    
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
																	<c:forEach var="i" begin="0" end="21">
																		<c:forEach var="j" begin="0" end="0">
																			<c:if test="${(i == 22) && (j == 1)}">    
																				<c:set var="breakPoint" value="1" />                                    
																			</c:if>
																			<c:if test="${breakPoint == 0}">                           
																				<option value="<fmt:formatNumber pattern="00" value="${i}" />:<fmt:formatNumber pattern="00" value="${j*30}" />">
																				<fmt:formatNumber pattern="00" value="${i}" />:<fmt:formatNumber pattern="00" value="${j*30}" /></option>                                                                            
																			</c:if>
																		</c:forEach>
																	</c:forEach>
																</select>
															<input type="checkbox" id="allday" name="allday"/><label for="allday">??????</label>
														</td>
													</tr>
													<tr>
														<th>????????????</th>
														<td><input class="form-control modal_input" name="content" type="text" style="height: 30px;" /></td>
													</tr>
													<tr>
<!-- 														<th>?????????</th> -->
														<td><input class="form-control writer modal_input" maxlength="13" name="writer" type="hidden" readonly value="${sessionScope.loginUser.mId}" />  </td>
<!-- 														<td><select class="addSchSelect" name="scheNo" type="hidden"></select></td> -->
													</tr>
												</tbody>
											</table>
											<div style="float: right;">
												<button class="btn grayBtn" type="button" onclick="addDetailSchModalBtn()">???????????? ??????</button>
												<button class="btn blueBtn" type="button" onclick="addSchModalBtn()">??????</button>
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
            Footer start
        ***********************************-->
        <div class="footer">
            <div class="copyright">
                <p>Copyright ?? Designed &amp; Developed by <a href="#" target="_blank">CODEUS</a> 2021</p>
            </div>
        </div>
        <!--**********************************
            Footer end
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