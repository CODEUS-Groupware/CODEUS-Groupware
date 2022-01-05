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
               <%--  <img class="logo-compact" src="${contextPath}/resources/assets/images/logo-text.png" alt=""> --%>
               <%--  <img class="brand-title" src="${contextPath}/resources/assets/images/logo-text.png" alt="" style="width: 200px; height: 100px;"> --%>
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
                    	<i class="fa fa-sitemap"></i><!-- <i class="fa fa-user-plus"></i> --><span class="nav-text">조직 관리</span></a>
                     	  <ul aria-expanded="false">
                            <li><a href="mlist.ad">사원 관리</a></li>
                            <li><a href="deptlist.ad">부서 관리</a></li>
                            <li><a href="joblist.ad">직위 관리</a></li>
                        </ul>                   	
                    </li>
                    
                   <!--  <li class="nav-label">Apps</li> -->
                   <!-- 공지사항, 자료실은 멤버 페이지에서 관리자 여부로 작성/수정할 수 있게 하기 -->
<!--                     <li><a href="javascript:void()" aria-expanded="false"> -->
<!--                     		<i class="fa fa-bullhorn"></i><span class="nav-text">공지사항 관리</span></a> -->
<!--                     </li> -->
<!--                     <li><a class="has-arrow" href="javascript:void()" aria-expanded="false"> -->
<!--                     		<i class="fa fa-folder-open-o"></i><span class="nav-text">자료실 관리</span></a> -->
<!--                         <ul aria-expanded="false"> -->
<!--                             <li><a href="javascript:void()">자료 등록</a></li> -->
<!--                             <li><a href="javascript:void()">자료실 용량</a></li> -->
<!--                         </ul> -->
<!--                     </li> -->
                    <li><a href="javascript:void()" aria-expanded="false">
                    		<i class="fa fa-bars"></i><span class="nav-text">신고글 관리</span></a>

                    </li>
                    <li><a href="javascript:void()" aria-expanded="false"><i
                                class="fa fa-pencil-square-o"></i><span class="nav-text">회의실 관리</span></a>
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
</body>
</html>