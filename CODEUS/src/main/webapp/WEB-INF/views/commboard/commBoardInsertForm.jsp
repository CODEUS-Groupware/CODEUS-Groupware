<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<!-- include libraries(jQuery, bootstrap) -->
		<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
		<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
		<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 
		<!-- include summernote css/js-->
		<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.css" rel="stylesheet">
		<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.js"></script>
		<!-- include summernote-ko-KR -->
		<script src="/resources/js/summernote-ko-KR.js"></script>

<title>자유게시판</title>
<style type="text/css">
	#tb{margin: auto; width: 700px; border-collapse: collapse;}
	#tb tr td{padding: 5px;}
	#buttonTab{border-left: hidden; border-right: hidden;}
</style>
	<!-- Favicon icon -->
    <link rel="icon" type="image/png" sizes="16x16" href="./images/favicon.png">
    <!-- Datatable -->
    <link href="${contextPath}/resources/assets/vendor/datatables/css/jquery.dataTables.min.css" rel="stylesheet">
    <!-- Custom Stylesheet -->
    <link href="${contextPath}/resources/assets/css/style.css" rel="stylesheet">

<script>
$(document).ready(function() {
	  $('#summernote').summernote({
 	    	placeholder: 'content',
	        minHeight: 370,
	        maxHeight: null,
	        focus: true, 
	        lang : 'ko-KR'
	  });
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
									      <table class="table table-write" id="add_mt" style="color:black" >
											<colgroup>			
											<col style="width:120px" />
											<col style="width:*" />						
											</colgroup>
											<tr>						
												<th>제목</th>
												<td><input type="text" class="form-control" id="title" name="title" placeholder="제목" value="${title}" required></td>
											</tr>
											<tr>
												<th>내용</th>
												<td>
													<div id="summernote" name="content">${content}</div>
												</td>
											</tr>
										</table>			      
								      <input type="hidden" id="division" name="division" value="test1" />
								    </div>
								     <div class="form-group">
	                               
	                                        <label for="file">파일 찾기</label>
	                                        <input type="file" name="uploadFile" id="file" class="ex_file" multiple="multiple">
	                                    </div>
							    <div style="text-align: center;">
									<button title="목록" type="button" class="btn btn-primary" onclick="">목록</button>
								
									<button title="저장" type="button" id="a_save_btn" class="btn btn-primary"  onclick="save_note()">저장</button>
									<button title="삭제" type="button" class="btn btn-primary" onclick="#">취소</button>
									
								</div>
              </div>
            </div>
		  </div>
        </div>
        <!-- /.row -->
      </div><!-- /.container-fluid -->
    </div>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
  

<script src="${pageContext.request.contextPath}/resources/AdminLTE/plugins/summernote/summernote-bs4.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/AdminLTE/plugins/summernote/lang/summernote-ko-KR.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/AdminLTE/plugins/moment/moment.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/AdminLTE/plugins/inputmask/min/jquery.inputmask.bundle.min.js"></script>
//${pageContext.request.contextPath}/resources/AdminLTE/
<script>
$(function () {
    //Money Euro
    $('[data-mask]').inputmask()
	if($("#mdate").val()=='')
	{
		$("#mdate").val(getTimeStamp());
	}
    // Summernote
	$('#summernote').summernote({
	    lang: 'ko-KR', // default: 'en-US'
	   	height: 500,                 // set editor height
		minHeight: 500,             // set minimum height of editor
		maxHeight: 500,             // set maximum height of editor
		focus: true,                  // set focus to editable area after initializing summe
	  });
  })
</script> 

<script>
function uploadSummernoteImageFile(file, editor) {
    data = new FormData();
    data.append("file", file);
    $.ajax({
        data : data,
        type : "POST",
        url : "/uploadSummernoteImageFile",
        contentType : false,
        processData : false,
        success : function(data) {
            //항상 업로드된 파일의 url이 있어야 한다.
            $(editor).summernote('insertImage', data.url);
        }
    });
}



</script> 
						

</body>

</html>