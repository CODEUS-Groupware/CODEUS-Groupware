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
	<style>
		body{background: #F8F9FE;}
	</style>
</head>

<body>

    <!--**********************************
        Main wrapper start
    ***********************************-->
    <div id="main-wrapper">	

		
    
        <!--**********************************
            Content body start
        ***********************************-->
        
        <c:set var="profile" value='<%=session.getAttribute("loginUser")%>' />
		<div class="header" style="background: white; align-content: center">
			<div class="header-content">
				<img src="${contextPath}/resources/assets/images/logo.png" alt="CODEUS" width="50px">
			</div>
			
		</div>

		<div class="row">
			<div class="col-xl-6 col-xxl-12">
			 	
				<div class="col-12 row justify-content-center align-items-center my-5 ">
					방명수
				</div>
				
				<!-- 채팅 내용 -->
				<div class="col-12">
					<div class="card">
						<table>
							<tr>
								<td style="text-align: left">안녕하세요</td>
							</tr>
							<tr>
								<td style="text-align: right;">안녕하세요</td>
							</tr>
						</table>
					</div>
					
				</div>
			
				<!-- 채팅 입력창 -->
				<div class="col-12" style="margin-top: 20px; margin-bottom: 15px;">
					<div class="col-12" style="float: left">
						
						<span>
							<textarea class="form-control" rows="4" id="message"></textarea>
							<button class="btn btn-primary" style="margin-top: 30px; text-align: center; color: white; font-weight: bold;" id = "sendBtn">전송</button>
						</span>
					</div>
			
				</div>
			</div>
		</div>
		
		
	    
    <!-- Datatable -->
    <script src="${contextPath}/resources/assets/vendor/datatables/js/jquery.dataTables.min.js"></script>
    <script src="${contextPath}/resources/assets/js/plugins-init/datatables.init.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
</body>

</html>