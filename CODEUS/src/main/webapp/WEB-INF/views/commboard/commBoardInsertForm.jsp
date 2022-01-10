<%@ page language="java" contentType="text/html; charset=UTF-8"
	    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 등록</title>


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
                          				<form action="binsert.bo" method="post" enctype="Multipart/form-data">	 
									      <table class="table table-write" id="add_mt" style="color:black ">
											<colgroup>			
											<col style="width:120px" />
											<col style="width:*" />						
											</colgroup>
											<tr>						
												<th>제목</th>
												<td><input type="text" class="form-control" id="bTitle" name="bTitle" placeholder="제목" value="${title}" required></td>
											</tr>
											<tr>
											<th>작성자</th>
											<td>
												<input type="text" class="form-control" id="bWriter" name="bWriter" readonly value="${ sessionScope.loginUser.mId }">
											</td>
											</tr>
											<tr>
											<th>내용</th>
											<td>
												<div class="container">
												  <textarea id="summernote" class="summernote" name="bContent" >${placeholder = "글 내용을 작성하세요"}</textarea>    
												</div>
											</td>
											</tr>
	                           		        <tr>
	                           		        <td>
	                                        <label for="file">파일 찾기</label>
	                                     	<td>
	                                     	<input type="file" name="uploadFile"></td>
	                                   		</td>
	                                   		</tr>
	                                   		
	                                    	<tr> 
	                                    	<td colspan ="4" style="text-align: center;">
											<button type="button" onclick="location.href='Commblist.bo'" class="btn btn-primary">취소</button>
											<input type="submit" value="등록 하기" id="bSubmit" class="btn btn-primary">
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
$('bSubmit').click( function() {
	var title = bTitle.value;
	var content = bContent.value;
	
	if (title.trim() == ''){
		alert("제목을 입력해주세요");
		return false;
	}
	if (content.trim() == ''){
		alert("내용을 입력해주세요");
		return false;
	}

</script>



</body>
</html>