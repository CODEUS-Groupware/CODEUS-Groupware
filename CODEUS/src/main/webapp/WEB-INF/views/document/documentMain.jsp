<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<% String ctxPath = request.getContextPath(); %>    

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>main page</title>
    <link href="${contextPath}/resources/assets/vendor/pg-calendar/css/pignose.calendar.min.css" rel="stylesheet">
    <link href="${contextPath}/resources/assets/vendor/chartist/css/chartist.min.css" rel="stylesheet">
</head>
<style>
	
	#containerBox {
   		margin: 50px ;
   }
	
	#titleInBox{
		margin: 50px 30px 0 30px;
		display:inline-block;
	}
	
	#btnNewAppr{
		
		background: #7B68EE;
		
	}
	
	#waitingDoc {
		font-size: 14px;
		margin: 0 0 20px 0;
	}
	
	.docListTitle {
		font-weight: bold; -
		font-size: 14px;
		margin: 50px 0 30px 0;
	}
	
	th{
		text-align: center;
		color: white;
	}
	
	.tblElecAppr {
		height: 35px;
	}
	
	.tblElecAppr > thead {
		background-color: #c5ccd3;
	}

	.table>tbody>tr>td, .table>tbody>tr>th, .table>tfoot>tr>td, .table>tfoot>tr>th, .table>thead>tr>td, .table>thead>tr>th {
	    padding: 8px;
	}
	
	.subjectStyle {font-weight: bold;
                   cursor: pointer;} 

</style>

<body onload="printClock()">

	
    <!--**********************************
        Main wrapper start
    ***********************************-->
    <div id="main-wrapper">

		<c:import url="../common/menubar.jsp"/>  
	
  <!--**********************************
            Content body start
        ***********************************-->
       
        <c:set var="today" value="<%=new java.util.Date()%>" />
        
        <div class="content-body">
            <div class="container-fluid">
			<form action="alldoc.dc" method="post">
<script type="text/javascript">

	$(document).ready(function(){

		$("span.subject").bind("mouseover", function(event){
					var $target = $(event.target);
					$target.addClass("subjectStyle");
				});
				
				$("span.subject").bind("mouseout", function(event){
					var $target = $(event.target);
					$target.removeClass("subjectStyle");
				});
		});// end of $(document).ready(function(){})-------------------
	
		
		
</script>	

<div id="titleInBox" style="font-weight: bold; font-size: 19px;">내 문서함 

