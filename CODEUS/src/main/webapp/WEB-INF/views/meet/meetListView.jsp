<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>회의실 예약 - 예약 목록 </title>
    <link href="${contextPath}/resources/assets/css/style.css" rel="stylesheet">
</head>

<body>

    <!--**********************************
        Main wrapper start
    ***********************************-->
    <div id="main-wrapper">	

		<c:import url="../common/menubar.jsp"/>
    
        <!--**********************************
            Content body start
        ***********************************-->
        <div class="content-body">
            <div class="container-fluid">
                <div class="row page-titles mx-0">
                    <div class="col-sm-6 p-md-0">
                        <div class="welcome-text">
                            <h4>회의실 예약 목록</h4>
                        </div>
                    </div>
                    <div class="col-sm-6 p-md-0 justify-content-sm-end mt-2 mt-sm-0 d-flex">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item">회의실 예약</li>
                            <li class="breadcrumb-item active"><a href="mrlist.mr">예약 목록</a></li>
                        </ol>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <div class="card">
                            <div class="card-body">
                            
                                <!-- 탭 영역 시작 -->
                                <ul class="nav nav-pills mb-4">
                                    <li class=" nav-item">
                                        <a href="#navpills-1" class="nav-link active" data-toggle="tab" aria-expanded="false">전체 예약 목록</a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="#navpills-2" class="nav-link" data-toggle="tab" aria-expanded="false">내 예약 목록</a>
                                    </li>
                                </ul>
                                <!-- 탭 영역 끝 -->
                                
                                <!-- 탭 컨텐츠 영역 시작 -->
                                <div class="tab-content">
                                
                                    <!-- 1st 탭 컨텐츠 시작 -->
                                    <div id="navpills-1" class="tab-pane active">
                                        <div class="table-responsive">
                                            <table class="table table-responsive-sm" id="tb1" style="align-content: center; text-align: center;">
                                                <thead>
                                                    <tr>
                                                        <th scope="col" width="50px">예약번호</th>
                                                        <th scope="col" width="200px">예약날짜</th>
                                                        <th scope="col" width="100px">예약상태</th>
                                                        <th scope="col" width="120px">회의실 명</th>
                                                        <th scope="col" width="100px">예약자</th>
                                                        <th scope="col" width="430px" style="overflow: hidden;">예약목적</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:if test="${ !empty loginUser }">
                                                        <c:if test="${ pi1.listCount == 0 }">
                                                            <tr>
                                                                <td colspan="6">예약 내역이 존재하지 않습니다.</td>
                                                            </tr>
                                                        </c:if>
                                                        <c:if test="${ pi1.listCount > 0 }">
                                                            <c:forEach var="mr1" items="${ list1 }">
                                                                <tr>
                                                                    <td>${ mr1.rev_no }</td>
                                                                    <td>${ mr1.rev_time }</td>
                                                                    <td>
                                                                        <c:choose>
                                                                            <c:when test="${ mr1.rev_status eq 0 }">
                                                                                <span class="badge badge-pill badge-success">예약 완료</span>
                                                                            </c:when>
                                                                            <c:when test="${ mr1.rev_status eq 1 }">
                                                                                <span class="badge badge-pill badge-secondary">사용 완료</span>
                                                                            </c:when>
                                                                            <c:when test="${ mr1.rev_status eq 2 }">
                                                                                <span class="badge badge-pill badge-warning">예약 취소</span>
                                                                            </c:when>
                                                                        </c:choose>
                                                                    </td>
                                                                    <td>${ mr1.meet_name }</td>
                                                                    <td>${ mr1.mName }</td>
                                                                    <td>${ mr1.rev_content }</td>
                                                                </tr>
                                                            </c:forEach>
                                                        </c:if>
                                                    </c:if>
                                                </tbody>
                                                
                                                <!-- 1st 탭 컨텐츠 페이징 시작 -->
                                                <tfoot>
                                                    <tr>
                                                        <td colspan="6">
                                                            <div class="d-flex justify-content-center">
                                                                <nav>
                                                                    <ul class="pagination pagination-sm pagination-gutter">
                                                                        <!-- 이전 -->
                                                                        <c:if test="${ pi1.currentPage <= 1 }">
                                                                            <li class="page-item page-indicator disabled">
                                                                                <a class="page-link"><i class="icon-arrow-left"></i></a>
                                                                            </li>
                                                                        </c:if>
                                                                        <c:if test="${ pi1.currentPage > 1 }">
                                                                            <c:url var="before1" value="mrlist.mr">
                                                                                <c:param name="page1" value="${ pi1.currentPage - 1 }"/>
                                                                            </c:url>
                                                                            <li class="page-item page-indicator">
                                                                                <a class="page-link" href="${ before1 }">
                                                                                    <i class="icon-arrow-left"></i>
                                                                                </a>
                                                                            </li>
                                                                        </c:if>
                                                                        
                                                                        <!-- 숫자 -->
                                                                        <c:forEach var="p1" begin="${ pi1.startPage }" end="${ pi1.endPage }">
                                                                            <c:if test="${ p1 eq pi1.currentPage }">
                                                                                <li class="page-item active">
                                                                                    <a class="page-link">${ p1 }</a>
                                                                                </li>
                                                                            </c:if>
                                                                            <c:if test="${ p1 ne pi1.currentPage }">
                                                                                <c:url var="pagination1" value="mrlist.mr">
                                                                                    <c:param name="page1" value="${ p1 }"/>
                                                                                </c:url>
                                                                                <li class="page-item">
                                                                                    <a class="page-link" href="${ pagination1 }">${ p1 }</a>
                                                                                </li>
                                                                            </c:if>
                                                                        </c:forEach>
                                                                        
                                                                        <!--  다음 -->
                                                                        <c:if test="${ pi1.currentPage >= pi1.maxPage }">
                                                                            <li class="page-item page-indicator disabled">
                                                                                <a class="page-link"><i class="icon-arrow-right"></i></a>
                                                                            </li>
                                                                        </c:if>
                                                                        <c:if test="${ pi1.currentPage < pi1.maxPage }">
                                                                            <c:url var="after1" value="mrlist.mr">
                                                                                <c:param name="page1" value="${ pi1.currentPage + 1 }"/>
                                                                            </c:url>
                                                                            <li class="page-item page-indicator">
                                                                                <a class="page-link" href="${ after1 }">
                                                                                    <i class="icon-arrow-right"></i>
                                                                                </a>
                                                                            </li>
                                                                        </c:if>
                                                                    </ul>
                                                                </nav>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </tfoot>
                                                <!-- 1st 탭 컨텐츠 페이징 끝 -->
                                                
                                            </table>
                                        </div>
                                    </div>
                                    <!-- 1st 탭 컨텐츠 끝 -->
                                    
                                    
                                    <!-- 2nd 탭 컨텐츠 시작 -->
                                    <div id="navpills-2" class="tab-pane">
                                        <div class="table-responsive">
                                            <table class="table table-responsive-sm" id="tb2" style="align-content: center; text-align: center;">
                                                <thead>
                                                    <tr>
                                                        <th scope="col" width="50px">예약번호</th>
                                                        <th scope="col" width="200px">예약날짜</th>
                                                        <th scope="col" width="100px">예약상태</th>
                                                        <th scope="col" width="120px">회의실 명</th>
                                                        <th scope="col" width="470px">예약목적</th>
                                                        <th scope="col" width="30px"><input type="checkbox" id="chkAll"></th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:if test="${ !empty loginUser }">
                                                        <c:if test="${ pi2.listCount == 0 }">
                                                            <tr>
                                                                <td colspan="6">예약 내역이 존재하지 않습니다.</td>
                                                            </tr>
                                                        </c:if>
                                                        <c:if test="${ pi2.listCount > 0 }">
                                                            <c:forEach var="mr2" items="${ list2 }">
                                                                <tr>
                                                                    <td>${ mr2.rev_no }</td>
                                                                    <td>${ mr2.rev_time }</td>
                                                                    <td>
                                                                        <c:choose>
                                                                            <c:when test="${ mr2.rev_status eq 0 }">
                                                                                <span class="badge badge-pill badge-success">예약 완료</span>
                                                                            </c:when>
                                                                            <c:when test="${ mr2.rev_status eq 1 }">
                                                                                <span class="badge badge-pill badge-secondary">사용 완료</span>
                                                                            </c:when>
                                                                            <c:when test="${ mr2.rev_status eq 2 }">
                                                                                <span class="badge badge-pill badge-warning">예약 취소</span>
                                                                            </c:when>
                                                                        </c:choose>
                                                                    </td>
                                                                    <td>${ mr2.meet_name }</td>
                                                                    <td>${ mr2.rev_content }</td>
                                                                    <td><input type="checkbox" class="chk" name="rev_no" value="${ mr2.rev_no }"></td>
                                                                </tr>
                                                            </c:forEach>
                                                        </c:if>
                                                    </c:if>
                                                </tbody>
                                                
                                                <!-- 2st 탭 컨텐츠 페이징 시작 -->
                                                <tfoot>
                                                    <tr>
                                                        <td colspan="6">
                                                            <div class="d-flex justify-content-center">
                                                                <nav>
                                                                    <ul class="pagination pagination-sm pagination-gutter">
                                                                        <!-- 이전 -->
                                                                        <c:if test="${ pi2.currentPage <= 1 }">
                                                                            <li class="page-item page-indicator disabled">
                                                                                <a class="page-link"><i class="icon-arrow-left"></i></a>
                                                                            </li>
                                                                        </c:if>
                                                                        <c:if test="${ pi2.currentPage > 1 }">
                                                                            <c:url var="before2" value="mrlist.mr">
                                                                                <c:param name="page2" value="${ pi2.currentPage - 1 }"/>
                                                                            </c:url>
                                                                            <li class="page-item page-indicator">
                                                                                <a class="page-link" href="${ before2 }">
                                                                                    <i class="icon-arrow-left"></i>
                                                                                </a>
                                                                            </li>
                                                                        </c:if>
                                                                        
                                                                        <!-- 숫자 -->
                                                                        <c:forEach var="p2" begin="${ pi2.startPage }" end="${ pi2.endPage }">
                                                                            <c:if test="${ p2 eq pi2.currentPage }">
                                                                                <li class="page-item active">
                                                                                    <a class="page-link">${ p2 }</a>
                                                                                </li>
                                                                            </c:if>
                                                                            <c:if test="${ p2 ne pi2.currentPage }">
                                                                                <c:url var="pagination2" value="mrlist.mr">
                                                                                    <c:param name="page2" value="${ p2 }"/>
                                                                                </c:url>
                                                                                <li class="page-item">
                                                                                    <a class="page-link" href="${ pagination2 }">${ p2 }</a>
                                                                                </li>
                                                                            </c:if>
                                                                        </c:forEach>
                                                                        
                                                                        <!--  다음 -->
                                                                        <c:if test="${ pi2.currentPage >= pi2.maxPage }">
                                                                            <li class="page-item page-indicator disabled">
                                                                                <a class="page-link"><i class="icon-arrow-right"></i></a>
                                                                            </li>
                                                                        </c:if>
                                                                        <c:if test="${ pi2.currentPage < pi2.maxPage }">
                                                                            <c:url var="after2" value="mrlist.mr">
                                                                                <c:param name="page2" value="${ pi2.currentPage + 1 }"/>
                                                                            </c:url>
                                                                            <li class="page-item page-indicator">
                                                                                <a class="page-link" href="${ after2 }">
                                                                                    <i class="icon-arrow-right"></i>
                                                                                </a>
                                                                            </li>
                                                                        </c:if>
                                                                    </ul>
                                                                </nav>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <!-- 2st 탭 컨텐츠 페이징 끝 -->
                                                    <!-- 예약 관련 버튼 시작 -->
                                                    <tr>
                                                        <td colspan="6">
                                                            <c:if test="${ !empty loginUser }">
                                                            <div class="d-flex justify-content-end">
                                                                <button type="button" class="btn btn-outline-secondary mr-2" onclick="location.href='mrinsertview.mr'">예약 신청</button>
                                                                <c:if test="${ !list2.isEmpty() }">
                                                                    <button type="button" class="btn btn-outline-secondary mr-2" onclick="location.href='mrupdateview.mr'">예약 수정</button>
                                                                    <button type="button" class="btn btn-outline-secondary" onclick="location.href='mrdelete.mr'">예약 취소</button>
                                                                </c:if>
                                                            </div>
                                                            </c:if>
                                                        </td>
                                                    </tr>
                                                    <!-- 예약 관련 버튼 끝 -->
                                                </tfoot>
                                                
                                            </table>

                                        </div>
                                    </div>
                                    <!-- 2nd 탭 컨텐츠 끝 -->
                                    
                                </div>
                                <!-- 탭 컨텐츠 끝 -->
                                
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    
    <script>
    // 예약정보 세부 조회 연결 기능
    $(function() {
        $('#tb1 td').mouseenter(function() {
            $(this).parent().css({'font-weight':'bold', 'cursor':'pointer'});
        }).mouseout(function() {
            $(this).parent().css({'font-weight':'normal'});
        }).click(function() {
            var rNo = $(this).parent().children().eq(0).text();
            location.href="mrdetail.mr?revNo=" + rNo + "&page=" + ${ pi1.currentPage };
        });
    });
    
    $(function() {
        $('#tb2 td').mouseenter(function() {
            $(this).parent().css({'font-weight':'bold', 'cursor':'pointer'});
        }).mouseout(function() {
            $(this).parent().css({'font-weight':'normal'});
        }).click(function() {
            var rNo = $(this).parent().children().eq(0).text();
            loction.href="mrresrvupdate.mr?revNo=" + rNo + "&page=" + ${ pi2.currentPage };
        });
    });
    
    // 체크박스 기능
    $('#chkAll').click(function() {
        var chkAll = $(this).prop('checked');
        
        if(chkAll)
            $('.chk').prop('checked', true);
        else
            $('.chk').prop('checked', false);
    });
    
    $('.chk').click(function() {
        var chk = document.getElementsByClassName('chk');
        
        var chkAllSelect = true;
        for(var i in chk)
            if(chk[i].checked == false)
                chkAllSelect = false;
        
        if(chkAllSelect)
            $('#chkAll').prop('checked', true);
        else
            $('#chkAll').prop('checked', false);
    });
    </script>
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

</body>

</html>