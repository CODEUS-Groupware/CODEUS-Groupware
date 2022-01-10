<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>중고 게시판</title>
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
    
</style>
</head>
<body>
	<c:import url="../member/menubar.jsp"/>
	
	
	
	 <!--**********************************
            Content body start
        ***********************************-->
       <c:if test="${b.bStatus eq '0'}">    
        
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
		                                <h4 class="card-title">게시판</h4>
		                           </div>
		                            <div class="card-body">
			 							<button  type="button" 
		                                    id="bookmark" class="btn btn-primary">BOOKMARK</button>	
		                                
		                                    
		                                 <c:if test="${ loginUser.mId ne b.bWriter || loginUser.mId eq 'admin' }">   
										  <button  type="button"  id="popup_open_btn"
							                                   class="btn btn-primary" id="report">REPORT</button>	
							                                   
							              </c:if>                     
							                                   
								 <!-- 본문 시작 -->
							<div class="col-lg-12">
		                        <div class="card">
		                            <div class="card-header">
		                            </div>
		                            <div class="card-body">
		                                <main class="e-approval-article">
					<h3 style="width: 200px; height: 30px;">중고게시판</h3>
				
				
					<div class='market-insert-form'>
					<form action = "/marketInsertR?dibUser=${member.memberName }" class="frm_market_insert" name="frm_market_insert" method="post"enctype="multipart/form-data" >
						<div class="form-group row">
				   		 <label for="marketWriter" class="col-sm-2 col-form-label  is-invalid">작성자</label>
						    <div class="col-sm-8">
						      <input type="text" class="form-control "  name="marketWriter"required readonly value="${member.memberName }"> 
						    </div>
						  </div>
						<div class="form-group row">
				   		 <label for="marketName" class="col-sm-2 col-form-label  is-invalid">상품명</label>
						    <div class="col-sm-8">
						      <input type="text" class="form-control "  name="marketSubject"required >
						    </div>
						  </div>
						  
						<div class="form-group row">
				   		 <label for="marketaCate" class="col-sm-2 col-form-label">카테고리</label>
						    <div class="col-sm-8">
		   					 <select class="form-control " name="marketCategory"  required>
										<option value="">카테고리</option>
										<option value="뷰티/미용">뷰티/미용</option>
										<option value="식품">식품</option>
										<option value="의류">의류</option>
										<option value="전자제품">전자제품</option>
										<option value="도서/티켓">도서/티켓</option>
										<option value="기타 중고물품">기타 중고물품</option>
									</select>				    </div>
						  </div>
						  
							<div class="form-group row">
				   		 <label for="marketPrice" class="col-sm-2 col-form-label">판매가격</label>
						    <div class="col-sm-8" style="display : inline-block;">
						    	  <div style="display:flex;">
						    	  <input type="text" class="form-control" name="marketPrice" id="marketPrice" value="0" onkeyup="numberWithCommas(this.value)" style="text-align : right;" required>
						    	  <span class="input-group-text">원</span>
						    
						    	</div>
						    </div>
						  </div>
						
						
						<div class="form-group row">
						 <label for="inputPassword" class="col-sm-2 col-form-label">사진</label>
						  <div class="col-sm-8" style="display : inline-block;">
					   		<div class="custom-file">
							  <input type="file" class="custom-file-input" id="attList" name="attList" onchange="previewImage(this,'View_area')" multiple='multiple' required>
							  <label class="custom-file-label" for="customFile">최대 5장 첨부가능</label>
							</div>
							<div id='View_area' class='View_area' style="display:flex;" >
							</div>
							</div>
						</div>
		
		
						  <div class="form-group row">
				   		 <label for="marketDoc" class="col-sm-2 col-form-label">내용</label>
						    <div class="col-sm-8">
						      <textarea class="form-control" id="marketDoc" name = "marketDoc" rows ="10"required></textarea>
						    </div>
						  </div>
						  
						<div class="market-btn-zone">
							<input class="btn btn-primary" type="submit"   id = 'btnSave' value="등록">
							<input class="btn btn-primary" type = 'button' value = '취소' onclick = "goBack();">
						</div>
						<!-- hidden -->
						<input type="hidden" name="marketHit" value = "0">
						<input type="hidden" name="marketDib" value = "0">
		<%-- 				<input type="hidden" name="marketWriter" value = "${member.member식Name }"> --%>
					</form>
					</div>
		
		
					<!-- ========== -->
		
				</main>
	
							<br><br>
							
							<!-- 본문 끝-->
							
						
							<br><br>
	
							<p align="center">
								<button  type="button" 
						            onclick="location.href='home.do'" class="btn btn-primary">홈으로</button>	
								<button  type="button" 
						            onclick="location.href='Commblist.bo'" class="btn btn-primary">목록</button>
							</p>
	
	
				
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
					       
					        
							<!-- 모달 창 -->
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
	