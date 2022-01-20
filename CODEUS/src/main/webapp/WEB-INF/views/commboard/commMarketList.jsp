<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>중고장터</title>
<style type="text/css">
	th {
	 		 text-align: center;
	 		 font-size : 15px;
	 		 color: black;
	}
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
                               	<div id ="searchBox" class="col-sm-12">
					<!--정렬 -->
					<%--  <div>
				    	<select id="howAsc">
				    		<option value="recently">최신순</option>
				    		<option value="likes">추천순</option>
				    		<option value="myReview">내가 쓴 글만 보기</option>
				    	</select>
					<div id="review">
					</div>
				    </div>   
					<!-- 정렬  -->
					<!-- 검색 -->
						<div class="form-group row justify-content-center">
							<div class="w100">
									<select id="searchCondition" name="searchCondition" class="form-control form-control-sm">
										<option value="all"
											<c:if test="${search.searchCondition == 'all'}">selected</c:if>>전체</option>
										<option value="cosmetic"
											<c:if test="${search.searchCondition == 'cosmetic'}">selected</c:if>>의료/미용</option>
										<option value="electronic"
											<c:if test="${search.searchCondition == 'electronic'}">selected</c:if>>전자제품</option>
										<option value="culture"
											<c:if test="${search.searchCondition == 'PriceList'}">selected</c:if>>도서/티켓<option>
										<option value="etc"
											<c:if test="${search.searchCondition == 'etc'}">selected</c:if>>기타</option>
										</select> 
								</form>					
							</div>
							</div> --%>
						</div>
						<c:url var="getBoardListURL" value="/commboard/BoardList"></c:url>
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
                                <div class="table-responsive">
                                    <table class="table table-hover table-responsive-sm" style="color : black;">
                                    <thead>
                                        <tr>
							              <th>No</th>
							               <th>분류</th>
							              <th width="300">제목</th>
							              <th>작성자</th>
							              <th>작성일</th>
							              <th>조회수</th>
							          </tr>
							       </thead>
							        <tbody>
									<c:forEach var="mb" items="${ list }">
									<tr class="contentTR">
										<%-- <th "stylehight= 400px; width = 400px;">
										<c:forEach items="${attachList}" var="at">
												<div class="col partner-col text-center">
													<img src="${pageContext.request.contextPath}${at.path}${at.ReFileName}" class="img-fluid" alt="${at.OriFileName}">
												</div>
										</c:forEach>
										</th> --%>	
										<th align="center">${ mb.bId }</th>
										<th align="center">${ mb.mbCategory}</th>
										<th align="left">${ mb.mbTitle }</th>	
										<th align="center">${ mb.mbWriter }</th>
										<th align="center">${ mb.mbCreateDate }</th>
										<th align="center">${ mb.mbViews }</th>
										</tr>
											</c:forEach>
							    		</tbody>
									  </table>
									 </div> 
										<!-- 본문 테이블 영역  끝-->
											<!-- 페이징 처리 -->
											<div style="margin-left: auto; margin-right: auto;">
		                            				<nav>
		                                				<ul class="pagination pagination-xs pagination-circle">
												
													<!-- [이전] -->
													<c:if test="${ pi.currentPage <= 1 }">
													<li class="page-item page-indicator disabled">
		                                        	<a class="page-link">
		                                            		<i class="icon-arrow-left"></i></a>                                     
	                                  				</li>
													</c:if>
													<c:if test="${ pi.currentPage > 1 }">
														<c:url var="before" value="marketblist.bo">
															<c:param name="page" value="${ pi.currentPage - 1 }"/>
														</c:url>
														<li class="page-item page-indicator">
	                                        				<a class="page-link" href="${ before }">
	                                            			<i class="icon-arrow-left"></i></a>
	                                       				 </li> 	
													</c:if>
													
													<!-- 페이지 -->
													<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
														<c:if test="${ p eq pi.currentPage }">
																<li class="page-item active"><a class="page-link">${ p }</a></li>
														</c:if>
														
														<c:if test="${ p ne pi.currentPage }">
															<c:url var="pagination" value="marketblist.bo">
																<c:param name="page" value="${ p }"/>
															</c:url>
															<li class="page-item"><a class="page-link" href="${ pagination }">${ p }</a></li>
														</c:if>
													</c:forEach>
													
													<!-- [다음] -->
													<c:if test="${ pi.currentPage >= pi.maxPage }">
														<li class="page-item page-indicator disabled">
                                            				<a class="page-link">
                                                			<i class="icon-arrow-right"></i></a>
                                     					 </li>
													</c:if>
													<c:if test="${ pi.currentPage < pi.maxPage }">
														<c:url var="after" value="marketblist.bo">
															<c:param name="page" value="${ pi.currentPage + 1 }"/>
														</c:url> 
														<li class="page-item page-indicator">
                                            				<a class="page-link" href="${ after }">
                                                			<i class="icon-arrow-right"></i></a>
                                        				</li>
													</c:if>
													</ul>
			                                		</nav>
			                           				</div>
													</div>
													<p align="right">
													<button
								                  	 onclick="location.href='marketinsertView.bo';" class="btn btn-primary">글쓰기</button>		
													</p>
												</div>
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

				location.href = 'marketDetail.bo?bId=' + bId + "&page=" + ${pi.currentPage}
			});
		});
	</script>
	
	
	
<!--**********************************
          Content body end
***************************************-->
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