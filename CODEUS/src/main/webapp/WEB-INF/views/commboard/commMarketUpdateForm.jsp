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
    
    		label {
    			color : black;
    			align : center;
    		
    		}
    		
			#att_zone{
				width: 660px;
				min-height:150px;
				padding:10px;
			
			}
			#att_zone:empty:before{
				content : attr(data-placeholder);
				color : #999;
				font-size:.9em;
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
                        <div class="card-body">
						 <!-- 본문 시작 -->
					<div class="col-lg-12">
                        <div class="card">
                            <div class="card-header">
                            </div>
                            <div class="card-body">
                                <main class="e-approval-article">
									<h3 style="width: 200px; height: 30px;">중고게시판</h3>
									<!-- <p align="right">
										<button  type="button" 
						            		onclick="location.href='home.do'" class="btn btn-primary">홈으로</button>	
										<button  type="button" 
						           			 onclick="golist()" class="btn btn-primary">목록</button>
									</p> -->
									<div class='market-insert-form'>
									<form action = "marketinsert.bo" class="frm_market_insert" 
									name="frm_market_insert" method="post" enctype="multipart/form-data" onsubmit="return insert();">
										<div class="form-group row">
								   		 <label for="mbWriter" class="col-sm-2 col-form-label  is-invalid">작성자</label>
										    <div class="col-sm-8">
										      <input type="text" class="form-control "  name="mbWriter"required readonly value="${ mb.mbWriter }"> 
										    </div>
										  </div>
										<div class="form-group row">
								   		 <label for="mbTitle" class="col-sm-2 col-form-label  is-invalid">상품명</label>
										    <div class="col-sm-8">
										      <input type="text" class="form-control "  name="mbTitle" required value="${ mb.mbTitle }">
										    </div>
										  </div>
										  
										<div class="form-group row">
								   		 <label for="marketaCate" class="col-sm-2 col-form-label">카테고리</label>
										    <div class="col-sm-8">
						   					 <select class="form-control " name="Category"  required>
														<option value="all">카테고리</option>
														<option value="의류/미용">의류/미용</option>
														<option value="전자제품">전자제품</option>
														<option value="도서/티켓">도서/티켓</option>
														<option value="기타 중고물품">기타 중고물품</option>
													</select>				   
												</div>
										  </div>
										<div class="form-group row">
								   		 <label for="marketPrice" class="col-sm-2 col-form-label">판매가격</label>
										    <div class="col-sm-8" style="display : inline-block;">
										    	  <div style="display:flex;">
										    	  <input type="text" class="form-control" name="marketPrice" id="marketPrice" value="${ mb.marketPrice }" style="text-align : right;" required>
										    	  <span class="input-group-text">원</span>
										    	</div>
										    </div>
										  </div>
										<div class="form-group row">
											 <label for="inputPassword" class="col-sm-2 col-form-label">사진</label>
											  <div class="col-sm-8" style="display : inline-block;">
										   		<div class="custom-file">
												  <input type="file" class="custom-file-input" id="attList" name="attList" onchange="previewImage(this,'View_area')" multiple='multiple' >
												  <label class="custom-file-label" for="customFile">Choose file</label>
												</div>
												<div id='View_area' class='View_area' style="display:flex;" >
												<c:forEach items="${vo.attlist }" var="att">
													<div style="display:inline-block;position:relative;">
														<img src='images/market/${att.oriFile }' style="width:100px; height:100px;"/>
														<input type="button" value="X" onclick="delBtn(this)" style="position:absolute;border-width:0;right:5px;font-size:15px;color : white;opacity:0.3;background-color:grey;border-radius:10px;">
													</div>
												</c:forEach>
												</div>
												</div>
											</div>
										  <div class="form-group row">
								   		 <label for="mbContent" class="col-sm-2 col-form-label">내용</label>
										    <div class="col-sm-8">
										      <textarea class="form-control" id="mbContent" name = "mbContent" rows ="10"required>${ mb.mbContent }</textarea>
										    </div>
										  </div>
										<div class="market-btn-zone" align="center">
											<input class="btn btn-primary" type="submit"   id = 'btnSave' value="등록">
											<input class="btn btn-primary" type = 'button' value = '취소' onclick = "golist();">
										</div>
									</form>
									</div>
								</main>
							<br><br>
							
							<!-- 본문 끝-->
							
						
							<br><br>
							</div>
						</div>
					</div>
				</div>
			</div>
				</div>
					</div>
						</div>
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

            // Element에 style 한번에 오브젝트로 설정하는 함수 추가
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
					
		
		<c:if test="${ loginUser.mId eq 'admin' && b.bStatus eq '1'  }">
     		 
     		 <script language=javascript> 
     		 console.log('123');
     		 alert("이 게시물은 작성자 및 관리자에 의해 삭제된 게시물 입니다."); 
     		 history.go(-1); 
     		 </script>
     		 
      	</c:if>
      	
	<script>

	
	//사진미리보기//
	function previewImage(targetObj, View_area) {
		var preview = document.getElementById(View_area); //div id

			var files= targetObj.files;
			
			console.log("files.length:"+files.length);//한 번 들어갈 때 갯수
			
			var ele = document.getElementById('View_area');
			var eleCount = ele.childElementCount;		
			console.log("eleCount:"+eleCount);//총 갯수
			
			if(files.length<6 && files.length+eleCount<6){//사진제한 5개
		
			for ( var i = 0; i < files.length; i++) {
				var file = files[i];
				var imageType = /image.*/; //이미지 파일일경우만
				if (!file.type.match(imageType))
					continue;
				var prevImg = document.getElementById("prev_" + View_area); //이전에 미리보기가 있다면 삭제
		/*		if (prevImg) {
					preview.removeChild(prevImg);
				}*/

				var div = document.createElement("div");
				var style_div = "display:inline-block;position:relative;";
				div.setAttribute("style", style_div);
				var img = document.createElement("img"); 
				var delBtn = document.createElement("input");
				var style_delBtn = "position:absolute;border-width:0;right:5px;"
				+ "font-size:15px;color : white;opacity:0.3;background-color:grey;border-radius:10px;";
				delBtn.setAttribute("type", "button");
				delBtn.setAttribute("value", "X");
				delBtn.setAttribute("style", style_delBtn);
				delBtn.setAttribute("onclick", "delBtn(this)");
				img.id = "prev_"+ [i]; 
				img.classList.add("obj");
				img.file = file;
				img.style.width = '100px'; 
				img.style.height = '100px';
				
				preview.appendChild(div);
				div.appendChild(img);
				div.appendChild(delBtn);
				if (window.FileReader) { // FireFox, Chrome, Opera 확인.
					var reader = new FileReader();
					reader.onloadend = (function(aImg) {
						return function(e) {
							aImg.src = e.target.result;
						};
					})(img);
					reader.readAsDataURL(file);
					console.log(files[i]);
				} else {//에러확인
					if (!document.getElementById("sfr_preview_error_"
							+ View_area)) {
						var info = document.createElement("p");
						info.id = "sfr_preview_error_" + View_area;
						info.innerHTML = "not supported FileReader";
						preview.insertBefore(info, null);
					}
				}
			}
						console.log("eleCount:"+eleCount);//총 갯수
						if(eleCount>5) return;
			}
			else $('#PhotoAlertModal').modal("show"); //5개 이상일시 경고모달창
				
		}
				function delBtn(obj){
				console.log("눌림	");
				console.log(obj);
				var p = obj.parentNode; //이벤트가 발생한 태그\
				
				console.log(p);
				
				var View_area2 = document.getElementById("View_area");
				View_area2.removeChild(p);
			
			}
	
    
	//목록으로 버튼 입력시 alert창 띄운 후 확인누르면 목록으로(뒤로가기)
	function golist(){
		if(confirm("수정중이던 글은 저장되지 않습니다.\수정을 취소하시겠습니까?") == true){
            history.back();
        }
        else{}
	};
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
	