</div>

	<div id="containerBox"></div>

		<div style="border-top: 1px dashed #c9c9c9; margin-top: 50px;"></div>

		<div class="docListTitle">결재 대기중 문서</div>
		
			<c:if test="${pi.ListCount eq 0}">
				<div id="waitingDoc">
					승인할 문서가 없습니다.
				</div>
			</c:if>
			<c:if test="${pi.listCount ne 0}">
				<div id="waitingDoc">
					승인할 문서가 <span style="font-weight: bold">${pi.listCount}</span> 건 있습니다.
				</div>
				<table class="table table-hover tblElecAppr" style="font-size: 14px; text-align: center;">
				    <thead>
						<tr>
							<th>문서번호</th>
							<th>기안일</th>
							<th>결재양식</th>
							<th>기안자</th>
							<th style="width: 57%;">제목</th>
							<th>첨부</th>
						</tr>
						<tr>
							<th>1</th>
							<th>2021-01-26</th>
							<th>일반품의서</th>
							<th>장현석</th>
							<th style="width: 57%;">기안문서 입니다.</th>
							<th>첨부파일.hwp</th>
						</tr>
				    </thead>
				    <tbody>
				<c:forEach var="elecapprvo" items="${elecapprvoWaitingList}" varStatus="status">
				<tr> 
					<td>${d.docNum}</td>
					<td>${d.docCreateDate}</td>
					<td>
						<c:if test="${documentForm.formNum eq 1}">
							일반품의서
						</c:if>
						<c:if test="${documentForm.formNum eq 2}">
							비용품의서
						</c:if>
						<c:if test="${documentForm.formNum eq 3}">
							증명서신청
						</c:if>
						<c:if test="${documentForm.formNum eq 4}">
							휴가신청서
						</c:if>
					</td>
					<td>${d.drafterMId}</td>
					<td style="width: 30%;"><span class="subject" onclick="location.href='newApproval.dc?approval_no=${d.docNum}'">${d.docContent}</span></td>
					<td>
						<c:if test="${uploadFile}">
							<i class="fa fa-file"></i>
						</c:if>
					</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		</c:if>
			
		<div style="border-top: 1px dashed #c9c9c9; margin-top: 50px;"></div>
		
		<div class="docListTitle table-responsive">기안 진행 문서</div>
		<table class="table table-hover tblElecAppr" style="font-size: 14px; text-align: center;">
		   <thead>
				<tr>
					<th>문서번호</th>
					<th>기안일</th>
					<th>결재양식</th>
					<th>긴급</th>
					<th style="width: 57%;">제목</th>
					<th>첨부</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="elecapprvo" items="${elecapprvoProcessingList}" varStatus="status">
				<tr>
					<td>${elecapprvo.approval_no}</td>
					<td>${elecapprvo.writeday}</td>
					<td>
						<c:if test="${elecapprvo.fk_approval_sort_no eq 1}">
							품의서
						</c:if>
						<c:if test="${elecapprvo.fk_approval_sort_no eq 2}">
							비용품의서
						</c:if>
						<c:if test="${elecapprvo.fk_approval_sort_no eq 3}">
							증명서신청
						</c:if>
					</td>
					<td>
						<c:if test="${elecapprvo.emergency eq 1}">
							<i class="fa fa-exclamation-circle"></i>
						</c:if>
					</td>
					<td style="width: 57%;"><span class="subject" onclick="location.href='processingDetail.os?approval_no=${elecapprvo.approval_no}'">${elecapprvo.title}</span></td>
					<td>
						<c:if test="${not empty elecapprvo.org_file_name}">
							<i class="fa fa-file"></i>
						</c:if>
					</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		
		
		<div style="border-top: 1px dashed #c9c9c9; margin-top: 50px;"></div>
	
		<div class="docListTitle table-responsive">완료 문서</div>

		<table class="table table-hover tblElecAppr" data-text-content="true" class="" style="font-size: 14px; text-align: center;">
			<thead>
				<tr>
					<th>문서번호</th>
					<th>기안일</th>
					<th>결재양식</th>
					<th>긴급</th>
					<th style="width: 57%;">제목</th>
					<th>첨부</th>
					<th>결재상태</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="elecapprvo" items="${elecapprvoFinishedList}" varStatus="status">
				<tr>
					<td>${elecapprvo.approval_no}</td>
					<td>${elecapprvo.writeday}</td>
					<td>
						<c:if test="${elecapprvo.fk_approval_sort_no eq 1}">
							품의서
						</c:if>
						<c:if test="${elecapprvo.fk_approval_sort_no eq 2}">
							비용품의서
						</c:if>
						<c:if test="${elecapprvo.fk_approval_sort_no eq 3}">
							증명서신청
						</c:if>
					</td>
					<td>
						<c:if test="${elecapprvo.emergency eq 1}">
							<i class="fa fa-exclamation-circle"></i>
						</c:if>
					</td>
					<td style="width: 57%;"><span class="subject" onclick="location.href='finishedDetail.os?approval_no=${elecapprvo.approval_no}'">${elecapprvo.title}</span></td>
					<td>
						<c:if test="${not empty elecapprvo.org_file_name}">
							<i class="fa fa-file"></i>
						</c:if>
					</td>
					<td>
						<c:if test="${elecapprvo.approval_status eq 1}">
							승인
						</c:if>
						<c:if test="${elecapprvo.approval_status eq 2}">
							반려
						</c:if>
					</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	
	</form>
	<%-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
          페이징 처리되어진 후 특정 글제목을 클릭하여 상세내용을 본 이후
	  사용자가 목록보기 버튼을 클릭했을때 돌아갈 페이지를 알려주기 위해
	  현재 페이지 주소를 뷰단으로 넘겨준다. --%>
	<form name="goViewFrm">
		<input type="hidden" name="approval_no" />
		<input type="hidden" name="gobackURL" value="${gobackURL}" />
	</form>
		</div>
	</div>
</div>