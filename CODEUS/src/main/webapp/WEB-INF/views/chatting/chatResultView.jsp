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
                            <h4>대화상대 검색</h4>
                        </div>
                    </div>
                </div>
                
                <!-- row -->

                <div class="row">
     				<div class="col-xl-11 col-lg-10 col-xxl-10 col-md-10">
                        <div class="card">
                        	<div class="card-header">
                                <table style="border: none; width: 100%">
		                        	<tr>
		                        		<td><input type="text" class="form-control input-default" placeholder="대화상대 검색"><td>
		                        		<td><button class="form-control input-default" style="background: #593bdb; color: white;"><i class="bi bi-search"></i></button><td>
		                        	</tr>
                       	 		</table>
                            </div>
                            <div class="card-body">
                                <div class="recent-comment m-t-15" style="overflow:auto; height:400px;">
                                	<c:forEach var="ch" items="${ list }">
	                                    <div class="media">
	                                        <div class="media-left">
	                                            <a href="#"><img src="/codeus/resources/assets/images/empty-profile.png" class="img-fluid rounded-circle" alt="" style="width: 70px"></a>
	                                        </div>
	                                        <div class="media-body">
	                                            <h4 class="media-heading text-primary sander">
	                                            	${ ch.mName }
		                                  		</h4>
	                                            <input type="checkbox" style="float: right; margin-right: 30px;" name="sander" value="${ ch.mId }">
	                                            <p>${ ch.deptName }, ${ ch.jobName }</p>
	                                        </div>
	                                    </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-xl-1 col-lg-2 col-xxl-2 col-md-2">
                        <div class="card" style="height: 500px;">
                            <div class="card-body">
                                <div class="recent-comment m-t-15">
                                    <div class="media">
                                        <button class="form-control input-default" style="background: #593bdb; color: white; height: 50px;" onclick="location.href='chatList.ch'">채팅<br>목록</button>
                                    </div>
                                    <div class="media">
                                        <button id="createChat" class="form-control input-default" style="background: #593bdb; color: white; height: 50px;">채팅방<br>생성</button>
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
	    	$('#createChat').click(function(){
	    		var sander = $("input[name='sander']:checked").val();
	    		
	    		  console.log(sander);
	    		
	    		$.ajax({
					url: "createChat.ch",
					data: {sander:sander},
					type: "POST",
					success: function(data) {
						console.log(data);
						
						if(data == "success") {
							alert("생성되었습니다.");
							location.href='chatList.ch';
						}
					},
					error: function() {
						console.log(data);
					}
				});
	    	});
	    
	    </script>
	    
    <!-- Datatable -->
    <script src="${contextPath}/resources/assets/vendor/datatables/js/jquery.dataTables.min.js"></script>
    <script src="${contextPath}/resources/assets/js/plugins-init/datatables.init.js"></script>

</body>

</html>