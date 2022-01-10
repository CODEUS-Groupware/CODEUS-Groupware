<%@ page language="java" contentType="text/html; charset=UTF-8"
	    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>


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
$(document).ready(function() {
	  $('#summernote').summernote({
 	    	placeholder: 'content',
	        minHeight: 370,
	        maxHeight: null,
	        focus: true, 
	        lang : 'ko-KR'
	  });
	  // Summernote에 글 내용 추가하는 코드
	  $("#summernote").summernote('code',  '${b.bContent}');
	});
</script>



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
											<input type="hidden" name="renameFileName" value="${ b.renameFileName }">
											
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
												<textarea id="summernote" name="bContent" ></textarea>
												</td>
											</tr>
	                           		        <tr>
	                           		        	<td>
												<label for="file">파일 찾기</label>
												<td>
										 		<input type="file" name="reloadFile">
														<c:if test="${ !empty b.originalFileName }">
															<br>현재 업로드한 파일 : 
															<a href="${ contextPath }/resources/buploadFiles/${ b.renameFileName }" download="${ b.originalFileName }">
																${ b.originalFileName }
															</a>
														</c:if>
												</td>
	                                   		</tr>
	                                   		<tr> 
	                                   		<td colspan ="4" style="text-align: center;">
											<input type="submit" id="bSubmit" class="btn btn-primary" value="수정하기"> &nbsp;
														<c:url var="Commblist.bo" value="Commblist.bo">
															<c:param name="page" value="${ page }"/>
														</c:url>
											<button type="button"  onclick="location.href='Commblist.bo'" class="btn btn-primary" >목록으로</button> &nbsp;
											<button type="button"  class="btn btn-primary" onclick="back()">이전페이지로</button>
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
  <!-- /.content-wrapper -->

<script>
$('.summernote').summernote({
	  height: 150,
	  lang: "ko-KR"
	});
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