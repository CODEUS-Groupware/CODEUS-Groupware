<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<script type="text/javascript" src="${contextPath}/resources/assets/js/jsQR.js"></script>	
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
 	
 	#today{
 		color: darkgray;
 	}
 	
 	.profile-photo img{
 		width: 170px; 
 		height: 170px;
 		border-radius: 100%;
 	}
 	
 	#myName{
 		color: black;
 		font-size: large;
 		font-weight: bold;
 	}
 	
 
 	/* 공지사항 관련 css */
 	.table tbody{font-size: 14px;}
	.table a{color: black;}
 	#noticeBoardArea{color: black;}
 	.pin {font-size: large; color: orange;}
 
 	
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
	
	/* QR코드 관련 */

 #main h1{font-family : 'TmonMonsori'}
	
 	#main {
  		width: 90%; 
  		text-align: center;
 		margin-left: auto;
 		margin-right: auto;
 	}
 	
 	#outputMessage, #outputData{
 		font-family: 'SpoqaHanSansNeo-Medium'
 	}
 	
 	#title{
 		margin-top: 40px;
 		margin-bottom: 30px;
 	}

 	#output {
 		background-color: #D3D3D3; 
 		padding: 10px;
 		margin-top: 30px;
 		font-size: 16px;
 	} 
	
 	#frame { 
 		border: 2px solid #D3D3D3; 
 		background-color: #FFFFFF; 
 		margin-left: 10px; 
 		margin-right: 10px; 
 		padding: 8px;
 	} 
	

 	#canvas { 
 		width: 100%;
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
            
				<!------------- 프로필, 출퇴근, 결재상태 시작  ------------->
                <div class="row">
                    <div class="col-lg-4">
                        <div class="card">
                            <div class="card-body">
                            	<!-- 프로필 -->
                            	<div id="memberProfile">
                            		<br>
									<div class="profile-photo" align="center">
		                                <c:if test="${ loginUser.imgChangeName eq null }">
				                        	<img src="${contextPath}/resources/assets/images/empty-profile.png" alt="profile-image">
				                        </c:if>
				                        <c:if test="${ loginUser.imgChangeName ne null }">
				                            <img src="${contextPath}/resources/uploadFiles/${ loginUser.imgChangeName }" alt="profile-image">
				                        </c:if>
				                    </div>
				                    <br>
				                    <div id="myName" align="center">${ loginUser.mName } ${ loginUser.jobName }</div>
				                    <div id="myDept" align="center">${ loginUser.deptName }</div>
                            	</div>
                            	<br>
                                <div id="nowDateArea"  align="center">
                                	<!-- 현재 시간 -->
                                	 <c:set var="today" value="<%=new java.util.Date()%>" />
                                	 <c:set var="date"><fmt:formatDate value="${today}" pattern="yyyy-MM-dd(E)" /></c:set>
									<div id="today" align="center"><c:out value="${date}" /></div>
									<div id="clock" align="center"></div>
									<br>
									<!-- 출퇴근 버튼 -->
									<c:choose>
										<c:when test="${ requestScope.empStatus1.empOnTime != null && !empty requestScope.empStatus1 }"> <!-- 이미 출근 버튼 눌렀을때 -->
		                            		<input type="button" id="comTimeBtn" value="출근" class="afterPush" disabled="disabled">
		                            	</c:when>	
		                            	<c:otherwise>
		                            		<input type="button" id="comTimeBtn" value="출근" class="beforePush">
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
		                            <br><br>
		                            
		                            <!-- 출근버튼을 클릭하면 모달창 활성화.. -->
		                      		<div class="modal fade" id="QRModal" tabindex="-1" role="dialog" aria-labelledby="QRModalLabel" aria-hidden="true">
										<div class="modal-dialog modal-sm" role="document">
											<div class="modal-content">
												<div class="modal-header">
													<h4 class="modal-title mx-auto" id="QRModalLabel">QR</h4>
													<button type="button" class="close" data-dismiss="modal" aria-label="Close">
														<span aria-hidden="true">&times;</span>
													</button>
												</div>
												<div class="modal-body mx-auto">
													<div id="qrcode">
													<!-- QR코드 -->
													<div id="main">
														<div id="title">
															<h1>QR 코드 리더</h1>
															<div id="output">
																<div id="outputMessage">
																	<i class="icofont icofont-info-circle"></i>
																	QR코드를 카메라에 노출시켜 주세요
																</div>
																<div id="outputLayer" hidden>
																	<span id="outputData"></span>
																</div>
															</div>
														</div>
													
														<div>&nbsp;</div>
													
														<div>
															<div id="frame">
																<div id="loadingMessage">
																	🎥 비디오 스트림에 액세스 할 수 없습니다<br />웹캠이 활성화되어 있는지 확인하십시오
																</div>
																<canvas id="canvas"></canvas>
															</div>
														</div>
													</div>
																	
												</div>
											</div>
										</div>
									</div>
								</div> 		
                        		</div>
                            </div>
                            
                            <!---- 결재상태 ----->
                            <div class="card-body" id="approvalStatus">
								<div class="table-responsive">
                                    <table class="table student-data-table m-t-20">
                                        <thead>
                                            <tr>
                                                <th>Expense Type</th>
                                                <th>Amount</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>

                                                <td>
                                                    $2000
                                                </td>
                                                <td>
                                                    <span class="badge badge-primary">Paid</span>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
							</div>
                        </div>
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
								
							}			
	                    	
						  	//출퇴근
							function comTime(){
								
								var now = new Date();
								var nowDate =  now.getFullYear() + "/" + (now.getMonth()+1)+"/"+now.getDate();
								var nowTime = now.getHours() + ":" + now.getMinutes() + ":" + now.getSeconds() ;//현재시간
								var day = new Date();
								console.log(day);
								
										
								
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
						// QR출근하기
							$('#comTimeBtn').click(function() {
			
								var check = confirm('QR생성 하시겠습니까?\n이미 생성하셨다면 취소를 눌러주세요.');
								if(check){
									
									// 카메라 사용시
									navigator.mediaDevices.getUserMedia({
										video : {facingMode : "environment"}
									}).then(function(stream) {
										mediaStream = stream;
										//QR코드 인식 후 카메라 끄기 위해 함수 선언
							            mediaStream.stop = function () {
							                this.getAudioTracks().forEach(function (track) {
							                    track.stop();
							                });
							                this.getVideoTracks().forEach(function (track) { //in case... :)
							                    track.stop();
							                });
							            };
										video.srcObject = stream;
										video.setAttribute("playsinline", true); // iOS 사용시 전체 화면을 사용하지 않음을 전달
										video.play();
										requestAnimationFrame(tick);
									});
									
									$('#QRModal').modal('show');
									var mId = '<c:out value="${loginUser.mId}"/>';
									
									var qrcode = new QRCode(document.getElementById("qrcode"), {
									    text: mId,
									    width: 128,
									    height: 128,
									    colorDark : "#000000",
									    colorLight : "#ffffff",
									    correctLevel : QRCode.CorrectLevel.H
									});
									
								    $("#qrcode > img").css({"margin":"auto"});
								    
								 
								} else {
									$('#QRModal').modal('hide');			
									popupOpen('qrStart.co');
								}
							});
							var video = document.createElement("video");
							var canvasElement = document.getElementById("canvas");
							var canvas = canvasElement.getContext("2d");
							var loadingMessage = document.getElementById("loadingMessage");
							var outputContainer = document.getElementById("output");
							var outputMessage = document.getElementById("outputMessage");
							var outputData = document.getElementById("outputData");
							
							function drawLine(begin, end, color) {
								canvas.beginPath();
								canvas.moveTo(begin.x, begin.y);
								canvas.lineTo(end.x, end.y);
								canvas.lineWidth = 4;
								canvas.strokeStyle = color;
								canvas.stroke();
							}
							
							
							
							function tick() {
								loadingMessage.innerText = "⌛ 스캔 기능을 활성화 중입니다."
								if (video.readyState === video.HAVE_ENOUGH_DATA) {
									loadingMessage.hidden = true;
									canvasElement.hidden = false;
									outputContainer.hidden = false;
									// 읽어들이는 비디오 화면의 크기
									canvasElement.height = video.videoHeight;
									canvasElement.width = video.videoWidth;
									canvas.drawImage(video, 0, 0, canvasElement.width, canvasElement.height);
									var imageData = canvas.getImageData(0, 0, canvasElement.width, canvasElement.height);
									var code = jsQR(imageData.data, imageData.width,imageData.height, {
												inversionAttempts : "dontInvert",
									});
									// QR코드 인식에 성공한 경우
									if (code) {
										// 인식한 QR코드의 영역을 감싸는 사용자에게 보여지는 테두리 생성
										drawLine(code.location.topLeftCorner, code.location.topRightCorner, "#FF0000");
										drawLine(code.location.topRightCorner, code.location.bottomRightCorner, "#FF0000");
										drawLine(code.location.bottomRightCorner, code.location.bottomLeftCorner, "#FF0000");
										drawLine(code.location.bottomLeftCorner, code.location.topLeftCorner, "#FF0000");
										outputMessage.hidden = true;
										outputData.parentElement.hidden = false;
										// QR코드 메시지 출력
										//outputData.innerHTML = code.data;
										if(confirm('출근하시겠습니까?') == true){ //확인
												//카메라 끄기
												mediaStream.stop();

											comTime();
											$('#QRModal').modal('hide'); 

											return;
					                    } else {
					                    	return false;
					                    }
									}
									// QR코드 인식에 실패한 경우 
									else {
										outputMessage.hidden = false;
										outputData.parentElement.hidden = true;
									}
								}
								requestAnimationFrame(tick);
							}
							
					    
					</script>
					<!------------- 프로필, 출퇴근, 결재상태 끝  ------------->
					
                    <!------------- 캘린더 시작  ------------->
                    <div class="col-lg-8">
                        <div class="card">
                            <div class="card-body">
                                <div class="card">
									<div class="card-body" >
										<div id="external-events" height="1px"class="my-3"> <!-- 없으면 캘린더 출력안됌 --> </div>
										<div id='calendar' height="10px;"></div>
									</div>
								</div>
                            </div>
                        </div>
                    </div>
                    <!------------- 캘린더 끝  ------------->
                    
                    <div class="col-lg-4">>
                    </div>
                   	<!------------- 공지사항 시작  ------------->
                    <div class="col-lg-8">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">공지사항</h4>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table id="noticeBoardArea" class="table student-data-table m-t-20">
                                        <thead>
                                        	<tr style="font-size: large;">
	                                           <th scope="col" width="70px">번호</th>
	                                           <th scope="col" width="300px">제목</th>
	                                           <th scope="col" width="200px">작성자</th>
	                                           <th scope="col" width="120px">작성일</th>
	                                           <th scope="col" width="100px">조회수</th>
	                                        </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!------------- 공지사항 끝  ------------->
                    <script>
	             		$(function(){
	             			noticeBoardList();
	             			
	             			setInterval(function(){
	             				noticeBoardList();
	             			}, 10000);
	             		});
	             		
	             		function noticeBoardList() {
	             			
	             			let $tableBody = $('#noticeBoardArea tbody');
	             			$tableBody.html('');
	             			
 	             			$.ajax({
 	             				url: 'noticeBoardListMain.nb',
 	             				dataType: 'json',
 	            				success: function(data){
 	            					console.log(data);
 	            					
 	            					if (data.length > 0) {
 	            						
 	            						let $tr;
 	            						let bTitle;
 	            						let a;
 	            						for (let i in data) {
 	            							
 	            							$tr = $('<tr>');
 	            							
 	            							if (data[i].pin == 'Y') {
 	            								$tr.css('background', '#F8F8FF');
 	            								$tr.append($('<td>').append('<i class="bi bi-megaphone-fill pin">'));
 	            							} else {          										$tr.append($('<td>').text(data[i].bNum));
 	            							}
 	            							
 	            							bTitle = data[i].bTitle.length > 10 ? data[i].bTitle.substring(0, data[i].bTitle.length) + "..." : data[i].bTitle
 	            							a = '<a href="noticeBoardDetail.nb?bNum=' + data[i].bNum + '&page=1">' + bTitle +'</a>';
 	            							$tr.append($('<td>').html(a));
 	            							$tr.append($('<td>').text(data[i].mName  + " " + (data[i].jobName == null ? "" : data[i].jobName)));
 	            							$tr.append($('<td>').text(data[i].createDate ));
 	            							$tr.append($('<td>').text(data[i].views));
 	            							
 	            							$tableBody.append($tr);
 	            						} 
 	            						
 	            					} else {
	            						$tr = $('<tr>');
	            						$tr.append($('<td colspan="5">').text("등록된 게시글이 없습니다."));
	            							
	            						$tableBody.append($tr);
	            					}
 	            					
 	            					
 	            				},
 	            				error: function(data) {
 	            					console.log(data);
 	            				}
 	             			})
	             			
	             		}
	             		
	             		
                    </script>
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


</body>
</html>