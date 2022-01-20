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
 
 
</style>

<body>

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
                    
                    <!------------- 공지사항 시작  ------------->
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


<%--     <script src="${contextPath}/resources/assets/js/dashboard/dashboard-2.js"></script> --%>
    <!-- Circle progress -->

</body>
</html>