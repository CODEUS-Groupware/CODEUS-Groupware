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
		
		<img id="profileImg" class="img-fluid"
							src="/displayFile?fileName=${userImage}&directory=profile" style = "display:none">
		<input type="text" id="nickname" value = "${user_name}" style = "display:none">
		 <input type="button" id="enterBtn" value="입장" style = "display:none">
		 <input type="button" id="exitBtn" value="나가기" style = "display:none">
        
        <!--**********************************
            Content body end
        ***********************************-->
          
    </div>
    <!--**********************************
        Main wrapper end
    ***********************************-->
    
    
	    <!--**********************************
	        Scripts
	    ***********************************-->
	    
	    <script>
		 
		//전송 버튼 누르는 이벤트
		 $("#sendBtn").on("click", function(e) {
		 	sendMessage();
		 	$('#msg').val('')
		 });

		 var sock = new SockJS('http://localhost:9180/chatting');
		 sock.onmessage = onMessage;
		 sock.onclose = onClose;
		 sock.onopen = onOpen;

		 function sendMessage() {
		 	sock.send($("#msg").val());
		 }
		 //서버에서 메시지를 받았을 때
		 function onMessage(msg) {
		 	
		 	var data = msg.data;
		 	var sessionId = null; //데이터를 보낸 사람
		 	var message = null;
		 	
		 	var arr = data.split(":");
		 	
		 	for(var i=0; i<arr.length; i++){
		 		console.log('arr[' + i + ']: ' + arr[i]);
		 	}
		 	
		 	var cur_session = '${userid}'; //현재 세션에 로그인 한 사람
		 	console.log("cur_session : " + cur_session);
		 	
		 	sessionId = arr[0];
		 	message = arr[1];
		 	
		     //로그인 한 클라이언트와 타 클라이언트를 분류하기 위함
		 	if(sessionId == cur_session){
		 		
		 		var str = "<div class='col-6'>";
		 		str += "<div class='alert alert-secondary'>";
		 		str += "<b>" + sessionId + " : " + message + "</b>";
		 		str += "</div></div>";
		 		
		 		$("#msgArea").append(str);
		 	}
		 	else{
		 		
		 		var str = "<div class='col-6'>";
		 		str += "<div class='alert alert-warning'>";
		 		str += "<b>" + sessionId + " : " + message + "</b>";
		 		str += "</div></div>";
		 		
		 		$("#msgArea").append(str);
		 	}
		 	
		 }
		 //채팅창에서 나갔을 때
		 function onClose(evt) {
		 	
		 	var user = '${pr.username}';
		 	var str = user + " 님이 퇴장하셨습니다.";
		 	
		 	$("#msgArea").append(str);
		 }
		 //채팅창에 들어왔을 때
		 function onOpen(evt) {
		 	
		 	var user = '${pr.username}';
		 	var str = user + "님이 입장하셨습니다.";
		 	
		 	$("#msgArea").append(str);
		 }
		</script>
	    
    <!-- Datatable -->
    <script src="${contextPath}/resources/assets/vendor/datatables/js/jquery.dataTables.min.js"></script>
    <script src="${contextPath}/resources/assets/js/plugins-init/datatables.init.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
</body>

</html>