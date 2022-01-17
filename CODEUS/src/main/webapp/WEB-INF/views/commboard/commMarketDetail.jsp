<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>중고게시판</title>
<!--file CDN -->
<link href="https://cdn.jsdelivr.net/npm/bs-custom-file-input/dist/bs-custom-file-input.min.js">
<style type="text/css">
	#boardDetailTable{width: 800px; margin: auto; border-collapse: collapse; border-left: hidden; border-right: hidden;}
	#boardDetailTable tr td{padding: 5px;}
	
	.replyTable{margin:auto; width: 500px;}
	
            #my_modal {
                display: none;
                width: 300px;
                padding: 20px 60px;
                background-color: #fefefe;
                border: 1px solid #888;
                border-radius: 3px;
            }

            #my_modal .modal_close_btn {
                position: absolute;
                top: 10px;
                right: 10px;
            }
            
            li > a{
            color : black;
            }
            
	         #marketDetail th, td {
	 		 text-align: center;
	 		 font-size : 15px;
	 		 color: black;
	}
    
</style>
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
   
      <c:if test="${mb.mbStatus eq '0'}">    
       
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

							<!-- 본문 시작 -->
		<div class="col-lg-12">
			<div class="card">
				 <div class="card-body">
				     <main class="e-approval-article">
					    <div class="form-group-container">	
							<form name="frm_market_view" method="get">
							<!-- 마켓 번호 -->
							<input type="hidden" class="form-control" id="bId" name="bId" value="${mb.bId}">
							<div class="card-body">
                             		<div class="table-responsive">
                             		<div class="market-btn-zone" align="right">
								</div>
                                <table id ="marketDetail" class="table table-responsive-sm">
							<tr>
							<td rowspan="7" height ="400" width ="400">
							
								<c:forEach items="${at}" var="at">
									<div class="col partner-col text-center">
										<img src="${pageContext.request.contextPath}${at.path}${at.ReFileName}" class="img-fluid" alt="${at.OriFileName}">
									</div>
								</c:forEach></td>
							
							  <c:url var="mupView" value="mupView.bo">
							<c:param name="bId" value="${ mb.bId }"/>
							<c:param name="page" value="${ page }"/>
						</c:url>
						<c:url var="bDelete" value="mbdelete.bo">
								<c:param name="bId" value="${mb.bId}"></c:param>
								<c:param name="fileName" value="${mb.renameFileName }"></c:param>
						</c:url>
							  	<tr>
								  	<td>
									<h3>${ mb.mbTitle }</h3>
									</td>
									<td>
										 <c:if test="${ loginUser.mId ne mb.mbWriter || loginUser.mId eq 'admin' }">   
											 <p align="right">
											  <span  type="button"  id="popup_open_btn" id="report">
											  <img class='fit-picture' 
											  src='${contextPath}/resources/assets/images/1224162.png' alt=''>
											  	신 &nbsp; 고</span>	
								            <p>
								       </c:if> 
									</td>
									<td rowpan='3'>
	  							</td>
									
								</tr>
								<tr>
									<td>가격</td>
									<td>${ mb.marketPrice }원</td>
								</tr>
								
								<tr>
									<th>작성날짜</th>
									<td>${ mb.mbCreateDate }</td>
								</tr>
								
							    <tr>
								<th>작성자</th>
								<td>${ mb.mbWriter }</td>
								</tr>
								
								<tr>
								<th>조회수</th>
								<td>${ mb.mbViews }</td>
								</tr>
								<tr>
								</tr>
								<tr>
								<p align="right">
									<button type="button" class="btn btn-primary" onclick="location.href='${ mupView }'">수정</button>
									<button type="button" class="btn btn-primary" onclick="location.href='${ mDelete }'">삭제</button>
								</p>
								<td>
                                        <button type="button" class="btn btn-warning">Add to wishlist <span
                                        class="btn-icon-right"><i class="fa fa-star"></i></span>
                                		</button>&nbsp&nbsp
                                		<button type="button" class="btn  btn-square btn-secondary">연락하기</button>
								</td>
								
								</tr>
													  
								</table>
								<!-- 하단 영역 -->
								<div class="row">
			                    <div class="col-md-20">
			                        <div class="card">
			                            <div class="card-body" style="width: 80rem;">
			                                <!-- Nav tabs -->
			                                <div class="default-tab">
			                                    <ul class="nav nav-tabs" role="tablist">
			                                        <li class="nav-item">
			                                            <a class="nav-link active" data-toggle="tab" href="#home">상품 내용</a>
			                                        </li>
			                                        <li class="nav-item">
			                                            <a class="nav-link" data-toggle="tab" href="#profile">상품 문의</a>
			                                        </li>
			                                    </ul>
			                                    <div class="tab-content">
			                                        <div class="tab-pane fade show active" id="home" role="tabpanel">
			                                            <div class="pt-4">
			                                           		<div class="card-body">
			                                                <p style="color:black">${mb.mbContent} </p>
															</div>
			                                           </div>
			                                        </div>
			                                        <div class="tab-pane fade" id="profile">
			                                            <div class="pt-4">
			                                                <div class="card-body">
												            <!-- 댓글 영역 -->
																<jsp:include page="MarketReply.jsp"></jsp:include>
																<!--댓글영역 끝 -->
				                                                </div>
				                                            </div>
				                                        </div>
				                                    </div>
				                                </div>
				                            </div>
				                        </div>
			                    	</div>
			                 	 </div>
			              	  </div>
			              </div> 
		            </form>    
				 </div>
			</main>
				</div>
					</div>
						</div>
							</div>
								</div>
									</div>
									</c:if>
		<c:if test="${ loginUser.mId eq 'admin' && b.bStatus eq '1'  }">
     		 
     		 <script language=javascript> 
     		 console.log('123');
     		 alert("이 게시물은 작성자 및 관리자에 의해 삭제된 게시물 입니다."); 
     		 history.go(-1); 
     		 </script>
     		 
      	</c:if>
	
	
	
		 		
