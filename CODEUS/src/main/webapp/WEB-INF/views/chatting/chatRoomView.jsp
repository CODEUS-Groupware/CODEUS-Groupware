<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
        .chat_wrap .item .box{display:inline-block; max-width:180px; position:relative}
        .chat_wrap .item .box::before{content:""; position:absolute; left:-8px; top:9px; border-top:0px solid transparent; border-bottom:8px solid transparent;border-right:8px solid #fff;}
        .chat_wrap .item .box .msg {background:#fff; border-radius:10px; padding:8px; text-align:left}
        .chat_wrap .item .box .time {font-size:11px; color:#999; position:absolute; right: -75px; bottom:5px; width:70px}
        .chat_wrap .item .mymsg{text-align:right}
        .chat_wrap .item .mymsg .box::before{left:auto; right:-8px; border-left:8px solid #fee600; border-right:0;}
        .chat_wrap .item .mymsg .box .msg{background:#fee600}
        .chat_wrap .item .mymsg .box .time{right:auto; left:-75px}
        .chat_wrap .item .box{transition:all .3s ease-out; margin:0 0 0 20px;opacity:0}
        .chat_wrap .item .mymsg .box{transition:all .3s ease-out; margin:0 20px 0 0;}
        .chat_wrap .item .on .box{margin:0; opacity: 1;}

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
	        
	            <div class="item">
	                <div class="box">
	                    <p class="msg">안녕하세요</p>
	                    <span class="time">오전 10:05</span>
	                </div>
	            </div>
	
	            <div class="item mymsg">
	                <div class="box">
	                    <p class="msg">안녕하세요</p>
	                    <span class="time">오전 10:05</span>
	                </div>
	            </div>
	            <div class="item mymsg">
	                <div class="box">
	                    <p class="msg">안녕하세요</p>
	                    <span class="time">오전 10:05</span>
	                </div>
	            </div>
	           
	        	</div>
	
	        <textarea id="chatText" cols="3" placeholder="내용 입력"></textarea><button>전송</button>
	    </div>
	</div>
		
	    
    <!-- Datatable -->
 
</body>

</html>