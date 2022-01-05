<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
	<title>Home</title>
	<!--  <script src="${contextPath}/resources/assets/vendor/fullcalendar/js/ko.js"></script>-->
	<link rel="icon" type="image/png" sizes="16x16" href="${contextPath}/resources/assets/images/favicon.png">
	<link href="${contextPath}/resources/assets/vendor/fullcalendar/css/fullcalendar.min.css" rel="stylesheet">
    <link href="${contextPath}/resources/assets/css/style.css" rel="stylesheet">
	<style>
		#tb{margin:auto; width: 700px;}
	</style>
</head>
<body>
	<c:import url="../common/menubar.jsp"/>
	
	 <!--**********************************
            Content body start
        ***********************************-->
        <div class="content-body">
            <div class="container-fluid">
                <div class="row page-titles mx-0">
                    <div class="col-sm-6 p-md-0">
                        <div class="welcome-text">
                            <h4>안녕, 다시 돌아왔구나</h4>
                            <p class="mb-0">Your business dashboard template</p>
                        </div>
                    </div>
                    <div class="col-sm-6 p-md-0 justify-content-sm-end mt-2 mt-sm-0 d-flex">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="javascript:void(0)">캘린더</a></li>
                            <li class="breadcrumb-item active"><a href="javascript:void(0)">일정관리</a></li>
                        </ol>
                    </div>
                </div>
                <!-- row -->


                <div class="row">
                    <div class="col-lg-3">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="card-intro-title">일정 관리</h4>

                                <div class="">
                                    <div id="external-events" class="my-3">
                                        <p>너의 이벤트를 드래그, 드롭해봐 또는 달력을 클릭해봐</p>
                                        <div class="external-event" data-class="bg-primary"><i class="fa fa-move"></i>새 테마를 릴리즈해봐</div>
                                        <div class="external-event" data-class="bg-success"><i class="fa fa-move"></i>내 이벤트
                                        </div>
                                        <div class="external-event" data-class="bg-warning"><i class="fa fa-move"></i>매니저 만나기</div>
                                        <div class="external-event" data-class="bg-dark"><i class="fa fa-move"></i>새로운 테마 생성</div>
                                    </div>
                                    <!-- checkbox -->
                                    <div class="checkbox checkbox-event pt-3 pb-5">
                                        <input id="drop-remove" class="styled-checkbox" type="checkbox">
                                        <label class="ml-2 mb-0" for="drop-remove">드롭 후 제거</label>
                                    </div>
                                    <a href="javascript:void()" data-toggle="modal" data-target="#add-category" class="btn btn-primary btn-event w-100">
                                        <span class="align-middle"><i class="ti-plus"></i></span> 생성하기
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-9">
                        <div class="card">
                            <div class="card-body">
                                <div id="calendar" class="app-fullcalendar"></div>
                            </div>
                        </div>
                    </div>
   					<script>
    	               
   					</script>                 
                    <!-- BEGIN MODAL -->
                    <div class="modal fade none-border" id="event-modal">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h4 class="modal-title"><strong>이벤트 추가</strong></h4>
                                </div>
                                <div class="modal-body"></div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default waves-effect" data-dismiss="modal">닫기</button>
                                    <button type="button" class="btn btn-success save-event waves-effect waves-light">이벤트 생성</button>

                                       
                                    <button type="button" class="btn btn-danger delete-event waves-effect waves-light" data-dismiss="modal">삭제</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Modal Add Category -->
                    <div class="modal fade none-border" id="add-category">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h4 class="modal-title"><strong>카테고리 추가</strong></h4>
                                </div>
                                <div class="modal-body">
                                    <form>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <label class="control-label">카테고리 이름</label>
                                                <input class="form-control form-white" placeholder="이름 입력" type="text" name="category-name">
                                            </div>
                                            <div class="col-md-6">
                                                <label class="control-label">색 좀 골라봐</label>
                                                <select class="form-control form-white" data-placeholder="색 선택" name="category-color">
                                                    <option value="성공">성공</option>
                                                    <option value="위험">위험</option>
                                                    <option value="정보">정보</option>
                                                    <option value="분홍">분홍</option>
                                                    <option value="기본">기본</option>
                                                    <option value="경고">경고</option>
                                                </select>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default waves-effect" data-dismiss="modal">닫기</button>
                                    <button type="button" class="btn btn-danger waves-effect waves-light save-category" data-dismiss="modal">저장</button>
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
	        Scripts
	    ***********************************-->
	    <!-- Required vendors -->
	    <script src="${contextPath}/resources/assets/vendor/global/global.min.js"></script>
	    <script src="${contextPath}/resources/assets/js/quixnav-init.js"></script>
	    <script src="${contextPath}/resources/assets/js/custom.min.js"></script>
	    <!--removeIf(production)-->
	    <!-- Demo scripts -->
	    <script src="${contextPath}/resources/assets/js/styleSwitcher.js"></script>
	
		
		
	    <script src="${contextPath}/resources/assets/vendor/jqueryui/js/jquery-ui.min.js"></script>
	    <script src="${contextPath}/resources/assets/vendor/moment/moment.min.js"></script>
		
	  
	    
	    <script src="${contextPath}/resources/assets/vendor/fullcalendar/js/fullcalendar.min.js"></script>
	    <script src="${contextPath}/resources/assets/js/plugins-init/fullcalendar-init.js"></script>
</body>
</html>