<br><br>
			<!-- 본문 끝-->
<br><br>
			<p align="center">
				<button  type="button" 
		            onclick="location.href='home.do'" class="btn btn-primary">홈으로</button>	
				<button  type="button" 
		            onclick="location.href='marketblist.bo'" class="btn btn-primary">목록</button>
			</p>
				<!-- 신고 모달 창 -->
							<div id="my_modal">
							<form id="postReportForm">
							<br><br><br>
								<h3 align="center" style="color: black">게시글 신고</h3>
							<hr>
								<div class="row">
								<!-- 신고한 회원번호  -->
								<input type="hidden" class="form-control" id="mId" name="mId" value="${sessionScope.loginUser.mId}"> 
								<!-- 신고된 게시글 번호 -->
								<input type="hidden" class="form-control" id="bId" name="bId" value="${mb.bId}">
								<!-- 신고된 회원번호   -->
								<input type="hidden" class="form-control" id="reportmId" name="reportmId" value="${mb.mbWriter}">
								</div> 
							
								<div class="modal_report_div">
								 <input type="radio" id="reportChoice1" class="reportChoice"
								 name="preport" value="A">&nbsp; <label for="radio-1" style="color: black" 
									class="modal_choise_label">부적절한 내용을 포함</label> <br> 
								  <input type="radio" id="reportChoice1" class="reportChoice"
								 name="preport" value="B">&nbsp; <label for="radio-2" style="color: black" align="center"
									class="modal_choise_label">광고성 내용을 포함</label>
							</div>
							<A id="btncancel" class="modal_close_btn">닫기</A>
						
							<div>
								<hr>
								<p  style="font-size: 12px; color: black">* 신고 내용은 관리자 검토 후 내부정책에 삭제 처리가 진행됩니다. </p>
								<p align="center">
								<button type="button" id="btnreport" class="btn btn-primary" >신 &nbsp; 고</button>
								</p>
							</div>
						</form>
						<br><br>
						
					</div>
					<!-- 신고 모달창 -->
		
     <script>
         function modal(id) {
             var zIndex = 9999;
             var modal = document.getElementById(id);

             // 모달 div 뒤에 희끄무레한 레이어
             var bg = document.createElement('div');
             bg.setStyle({
                 position: 'fixed',
                 zIndex: zIndex,
                 left: '0px',
                 top: '0px',
                 width: '100%',
                 height: '100%',
                 overflow: 'auto',
                 // 레이어 색갈은 여기서 바꾸면 됨
                 backgroundColor: 'rgba(0,0,0,0.8)'
             });
             document.body.append(bg);

             // 닫기 버튼 처리, 시꺼먼 레이어와 모달 div 지우기
             modal.querySelector('.modal_close_btn').addEventListener('click', function() {
                 bg.remove();
                 modal.style.display = 'none';
             });

             modal.setStyle({
                 position: 'fixed',
                 display: 'block',
                 boxShadow: '0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)',

                 // 레이어 보다 한칸 위에 보이기
                 zIndex: zIndex + 1,

                 // div center 정렬
                 top: '50%',
                 left: '50%',
                 transform: 'translate(-50%, -50%)',
                 msTransform: 'translate(-50%, -50%)',
                 webkitTransform: 'translate(-50%, -50%)'
             });
         }

         // Element 에 style 한번에 오브젝트로 설정하는 함수 추가
         Element.prototype.setStyle = function(styles) {
             for (var k in styles) this.style[k] = styles[k];
             return this;
         };

         document.getElementById('popup_open_btn').addEventListener('click', function() {
             // 모달창 띄우기
             modal('my_modal');
         });
     </script>
     
     <script>
	        
        $("#btnreport").on("click", function() {

     	 if(!confirm('정말로 신고하시겠습니까?')) return;
     		
     	 var bg = null;
     	   var modal = null;
   
         $.ajax({
            url : "reportCommPost.bo",
            type : "post",
            data : $("#postReportForm").serialize(),
         	dataType : "json",
            success : function(data) {
	        	   if(data == 'success'){
		        	  	 alert("신고되었습니다. 관리자 확인 후 처리 됩니다.");
		        	   }else if(data == 'fail'){
		        		   alert('이미 신고된 댓글 입니다.');               
               }
               bg.remove();
               modal.style.display = 'none';
               
            }
         });
      });
        </script>
					        

<!-- 모달 창 -->

      	
      
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

    
   <!-- Tree Viewer JS
	============================================ -->
<!-- 	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.min.js"></script> -->


<!-- <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script> -->

	<script src="${contextPath}/resources/assets/vendor/deptList/js/jquery.cookie.js"></script>
	<script src="${contextPath}/resources/assets/vendor/deptList/js/jquery.treeview.js" type="text/javascript"></script>
	<script src="${contextPath}/resources/assets/vendor/deptList/js/jquery.treeview.edit.js" type="text/javascript"></script>
	<script src="${contextPath}/resources/assets/vendor/deptList/js/jquery.treeview.async.js" type="text/javascript"></script>
	
	<!-- drag and drop 관련 js -->
	<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
</body>

</html>
	