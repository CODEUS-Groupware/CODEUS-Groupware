<%@ page language="java" contentType="text/html; charset=UTF-8"
	    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>중고 게시판 </title>


<!-- Favicon icon -->
<link rel="icon" type="image/png" sizes="16x16" href="./images/favicon.png">
<!-- Datatable -->
<link href="${contextPath}/resources/assets/vendor/datatables/css/jquery.dataTables.min.css" rel="stylesheet">
<!-- Custom Stylesheet -->
<link href="${contextPath}/resources/assets/css/style.css" rel="stylesheet">
    
<!-- include libraries(jQuery, bootstrap) -->
<!-- include libraries(jQuery, bootstrap) -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>

<script>
    $(document).ready(function () {
        //여기 아래 부분
        $('#summernote').summernote({
            height: 400,                     // 에디터 높이
            minHeight: 400,                      // 최소 높이
            maxHeight: 400,                      // 최대 높이
            focus: false,                       // 에디터 로딩후 포커스를 맞출지 여부
            lang: "ko-KR",                  // 한글 설정
            placeholder: '내용을 입력해주세요.',   //placeholder 설정
            codemirror: { // codemirror options
                theme: 'monokai'
            },
            /*   callbacks: {	//여기 부분이 이미지를 첨부하는 부분
                     onImageUpload : function(files) {
                         uploadSummernoteImageFile(files[0],this);
                     }
                 }, */
            toolbar: [
                // [groupName, [list of button]]
                ['fontname', ['fontname']],
                ['fontsize', ['fontsize']],
                ['style', ['bold', 'italic', 'underline', 'strikethrough', 'clear']],
                ['color', ['color']],
                ['table', ['table']],
                ['para', ['ul', 'ol', 'paragraph']],
                ['height', ['height']],
                ['insert', ['picture', 'link', 'video']],
                ['view', ['fullscreen', 'help']]
            ],
            fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New', '맑은 고딕', '궁서', '굴림체', '굴림', '돋음체', '바탕체'],
            fontSizes: ['8', '9', '10', '11', '12', '14', '16', '18', '20', '22', '24', '28', '30', '36', '50', '72']
        });
    });
    /**
    * 이미지 파일 업로드
    */
    function uploadSummernoteImageFile(file, editor) {
        data = new FormData();
        data.append("file", file);
        $.ajax({
            data: data,
            type: "POST",
            url: "/uploadmaeketImageFile",
            contentType: false,
            processData: false,
            success: function (data) {
                //항상 업로드된 파일의 url이 있어야 한다.
                $(editor).summernote('insertImage', data.url);
            }
        });
    }

</script>

  <script>
      //서머노트에 text 쓰기
      $('#summernote').summernote('insertText');
      // 서머노트 쓰기 활성화
      $('#summernote').summernote('enable');
      // 서머노트 리셋
      $('#summernote').summernote('reset');
      // 마지막으로 한 행동 취소 ( 뒤로가기 )
      $('#summernote').summernote('undo');
      // 앞으로가기
      $('#summernote').summernote('redo');
  </script>

<script>

