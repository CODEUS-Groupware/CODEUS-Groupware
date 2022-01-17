<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Insert title here</title>
<!-- Favicon icon -->
<link rel="icon" type="image/png" sizes="16x16" href="${contextPath}/assets/resources/images/favicon.png">
<!-- Custom Stylesheet -->
<link href="${contextPath}/resources/assets/css/style.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
<!-- Google fonts - Noto Sans Korean -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&family=Noto+Sans+KR:wght@300;400&family=Open+Sans&display=swap" rel="stylesheet">
<style>
	 body, h1, h2, h3, h4, h5, h6, p, span {
   	 	font-family: 'Noto Sans KR', sans-serif;
  	 }
</style>
</head>
<body>

	<c:set var="contextPath" value="${ pageContext.servletContext.contextPath }" scope="application"/>

    <!--*******************
        Preloader start
    ********************--> 
    <div id="preloader">
        <div class="sk-three-bounce">
            <div class="sk-child sk-bounce1"></div>
            <div class="sk-child sk-bounce2"></div>
            <div class="sk-child sk-bounce3"></div>
        </div>
    </div>
    <!--*******************
        Preloader end
    ********************--> 

        <!--**********************************
            Nav header start
        ***********************************-->
        <div class="nav-header">
            <a href="${contextPath}/admin/mlist.ad" class="brand-logo" style="background: #2b2d35;">
                <img class="logo-abbr" src="${contextPath}/resources/assets/images/logo.png" alt="" style="border-radius: 100%; width: 170px; height: 32px;">
               	<b class="logo-compact" style="font-size: x-large;">CODEUS</b>
               	<b class="brand-title" style="font-size: x-large;">CODEUS</b>
            </a>

            <div class="nav-control">
                <div class="hamburger">
                    <span class="line"></span><span class="line"></span><span class="line"></span>
                </div>
            </div>
        </div>
        <!--**********************************
            Nav header end
        ***********************************-->

        <!--**********************************
            Header start
        ***********************************-->
        <div class="header">
            <div class="header-content">
                <nav class="navbar navbar-expand">
                    <div class="collapse navbar-collapse justify-content-between">
                        <div class="header-left">
                        </div>
                        <ul class="navbar-nav header-right">
                            <li class="nav-item dropdown header-profile">
                                <a class="nav-link" href="#" role="button" data-toggle="dropdown">
                                    <i class="mdi mdi-account"></i>
                                </a>
                                <div class="dropdown-menu dropdown-menu-right">
                                    <a href="${contextPath}/home.do" class="dropdown-item">
                                        <i class="fa fa-home"></i>
                                        <span class="ml-2">Dashboard </span>
                                    </a>
                                    <a href="${contextPath}/logout.me" class="dropdown-item">
                                        <i class="icon-key"></i>
                                        <span class="ml-2">Logout </span>
                                    </a>
                                </div>
                            </li>
                        </ul>
                    </div>
                </nav>
            </div>
        </div>
        <!--**********************************
            Header end ti-comment-alt
        ***********************************-->

        <!--**********************************
            Sidebar start
        ***********************************-->
        <div class="quixnav" style="background: #292B30;">
            <div class="quixnav-scroll">
                <ul class="metismenu" id="menu">
                	<li class="nav-label first">Admin Menu</li>
                    <li><a class="has-arrow" href="${contextPath}" aria-expanded="false">
                    	<i class="bi bi-diagram-3"></i><span class="nav-text">조직 관리</span></a>
                     	  <ul aria-expanded="false">
                            <li><a href="mlist.ad">사원 관리</a></li>
                            <li><a href="deptlist.ad">부서 관리</a></li>
                            <li><a href="joblist.ad">직위 관리</a></li>
                        </ul>                   	
                    </li>
                    <li><a href="reportList.ad" aria-expanded="false">
                    		<i class="fa fa-bars"></i><span class="nav-text">신고글 관리</span></a>

                    </li>
                    <li><a href="meetList.ad" aria-expanded="false">
                    	<i class="bi bi-pencil-square"></i><span class="nav-text">회의실 관리</span></a>
                    </li>
                </ul>
            </div>
        </div>
        <!--**********************************
            Sidebar end
        ***********************************-->   
 
	
	    <!--**********************************
	        Scripts
	    ***********************************-->
	    <!-- Required vendors -->
	    <script src="${contextPath}/resources/assets/vendor/global/global.min.js"></script>
	    <script src="${contextPath}/resources/assets/js/quixnav-init.js"></script>
	    <script src="${contextPath}/resources/assets/js/custom.min.js"></script>      
	    
	    <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</body>
</html>