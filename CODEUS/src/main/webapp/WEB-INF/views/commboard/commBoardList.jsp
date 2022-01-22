<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판</title>
<style type="text/css">
	
	#buttonTab{border-left: hidden; border-right: hidden;}
	
	
	th, td {
	 		 text-align: center;
	 		 font-size : 15px;
	 		 color: black;
	}

	
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
     <div class="row">
           <div class="col-12">
               <div class="card">
                   <div class="card-header">
                       <h4 class="card-title">자유게시판</h4>
                  </div>
                   <div class="card-body">
                       <div class="table-responsive">
                       	<div id ="searchBox" class="col-sm-11 col-md-11 text-right">
	
						<!--  검색 영역 -->
									
						<div id="searchArea" align="center" class="form-group row justify-content-center">
							<div class="w100" style="padding-right:10px">
							<form action="commBoardSearch.bo" method="get" class="form-inline">
								<select id="searchCondition" name="searchCondition" class="form-control form-control-sm">
									<option value="all"
										<c:if test="${search.searchCondition == 'all'}">selected</c:if>>전체</option>
									<option value="bTitle"
										<c:if test="${search.searchCondition == 'bTitle'}">selected</c:if>>제목</option>
									<option value="bContent"
										<c:if test="${search.searchCondition == 'bContent'}">selected</c:if>>내용</option>
								</select> 
								<input type="text" name="searchValue" class="form-control form-control-sm" value="${search.searchValue }"> 
									<input type="submit" value="검색" class="btn btn-sm btn-primary">
							</form>					
							</div>
						</div>	
					<!-- 검색 영역  -->
					<!-- 본문 테이블 영역  -->

					<div class="col-lg-12">
                        <div class="card">
                            	<div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-hover table-responsive-sm" style="color : black;">
                                        <thead>
                                        <tr>
							              <th width="10%">No</th>
							              <th  width="30%">제목</th>
							              <th>작성자</th>
							              <th>작성일</th>
							              <th>조회수</th>
							          </tr>
							       </thead>
							        <tbody>
									<c:forEach var="b" items="${ list }">
									<c:url var="commdetail" value="CommBoardDetail.bo">
									<c:param name="nId" value="${ n.nId }"/>
											<c:param name="page" value="${ pi.currentPage }"/>
											<c:param name="searchCondition" value="${ search.searchCondition }"/>
											<c:param name="searchValue" value="${ search.searchValue }"/>
									</c:url>
									
									<tr class="contentTR">
										<th align="center">${ b.bId }</th>
										<th align="left">${ b.bTitle }</th>	
										<th align="center">${ b.bWriter }</th>
										<th align="center">${ b.bCreateDate }</th>
										<th align="center">${ b.bViews }</th>
									</tr>
								</c:forEach>
					    				<tbody>
                              				<c:if test="${ empty list }"><tr>
                                				<td colspan="6">등록된 게시물이 없습니다.</td>
                                				</tr>
						        			</c:if>
										  </table>
										 </div> 
						  			
								<!-- 본문 테이블 영역  끝-->
										<!-- 페이징 처리 -->
												<div style="margin-left: auto; margin-right: auto;">
		                            				<nav>
		                                				<ul class="pagination pagination-xs pagination-circle">
														
															<!-- 페이징 처리 -->
												<div style="margin-left: auto; margin-right: auto;">
		                            				<nav>
		                                				<ul class="pagination pagination-xs pagination-circle">
														
															<!-- searchValue가 있으면 검색 Servlet으로, 있으면 게시판 조회 servlet으로 넘김 -->
												         	<c:if test="${ searchValue eq null }">
												         		<c:set var="loc" value="/Commblist.bo" scope="page"/>
												         	</c:if>
												         	<c:if test="${ searchValue ne null }">
												         		<c:set var="loc" value="/commBoardSearch.bo" scope="page"/>
												         	</c:if>
															<!-- [이전] -->
															<c:if test="${ pi.currentPage <= 1 }">
															<li class="page-item page-indicator disabled">
					                                        	<a class="page-link">
					                                            	<i class="icon-arrow-left"></i></a>                                     
					                                  				</li>
															</c:if>
															<c:if test="${ pi.currentPage > 1 }">
																<c:url var="before" value="${ loc }">
																<c:if test="${ search.searchValue ne null }">
																	<c:param name="searchCondition" value="${ search.searchCondition }"/>
																	<c:param name="searchValue" value="${ search.searchValue }"/>
																</c:if>
																	<c:param name="page" value="${ pi.currentPage - 1 }"/>
																</c:url>
																<li class="page-item page-indicator">
			                                        				<a class="page-link" href="${ before }">
			                                            		<i class="icon-arrow-left"></i></a>
			                                       				 </li> 	
															</c:if>
															<!-- 페이지 숫자 -->
															<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
																<c:if test="${ p eq pi.currentPage }">
																	<li class="page-item active"><a class="page-link">${ p }</a></li>
																</c:if>
																
																<c:if test="${ p ne pi.currentPage }">
																	<c:url var="pagination" value="${ loc }">
																		<c:if test="${ searchValue ne null }">
													         				<!--  이전, 다음, 번호 등 페이지를 눌렀을 때 검색 조건을 유지시키기 위해 검색 옵션과 검색어를 가져옴 -->
													         				<c:param name="searchCondition" value="${ searchCondition }"/>
													         				<c:param name="searchValue" value="${ searchValue }"/>
													         			</c:if>
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
																<c:url var="after" value="${ loc }">
																		<c:if test="${searchValue ne null }">
													         				<!--  이전, 다음, 번호 등 페이지를 눌렀을 때 검색 조건을 유지시키기 위해 검색 옵션과 검색어를 가져옴 -->
													         				<c:param name="searchCondition" value="${ searchCondition }"/>
													         				<c:param name="searchValue" value="${ searchValue }"/>
														         		</c:if>
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
			                           					<!-- 페이징 영역 끝 -->
			                        			</div>
											</div>
			               				</div>
				                	</div>
				               	<p align="right">
									<button  type="button" 
				                  	onclick="location.href='CommboardinsertView.bo';" class="btn btn-primary">글쓰기</button>		
								</p>
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
				console.log(bId);
				location.href = 'CommBoardDetail.bo?bId=' + bId + "&page=" + ${pi.currentPage}
			});
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
                <p>Copyright © Designed &amp; Developed by <a href="${contextPath}/home.do" target="_blank">CODEUS</a> 2021</p>
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