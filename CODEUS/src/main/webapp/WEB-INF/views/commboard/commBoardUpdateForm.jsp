<%@ page language="java" contentType="text/html; charset=UTF-8"
	    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>


<link rel="stylesheet" href="${contextPath}/resources/assets/vendor/summernote/summernote-lite.css">


</head>
<body>
<!--**********************************
        Main wrapper start
    ***********************************-->
<div id="main-wrapper">
	<c:import url="../common/menubar.jsp" />
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
                                <div class="table-responsive">
 								
					<!-- Main content -->
					    <div class="content">
					      <div class="container-fluid">
					        <div class="row">
					          <div class="col-lg-12">
					            <div class="card  card-primary card-outline">
					              <div class="card-body">
					                <h5 class="card-title"></h5>
					                <div class="card-body register-card-body">
								     <div class="card-header">
                               		 <h4 class="card-title">자유게시판</h4>
                          					 </div>
                          				<!-- 첨부파일도 수정 할 수도 있으니 Multipart/form-data encType 지정 -->
										<form action="bupdate.bo" method="post" enctype="Multipart/form-data">
											<input type="hidden" name="page" value="${ page }">
											<input type="hidden" name="bId" value="${ b.bId }">
											
											
											<table class="table table-write" id="add_mt" style="color:black ">
											<tr>
												<th>제목</th>
												<td>
												<input type="text" class="form-control" name="bTitle" style="width: 40%;" placeholder="제목" value="${b.bTitle }"/>
												</td>
											</tr>
											<tr>						
												<th>작성자</th>
												<td><input type="text" class="form-control" name="bWriter" style="width: 20%;" placeholder="작성자" value="${b.bWriter }" readonly/></td>
											</tr>
											<tr>
												<th>내용</th>
												<td>
												<textarea id="summernote" name="bContent" >${ b.bContent }</textarea>
												</td>
											</tr>
	                                   		<tr> 
	                                   		<td colspan ="4" style="text-align: center;">
											<input type="submit" id="bSubmit" class="btn btn-primary" value="수정"> &nbsp;
														<c:url var="Commblist.bo" value="Commblist.bo">
															<c:param name="page" value="${ page }"/>
														</c:url>
											<button type="button"  onclick="location.href='Commblist.bo'" class="btn btn-primary" >목록</button> &nbsp;
											<button type="button"  class="btn btn-primary" onclick="back()">이전페이지</button>
											</td>
											</tr>
									</table>					
								</form>
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
  </div>
  </div>
  </div>	
  </div>
  <!-- /.content-wrapper -->

!--**********************************
          Content body end
      ***********************************-->

<!--**********************************
            Content body end
        ***********************************-->

	<!--**********************************
		       Summernote  Scripts
		***********************************-->
 	<script src="${contextPath}/resources/assets/vendor/summernote/summernote-lite.js"></script>
	<script src="${contextPath}/resources/assets/vendor/summernote/lang/summernote-ko-KR.js"></script>
                      	<script>
        $(document).ready(function () {
            //여기 아래 부분
            $('#summernote').summernote({
                height: 400,                     // 에디터 높이
                 minHeight: null,                      // 최소 높이
                 maxHeight: null,                      // 최대 높이
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
                url: "/uploadSummernoteImageFile.bo",
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
		function back() {
			var deleteYN = confirm("작성중이던 글이 있습니다.이전 페이지로 가시겠습니까?");
				if(deleteYN){
						location.href='javascript:history.go(-1);';
					      }
					}
 </script>	

</body>
</html>