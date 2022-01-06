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
                            <h4>주소록</h4>
                        </div>
                    </div>
                </div>
                
                <!-- row -->

                <div class="row">
                	<div class="col-xl-3 col-lg-2 col-xxl-2 col-md-2">
                        <div class="card">
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table student-data-table m-t-20" style="color : black; text-align: center;">
                                        <thead>
                                            <tr>
                                                <th>프로필 사진 영역
                                                <div class="media-left">
                                            		<a href="#"><img class="media-object mr-3" src="./images/avatar/4.png" alt="..."></a>
                                        		</div>
                                        		</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>사원 이름</td>
                                            </tr>
                                            <tr>
                                                <td>직급</td>
                                            </tr>
                                            <tr>
                                                <td>부서</td>
                                            </tr>
                                            <tr>
                                                <td>연락처</td>
                                            </tr>
                                            <tr>
                                                <td>비고</td>
                                            </tr>
                                            <tr>
                                                <td><button class="form-control input-default" style="background: #593bdb; color: white;">-</button></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                	
                    <div class="col-xl-9 col-lg-10 col-xxl-10 col-md-10">
                        <div class="card">
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table student-data-table m-t-20" style="color : black; text-align: center; border: none;">
                                        <thead>
                                            <tr>
                                            	<th></th>
                                                <th>이름</th>
                                                <th>직급</th>
                                                <th>부서</th>
                                                <th>연락처</th>
                                                <th>상태</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                            	<td></td>
                                                <td>강건강</td>
                                                <td>대리</td>
                                                <td>영업1팀</td>
                                                <td>010-1111-2222</td>
                                                <td>근무중</td>
                                                <td><button class="form-control input-default" style="background: #593bdb; color: white;">&nbsp-&nbsp</button></td>
                                            </tr>
                                            <tr>
                                            	<td></td>
                                                <td>강건강</td>
                                                <td>대리</td>
                                                <td>영업1팀</td>
                                                <td>010-1111-2222</td>
                                                <td>근무중</td>
                                                <td><button class="form-control input-default" style="background: #593bdb; color: white;">&nbsp-&nbsp</button></td>
                                            </tr>
                                            <tr>
                                            	<td></td>
                                                <td>강건강</td>
                                                <td>대리</td>
                                                <td>영업1팀</td>
                                                <td>010-1111-2222</td>
                                                <td>근무중</td>
                                                <td><button class="form-control input-default" style="background: #593bdb; color: white;">&nbsp-&nbsp</button></td>
                                            </tr>
                                            <tr>
                                            	<td></td>
                                                <td>강건강</td>
                                                <td>대리</td>
                                                <td>영업1팀</td>
                                                <td>010-1111-2222</td>
                                                <td>근무중</td>
                                                <td><button class="form-control input-default" style="background: #593bdb; color: white;">&nbsp-&nbsp</button></td>
                                            </tr>
                                            <tr>
                                            	<td></td>
                                                <td>강건강</td>
                                                <td>대리</td>
                                                <td>영업1팀</td>
                                                <td>010-1111-2222</td>
                                                <td>근무중</td>
                                                <td><button class="form-control input-default" style="background: #593bdb; color: white;">&nbsp-&nbsp</button></td>
                                            </tr>
                                            <tr>
                                            	<td></td>
                                                <td>강건강</td>
                                                <td>대리</td>
                                                <td>영업1팀</td>
                                                <td>010-1111-2222</td>
                                                <td>근무중</td>
                                                <td><button class="form-control input-default" style="background: #593bdb; color: white;">&nbsp-&nbsp</button></td>
                                            </tr>
                                            <tr>
                                            	<td></td>
                                                <td>강건강</td>
                                                <td>대리</td>
                                                <td>영업1팀</td>
                                                <td>010-1111-2222</td>
                                                <td>근무중</td>
                                                <td><button class="form-control input-default" style="background: #593bdb; color: white;">&nbsp-&nbsp</button></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div>
                                	<button class="form-control input-default" style="background: #593bdb; color: white;">주소록 검색</button>
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
    <!-- Datatable -->
    <script src="${contextPath}/resources/assets/vendor/datatables/js/jquery.dataTables.min.js"></script>
    <script src="${contextPath}/resources/assets/js/plugins-init/datatables.init.js"></script>

</body>

</html>