// 파일 선택 시 이미지 불러오기
function loadImg(img, num){
	if(img.files && img.files[0]) {
		
		var reader = new FileReader();
		
		reader.onload = function(e){
			
			$($('#imageTag'+num)).attr('src', e.target.result);
		}
		reader.readAsDataURL(img.files[0]);
		// 파일을 불러왔으면 태그 추가
		// $('.imageArea').parent().append($($imageTag).clone(true));
		
		if( num == 0 ) {
			if($($('#imageTag1')).attr('src') == undefined) {
				$('#image1').append('<img id="imageTag'+fileIndex+'" width="200" height="267" class="img-rounded" onclick="clickFile('+fileIndex+');">')
				$('#imageFile'+num).parent().append('<input type="file" name="imageFile" id="imageFile'+fileIndex+'" onchange="loadImg(this, '+fileIndex+')"/>');
			}
		} else {
			$('#imageTag'+num).parent().append('&nbsp;<img id="imageTag'+fileIndex+'" width="200" height="267" class="img-rounded" onclick="clickFile('+fileIndex+');">');
			$('#imageFile'+num).parent().append('<input type="file" name="imageFile" id="imageFile'+fileIndex+'" onchange="loadImg(this, '+fileIndex+')"/>');
		}
		
		
		fileIndex++;
	}
}
</script>	
<style>
        table th {
            font-size: 15px;
            }
     .fileArea {
       width: 100%;
 	 }

   .fileArea ul {
       display: flex;
       flex-flow: row;
       justify-content: center;
       align-items: center;
       padding: 0;
   }

   .fileArea ul li {
       list-style: none;
       padding: 10px;
   }

   .fileArea ul li img {
       width: 100px;
   }
   
   .fileArea ul li span {color: dimgray;}
</style>   
</head>
<body>

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
							<h3 style="width: 200px; height: 30px;">중고게시판</h3>
								<div class='market-insert-form'>
									<form action = "marketInsert.bo" class="frm_market_insert" name="frm_market_insert" method="post" enctype="multipart/form-data" >
										<div class="form-group row">
								   		 <label for="mbWriter" class="col-sm-2 col-form-label  is-invalid">작성자</label>
										    <div class="col-sm-8">
										      <input type="text" class="form-control "  name="mbWriter"required readonly value="${ sessionScope.loginUser.mId }"> 
										    </div>
										  </div>
										<div class="form-group row">
								   		 <label for="mbTitle" class="col-sm-2 col-form-label  is-invalid">상품명</label>
										    <div class="col-sm-8">
										      <input type="text" class="form-control "  name="mbTitle" required placeholder="상품명 및 제목을 입력하세요.">
										    </div>
										  </div>
										  
										<div class="form-group row">
								   		 <label for="marketaCate" class="col-sm-2 col-form-label">카테고리</label>
										    <div class="col-sm-8">
						   					 <select class="form-control " name="mbCategory"  required>
														<option value="전체">카테고리</option>
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
										    	  <input type="text" class="form-control" name="marketPrice" id="marketPrice" onkeyup="wonComma(this.value)" value="0" style="text-align : right;" required>
										    	  <span class="input-group-text">원</span>
										    	</div>
										    </div>
										  </div>
										</div>
										  <div class="form-group row">
								   		 <label for="mbContent" class="col-sm-2 col-form-label">내용</label>
										    <div class="container">
							 					 <textarea id="summernote" class="summernote" name="mbContent" ></textarea>
											</div>
										  </div>
										  <div class="col-lg-12">
										      <div class="card shadow mb-4">
										         <div class="card-header py-3">
										            <h4 class="m-0 font-weight-bold text-primary">대표사진을 선택해주세요</h4>
										         </div>
										         <div class="card-body">
										            <div class="form-group uploadDiv">
										              <!-- 첨부파일 시작 -->
														<div id="fileArea">
															<input type="file" name="uploadFile" id="imageFile0" onchange="loadImg(this, 0)"/>
														</div>
														<!-- 첨부파일 끝 -->
													</div>
													</div>
										         </div>
										      </div>
											</div>
										 <div class="market-btn-zone" align="center">
											<input class="btn btn-primary" type="submit"   id = 'btnSave' value="등록">
											<input class="btn btn-primary" type = 'button' value = '취소' onclick = "golist();">
									</div>
								</form>
							</div>
						<!-- 본문 끝-->
					</div>
				</div>
			</div>
		</div>		
<script>	
	function wonComma(x) {
		  x = x.replace(/[^0-9]/g,'');   // 입력값이 숫자가 아니면 공백
		  x = x.replace(/,/g,'');          // ,값 공백처리
		  $("#marketPrice").val(x.replace(/\B(?=(\d{3})+(?!\d))/g, ',')); // 정규식을 이용해서 3자리 마다 , 추가 
		}		
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