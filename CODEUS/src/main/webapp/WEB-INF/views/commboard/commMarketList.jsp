<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>중고장터</title>
<style type="text/css">
	#tb{margin: auto; width: 700px; border-collapse: collapse;}
	#tb tr td{padding: 5px;}
	#buttonTab{border-left: hidden; border-right: hidden;}
</style>
	<!-- Favicon icon -->
    <link rel="icon" type="image/png" sizes="16x16" href="./images/favicon.png">
    <!-- Datatable -->
    <link href="${contextPath}/resources/assets/vendor/datatables/css/jquery.dataTables.min.css" rel="stylesheet">
    <!-- Custom Stylesheet -->
    <link href="${contextPath}/resources/assets/css/style.css" rel="stylesheet">

</head>
<body>
	<c:import url="../member/menubar.jsp"/>
	
	     <!--**********************************
            Content body start
        ***********************************-->
         <div class="content-body">
            <div class="container-fluid">
                <div class="row page-titles mx-0">
                    <div class="col-sm-6 p-md-0">
                        <div class="welcome-text">
                            <h4>Hi, welcome back!</h4>
                            <span class="ml-1">Datatable</span>
                        </div>
                    </div>
                    <div class="col-sm-6 p-md-0 justify-content-sm-end mt-2 mt-sm-0 d-flex">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="javascript:void(0)">Table</a></li>
                            <li class="breadcrumb-item active"><a href="javascript:void(0)">Datatable</a></li>
                        </ol>
                    </div>
                </div>
	             <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">중고장터</h4>
                           </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                	<div id ="searchBox" class="col-sm-11 col-md-11 text-right">
	
						<!-- 검색 -->

							<div class="form-group row justify-content-center">
								<div class="w100" style="padding-right:10px">
								<form id="rightTop" class="form-inline" onsubmit="return false;">
									<select class="form-control form-control-sm" 
									name="searchType" id="searchType" onchange="location.href = this.value;">
									
										<option value="name"
								<c:if test="${searchType eq 'name'}">selected</c:if>>아이디</option>
							<option value="subject"
								<c:if test="${searchType eq 'subject'}">selected</c:if>>제목</option>
							<option value="content"
								<c:if test="${searchType eq 'content'}">selected</c:if>>내용</option>	
									</select>
								</form>	
								</div>
								<div class="w300" style="padding-right:10px">
									<input type="text" class="form-control form-control-sm" name="keyword" id="keyword">
								</div>
								<div>
									<button class="btn btn-sm btn-primary" name="btnSearch" id="btnSearch">검색</button>
								</div>
							</div>
						<c:url var="getBoardListURL" value="/commboard/commBoardList"></c:url>

		
					<script>
						$(document).on('click', '#btnSearch', function(e){
							e.preventDefault();
							var url = "${commBoardList}";   
							url = url + "?searchType=" + $('#searchType').val();
							url = url + "&keyword=" + $('#keyword').val();
							location.href = url;
							console.log(url);
					
						});	
					
					</script>
	
						<!-- 검색  -->

						<!-- 본문 테이블 영역   시작-->
	
					<div class="col-lg-12">
                        <div class="card">
                            	<div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-hover table-responsive-sm" style="color : black;">
                                        <thead>
                                        <tr>
							              <th>No</th>
							              <th width="300">제목</th>
							              <th>작성자</th>
							              <th>작성일</th>
							              <th>조회수</th>
							          </tr>
							       </thead>
							        <tbody>
									<c:forEach var="b" items="${ list }">
									<tr class="contentTR">
										<th align="center">${ b.bId }</th>
										<th align="left">${ b.bTitle }</th>	
										<th align="center">${ b.bWriter }</th>
										<th align="center">${ b.bCreateDate }</th>
										<th align="center">${ b.bViews }</th>
									</tr>
									</c:forEach>
							     </tbody>
									
									<tr  height="80">
									
										<td colspan="6" align="right" id="buttonTab">
												<button  type="button" 
							                                    onclick="location.href='CommboardinsertView.bo';" class="btn btn-primary">글쓰기</button>		
										</td>
									</tr>
							<!-- 본문 테이블 영역  끝-->
		
									<!-- 페이징 처리 -->
									<tr  align="center" height="20" id="buttonTab">
										<td colspan="6">
										
											<!-- [이전] -->
											<c:if test="${ pi.currentPage <= 1 }">
												[이전] &nbsp;
											</c:if>
											<c:if test="${ pi.currentPage > 1 }">
												<c:url var="before" value="Commblist.bo">
													<c:param name="page" value="${ pi.currentPage - 1 }"/>
												</c:url>
												<a href="${ before }">[이전]</a> &nbsp;
											</c:if>
											
											<!-- 페이지 -->
											<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
												<c:if test="${ p eq pi.currentPage }">
													<font color="red" size="4"><b>[${ p }]</b></font>
												</c:if>
												
												<c:if test="${ p ne pi.currentPage }">
													<c:url var="pagination" value="Commblist.bo">
														<c:param name="page" value="${ p }"/>
													</c:url>
													<a href="${ pagination }">${ p }</a> &nbsp;
												</c:if>
											</c:forEach>
											
											<!-- [다음] -->
											<c:if test="${ pi.currentPage >= pi.maxPage }">
												[다음]
											</c:if>
											<c:if test="${ pi.currentPage < pi.maxPage }">
												<c:url var="after" value="Commblist.bo">
													<c:param name="page" value="${ pi.currentPage + 1 }"/>
												</c:url> 
												<a href="${ after }">[다음]</a>
											</c:if>
										</td>
									</tr>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
		$(function() {
			$('.contentTR').click(function() {
				var bId = $(this).children("th").eq(0).text();

				location.href = 'CommBoardDetail.bo?bId=' + bId + "&page=" + ${pi.currentPage}
			});
		});
	</script>
     <!--**********************************
            Footer start
        ***********************************-->
        <div class="footer">
            <div class="copyright">
                <p>Copyright © Designed &amp; Developed by <a href="#" target="_blank">Quixkit</a> 2019</p>
            </div>
        </div>
        <!--**********************************
            Footer end
        ***********************************-->

        <!--**********************************
           Support ticket button start
        ***********************************-->

        <!--**********************************
           Support ticket button end
        ***********************************-->

        
    </div>
    <!--**********************************
        Main wrapper end
    ***********************************-->

   
<!--**********************************
        Scripts
    ***********************************-->
    <!-- Required vendors -->
    <script src="${contextPath}/resources/assets/vendor/global/global.min.js"></script>
    <script src="${contextPath}/resources/assets/js/quixnav-init.js"></script>
    <script src="${contextPath}/resources/assets/js/custom.min.js"></script>
    


    <!-- Datatable -->
    <script src="${contextPath}/resources/assets/vendor/datatables/js/jquery.dataTables.min.js"></script>
    <script src="${contextPath}/resources/assets/js/plugins-init/datatables.init.js"></script>

</body>

</html>