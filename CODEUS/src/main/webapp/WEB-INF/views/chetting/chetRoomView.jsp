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
</head>

<body>

    <!--**********************************
        Main wrapper start
    ***********************************-->
    <div id="main-wrapper">	

		
    
        <!--**********************************
            Content body start
        ***********************************-->
        
        <div class="content-body">
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
	           
	        </div>
	
	        <div class="form-group">
	        	<textarea class="form-control" rows="4" id="comment" style="margin-top: 0px; margin-bottom: 0px; height: 108px;"></textarea>
            </div>
        </div>
        
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
    <!-- Datatable -->
    <script src="${contextPath}/resources/assets/vendor/datatables/js/jquery.dataTables.min.js"></script>
    <script src="${contextPath}/resources/assets/js/plugins-init/datatables.init.js"></script>

</body>

</html>