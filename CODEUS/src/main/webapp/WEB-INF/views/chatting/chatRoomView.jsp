<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>Focus - Bootstrap Admin Dashboard </title>
    <!-- Datatable -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css"/>
    <script src="https://code.jquery.com/jquery-1.8.3.min.js" integrity="sha256-YcbK69I5IXQftf/mYD8WY0/KmEDCv1asggHpJk1trM8=" crossorigin="anonymous"></script>
	<style>
		body{background-color: ghostwhite;}
        .chat_wrap .inner{background-color: ghostwhite; border-radius:5px; padding:10px; overflow-y:scroll;height: 590px;}
        .chat_wrap .item{margin-top:15px}
        .chat_wrap .item:first-child{margin-top:0px}
        
        .chat_wrap .box{display:inline-block; max-width:180px; position:relative;}
        .chat_wrap .box::before{content:""; position:absolute; left:-8px; top:9px; border-top:0px solid transparent; border-bottom:8px solid transparent; border-right:8px solid #fff;}
        .chat_wrap .box .msg {background:#fff; border-radius:10px; padding:8px; text-align:left}
        .chat_wrap .box .time {font-size:11px; color:#999; position:absolute; right: -75px; bottom:5px; width:70px}
        
        .chat_wrap .mybox{display:inline-block; max-width:180px; position:relative; left: 280px;}
        .chat_wrap .mybox::before{content:""; position:absolute; right:8px; top:9px; border-top:0px solid transparent; border-bottom:8px solid transparent; border-right:8px solid #fff;}
        .chat_wrap .mybox .msg {background:#ff0; border-radius:10px; padding:8px; text-align:right}
        .chat_wrap .mybox .time {font-size:11px; color:#999; position:absolute; right: 100px; bottom:5px; width:70px; text-align:right}

        textarea{border: 0; width:70%; background:#fff; border-radius:5px; height: 80px; padding-left:5px; box-sizing:border-box; margin-top:5px; resize: none;}
        textarea::placeholder{color:#999}
        
        button{border: 0; width:30%; height: 80px; border-radius:5px; box-sizing:border-box; margin-top:5px; background: #593bdb; color: white;}
        textarea, button{vertical-align: middle;}
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
	        
	        
			<div class="chat_wrap">
	        	<div class="inner">
	        	<div id="chatlist">
	       		<table>
	       			<c:forEach var="msg" items="${ list }">
	       			<input type="hidden" id="roomNum" value="${msg.roomNum}">
	       			<c:if test="${ msg.sander != loginUser.mId }">
	            	<tr>
	            		<td>
	            			<div class="box">
	            				<br>
	            				<div id="sand">${ msg.sander }</div>
	            				<p class="msg">${ msg.msgContent }</p>
	                    		<span class="time"><fmt:formatDate pattern="yyyy-MM-dd hh:mm" value="${ msg.msgTime }"/></span>
	            			</div>
	            		</td>
	            	</tr>
	            	</c:if>
	            	<c:if test="${ msg.sander == loginUser.mId }">
	            	<tr>
	            		<td>
	            			<div class="mybox">
	            				<br>
	            				<div style="display: inline-block; text-align: right;">나</div>
	            				<p class="msg">${ msg.msgContent }</p>
	                    		<span class="time"><fmt:formatDate pattern="yyyy-MM-dd hh:mm" value="${ msg.msgTime }"/></span>
	            			</div>
	            		</td>
	            	</tr>
	            	</c:if>
	            	</c:forEach>
	           	</table></div>
	           	
	        	</div>
	
	        <textarea id="chatText" name="chatText" cols="3" placeholder="내용 입력"></textarea><button id="btnSubmit">전송</button>
	    </div>
	</div>
	
	<script>
		$("#btnSubmit").click(function() {
			var msg = $('#chatText').val();
			var sander = $('#sand').text();
			var roomNum = $('#roomNum').val();
			console.log(msg);
			console.log(sander);
			console.log(roomNum);
			
			$.ajax({
				url: "sandMsg.ch",
				data: {msg:msg, sander:sander, roomNum:roomNum},
				type: "POST",
				success: function(data) {
					console.log(data);
					
					if(data == "success") {
						location.reload();
					}
				},
				error: function() {
					console.log(data);
				}
			});
			
			$('#chatText').val('');
		});
	</script>
	    
    <!-- Datatable -->
 
</body>

</html>