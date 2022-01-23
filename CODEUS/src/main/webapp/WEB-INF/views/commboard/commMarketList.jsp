<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>중고장터</title>
<style type="text/css">
	th, td {
	 		 text-align: center;
	 		 font-size : 15px;
	 		 color: black;
	}
	div > p {color : black;
			 font-size : 15px;}
	div > a {color : black;}
	
	li > a {color : black;
			font-size : 20x;}
	
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

		<c:import url="../common/menubar.jsp" />

		<!--**********************************
          Content body start
    ***********************************-->
		<div class="content-body">
			<div class="container-fluid">
				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-header">
								<h4 class="card-title">중고장터</h4>
							</div>
							<div class="card-body">
								<div class="table-responsive">
									<div id="searchBox" class="col-sm-12">
										<!--정렬 -->
										<div id="select_tap" style="float: right; color: black;">
											<ul>
												<li><a href="#" id="a1" class="select_btn">최신순&nbsp;</a>|
													<a href="#" id="a3" class="select_btn">&nbsp;낮은가격순&nbsp;</a>|
													<a href="#" id="a4" class="select_btn">&nbsp;높은가격순</a></li>
											</ul>
										</div>
										<!--  검색 영역 -->
										<div id="searchArea" align="center" class="form-group">
											<div class="w100" style="padding-right: 10px">
												<form action="marketSearch.bo" method="get"
													class="form-inline">
													<select id="searchCondition" name="searchCondition"
														class="form-control form-control-sm">
														<option value="all"
															<c:if test="${search.searchCondition == 'all'}">selected</c:if>>전체</option>
														<option value="bTitle"
															<c:if test="${search.searchCondition == 'bTitle'}">selected</c:if>>제품명</option>
														<option value="bContent"
															<c:if test="${search.searchCondition == 'bContent'}">selected</c:if>>제품내용</option>
													</select> <input type="text" name="searchValue"
														class="form-control form-control-sm"
														value="${search.searchValue }"> <input
														type="submit" value="검색" class="btn btn-sm btn-primary">
												</form>
											</div>
										</div>
									</div>
									<c:forEach var="mb" items="${ list }">
									<a href="marketDetail.bo?bId=${mb.bId}&page=${pi.currentPage}">
									<ul>
										<li style="float: left; padding: 20px; display: inline-block; white-space: nowrap;" >
											<div class="row" style="">
												<div class="col-xl-4 col-xxl-6 col-lg-6 col-sm-6"
													style="float: left; padding: 20px; display: inline-block;">
													<div class="card" 
														style="float: left; padding: 20px; display: inline-block;">
														<div class="card-header">
															<c:forEach var="att" items="${attList}">
																<c:if test="${ mb.bId eq att.bId }">
																	<div id="file${ att.fileNo}" class="file">
																		<img id="img${ att.fileNo }"
																			src="${contextPath}/resources/buploadFiles/${ att.reFileName }"
																			width="300" height="300" download><br>
																	</div>
																</c:if>
															</c:forEach>
														</div>
														<div class="card-body">
															<p class="card-title" style="font-size : 20px; text-align: center;"><b>${ mb.mbTitle }</b></p>
														</div>
														<div class="card-footer">
															<p class="card-text d-inline">${ mb.marketPrice }원</p>
															<p class="card-link float-right">
																<img
																	src='${contextPath}/resources/assets/images/views.png'>&nbsp;
																&nbsp;${ mb.mbViews }
															</p>
														</div>
													</div>
												</div>
											</div>
										</li>
									</ul>
								</a>
							</c:forEach>
						</div>
						</div>
								<br>
								<br>
								<table>
								<c:if test="${ empty nbList && searchValue ne null }">
									<tr>
										<td colspan="9">검색 결과가 없습니다.</td>
									</tr>
								</c:if>
								<c:if test="${ empty list }">
									<tr>
										<td colspan="6">등록된 게시물이 없습니다.</td>
									</tr>
								</c:if>
							</table>
							<br> <br>

							<!-- 검색  -->
							<div class="table-responsive">
								<div class="col-lg-12">
									<div class="card">
										<!-- 본문 테이블 영역  끝--> 
													<!-- 페이징 처리 -->
													<div style="margin-left: auto; margin-right: auto;">
														<nav>
															<ul class="pagination pagination-xs pagination-circle">

																<!-- searchValue가 있으면 검색 Servlet으로, 있으면 게시판 조회 servlet으로 넘김 -->
																<c:if test="${ searchValue eq null }">
																	<c:set var="loc" value="/marketblist.bo" scope="page" />
																</c:if>
																<c:if test="${ searchValue ne null }">
																	<c:set var="loc" value="/marketSearch.bo" scope="page" />
																</c:if>
																<!-- [이전] -->
																<c:if test="${ pi.currentPage <= 1 }">
																	<li class="page-item page-indicator disabled"><a
																		class="page-link"> <i class="icon-arrow-left"></i></a>
																	</li>
																</c:if>
																<c:if test="${ pi.currentPage > 1 }">
																	<c:url var="before" value="${ loc }">
																		<c:if test="${ search.searchValue ne null }">
																			<c:param name="searchCondition"
																				value="${ search.searchCondition }" />
																			<c:param name="searchValue"
																				value="${ search.searchValue }" />
																		</c:if>
																		<c:param name="page" value="${ pi.currentPage - 1 }" />
																	</c:url>
																	<li class="page-item page-indicator"><a
																		class="page-link" href="${ before }"> <i
																			class="icon-arrow-left"></i></a></li>
																</c:if>
																<!-- 페이지 숫자 -->
																<c:forEach var="p" begin="${ pi.startPage }"
																	end="${ pi.endPage }">
																	<c:if test="${ p eq pi.currentPage }">
																		<li class="page-item active"><a class="page-link">${ p }</a></li>
																	</c:if>

																	<c:if test="${ p ne pi.currentPage }">
																		<c:url var="pagination" value="${ loc }">
																			<c:if test="${ searchValue ne null }">
																				<!--  이전, 다음, 번호 등 페이지를 눌렀을 때 검색 조건을 유지시키기 위해 검색 옵션과 검색어를 가져옴 -->
																				<c:param name="searchCondition"
																					value="${ searchCondition }" />
																				<c:param name="searchValue" value="${ searchValue }" />
																			</c:if>
																			<c:param name="page" value="${ p }" />
																		</c:url>
																		<li class="page-item"><a class="page-link"
																			href="${ pagination }">${ p }</a></li>
																	</c:if>
																</c:forEach>
																<!-- [다음] -->
																<c:if test="${ pi.currentPage >= pi.maxPage }">
																	<li class="page-item page-indicator disabled"><a
																		class="page-link"> <i class="icon-arrow-right"></i></a>
																	</li>
																</c:if>
																<c:if test="${ pi.currentPage < pi.maxPage }">
																	<c:url var="after" value="${ loc }">
																		<c:if test="${searchValue ne null }">
																			<!--  이전, 다음, 번호 등 페이지를 눌렀을 때 검색 조건을 유지시키기 위해 검색 옵션과 검색어를 가져옴 -->
																			<c:param name="searchCondition"
																				value="${ searchCondition }" />
																			<c:param name="searchValue" value="${ searchValue }" />
																		</c:if>
																		<c:param name="page" value="${ pi.currentPage + 1 }" />
																	</c:url>
																	<li class="page-item page-indicator"><a
																		class="page-link" href="${ after }"> <i
																			class="icon-arrow-right"></i></a></li>
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
								<button type="button"
									onclick="location.href='marketinsertView.bo';"
									class="btn btn-primary">글쓰기</button>
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>

		<script>
	var searchText;
	var searchOption;
	var option;
		$('#a1').click(function(){
			option = 'new';
			location.href = 'marketSort.bo?option=' + option;
		});
		
		$('#a3').click(function(){
			option = 'lowprice';
			location.href = 'marketSort.bo?option=' + option;
		});
		
		$('#a4').click(function(){
			option = 'highprice';
			location.href = 'marketSort.bo?option=' + option;
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
				<p>
					Copyright © Designed &amp; Developed by <a href="#" target="_blank">Quixkit</a>
					2019
				</p>
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
	<!--**********************************
     Main wrapper end
 ***********************************-->

<!--**********************************
        Scripts
    ***********************************-->
    
  </body>
  </html>  
    
