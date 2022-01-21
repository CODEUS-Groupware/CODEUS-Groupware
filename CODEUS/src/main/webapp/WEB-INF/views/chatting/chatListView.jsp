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

		<%@ include file="/WEB-INF/views/common/menubar.jsp" %>
    
        <!--**********************************
            Content body start
        ***********************************-->
        <div class="content-body">
            <div class="container-fluid">
                <div class="row page-titles mx-0">
                    <div class="col-sm-12 p-md-0">
                        <div class="welcome-text">
                            <h4>채팅 목록</h4>
                        </div>
                    </div>
                </div>
                
                <!-- row -->

                <div class="row">
     				<div class="col-xl-11 col-lg-10 col-xxl-10 col-md-10">
                        <div class="card">
                            <div class="card-body">
                                <div class="recent-comment m-t-15">
                                	<c:forEach var="ch" items="${ list }">
	                                    <div class="media">
	                                        <div class="media-left">
	                                            <a href="#"><img src="/codeus/resources/assets/images/empty-profile.png" class="img-fluid rounded-circle" alt="" style="width: 70px"></a>
	                                        </div>
	                                        <div class="media-body">
	                                            <h4 id="sander" class="media-heading text-primary">${ ch.sander }</h4>
	                                            <p>${ ch.msgContent }</p>
	                                            <p class="comment-date">${ ch.msgTime }</p>
	                                        </div>
	                                    </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-xl-1 col-lg-2 col-xxl-2 col-md-2">
                        <div class="card">
                            <div class="card-body">
                                <div class="recent-comment m-t-15">
                                    <div class="media">
                                        <button class="form-control input-default" style="background: #593bdb; color: white; height: 80px;">대화<br>상대<br>검색</button>
                                    </div>
                                    <div class="media">
                                        <button id="delete" class="form-control input-default" style="background: #593bdb; color: white; height: 50px;">채팅방<br>삭제</button>
                                    </div>
                                    <div class="media">
                                        <button class="form-control input-default" style="background: #593bdb; color: white; height: 50px;">채팅방<br>나가기</button>
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
	    <script>
			$(function() {
				$('#sander').click(function() {
					var sander = $(this).text();
					console.log(sander);
					window.open('chatRoom.ch?sander=' + sander, "_blank",
						"toolbar=yes,menubar=yes,width=700,height=500").focus();
				});
			});

	    </script>
	    
    <!-- Datatable -->
    <script src="${contextPath}/resources/assets/vendor/datatables/js/jquery.dataTables.min.js"></script>
    <script src="${contextPath}/resources/assets/js/plugins-init/datatables.init.js"></script>

</body>

</html>