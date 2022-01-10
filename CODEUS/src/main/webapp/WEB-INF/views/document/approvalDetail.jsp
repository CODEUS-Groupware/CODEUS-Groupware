<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<% String ctxPath = request.getContextPath(); %>    
<link href="https://fonts.googleapis.com/css?family=Roboto:400,500,700" rel="stylesheet">

<style type="text/css">
   #containerBox {
   		margin: 50px 120px;
   		
   }
	
	#titleInBox {
		margin: 50px 30px;
	}
	
	#parent {
		display: flex;
		justify-content: space-between;
	}
	
	.child {
	 	flex-grow: 1;
	}
		
	#btnNewAppr{
		margin: 0 0 30px 30px;

	}
	
	#waitingDoc {
		font-size: 14px;
		margin: 0 0 20px 0;
	}
	
	.docListTitle {
		font-weight: bold; 
		font-size: 13pt;
		margin: 50px 0 30px 0;
	}
	
	.docListTitle2 {
		font-weight: bold; 
		font-size: 13pt;
		margin: 80px 0 20px 0;
	}
	
	.table>tbody>tr>td, .table>tbody>tr>th, .table>tfoot>tr>td, .table>tfoot>tr>th, .table>thead>tr>td, .table>thead>tr>th {
		vertical-align: middle;
		align-items: center;
		padding: 0;
	}
	
	.tblElecApprInfoSm {
		border: 1px solid #c5ccd3;
		height: 20px;
		text-align: center; 
		vertical-align: middle;
		align-items: center;
	}
	
	
	.tblElecApprInfo {
		border: 1px solid #c5ccd3;
		height: 50px;
		text-align: center; 
		vertical-align: middle;
		align-items: center;
	}
	
	
	th.tblElecApprInfo {
		color: white;
		background-color: #c5ccd3; 
		width: 50%; 
		text-align: center; 
		vertical-align: middle;
	}

	td.tblElecApprInfo {
		width: 50%; 
		text-align: center; 
		vertical-align: middle;
		align-items: center;
	}
	
	div.divElecApprInfo{
		display: inline-block;
		float: left;
		align-items: center;
	}
	

	.tblElecApprLineInfo {
		text-align: center;
		height: 35px;
		width: 450px;
	}
	
	tr.tblElecApprLineInfo > th{
		width: 250px;
		text-align: center;
		color: white;
		background-color: #c5ccd3;
	}


#opinion{
	width: 100%;
	height: 30px;
	margin-right: 20px;
}

/***** slider *****/	
.switch {
  vertical-align: middle;
  position: relative;
  display: inline-block;
  width: 50px;
  height: 25px;
}

.switch input { 
  opacity: 0;
  width: 0;
  height: 0;
}

.slider {
  position: absolute;
  cursor: pointer;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: #ccc;
  -webkit-transition: .4s;
  transition: .4s;
}

.slider:before {
  position: absolute;
  content: "";
  height: 20px;
  width: 20px;
  left: 4px;
  margin: 2.5px 0;
  background-color: white;
  -webkit-transition: .4s;
  transition: .4s;
}

input:checked + .slider {
  background-color: #cbb2ae;
}

input:focus + .slider {
  box-shadow: 0;
}

input:checked + .slider:before {
  -webkit-transform: translateX(22px);
  -ms-transform: translateX(22x);
  transform: translateX(22px);
}


/* Rounded sliders */
.slider.round {
  border-radius: 22px;
}

.slider.round:before {
  border-radius: 50%;
}

#submitArea {
	text-align: center;
	margin: 40px 0;
}
#submitArea > button {
	width: 100px;
}

</style>

<script src="<%= request.getContextPath()%>/resources/assets/ckeditor/ckeditor.js"></script> 

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
			<form action="approvalDetail.dc" method="post">

<script type="text/javascript">
$(document).ready(function(){
	
	// 반려버튼
	$("button#reject").click(function(){
		// 폼(form)을 전송(submit)
		var frm = document.approvalFrm;
		frm.method = "POST";
		frm.action = "<%= ctxPath%>/elecapproval/rejectApproval.os";
		frm.submit();
	});
	
	// 승인버튼
	$("button#approval").click(function(){
		// 폼(form)을 전송(submit)
		var frm = document.approvalFrm;
		frm.method = "POST";
		frm.action = "<%= ctxPath%>/elecapproval/confirmApproval.os";
		frm.submit();
	});
	
}); // end of ready()-------------------------------------------


   
</script>

	<div id="titleInBox" style="font-weight: bold; font-size: 19px;">결재하기</div>
		<form name ="approvalFrm">
		<div id="containerBox">
	
		<div id="parent">
		
		<div class="child" >
	
			<div class="divElecApprInfo table-responsive" >
			<div class="docListTitle" >요약</div>
				<table class="table table-bordered table-sm tblElecApprLineInfo" style="font-size: 14px">
					<tr class="tblElecApprLineInfo">
						<th class="tblElecApprLineInfo">문서종류</th>
						<td class="tblElecApprLineInfo" style="align-items: center;">
							<c:if test="${elecapprvo.fk_approval_sort_no eq 1}">
								<span id="docSortTitle">일반 품의서</span>
							</c:if>
							<c:if test="${elecapprvo.fk_approval_sort_no eq 2}">
								<span id="docSortTitle">비용 품의서</span>
							</c:if>
							<c:if test="${elecapprvo.fk_approval_sort_no eq 3}">
								<span id="docSortTitle">증명서 신청서</span>
							</c:if>
						</td>
					</tr>
					<tr class="tblElecApprLineInfo">
						<th class="tblElecApprLineInfo">기안자</th>
						<td class="tblElecApprLineInfo" style="align-items: center;">
							${d.drafterMId}
						</td>
					</tr>
					<tr class="tblElecApprLineInfo">
						<th class="tblElecApprLineInfo">소속</th>
						<td class="tblElecApprLineInfo" style="align-items: center;">
							${elecapprvo.empvo.dept_name}팀
						</td>
					</tr>
					<tr class="tblElecApprLineInfo">
						<th class="tblElecApprLineInfo">기안작성일</th>
						<td class="tblElecApprLineInfo" style="align-items: center;">
							${elecapprvo.writeday}
						</td>
					</tr>
					</tbody>
				</table>
			</div>
		</div>
		
		<div class="child" >
		
			<div class="divElecApprInfo table-responsive" style="float: right; align-items: flex-end; margin-right: 10px;">
			<div class="docListTitle">결재선</div>
				<table class="table table-bordered tblElecApprLineInfo" style="float: right;">
					<tbody>
						<tr class="tblElecApprLineInfo">
							<th>구분</th>
							<c:if test="${not empty elecapprvo.midapprvo}">
								<th>중간 결재자</th>
							</c:if>
							<th>최종 결재자</th>
						</tr>
						<tr class="tblElecApprLineInfo">
							<th>직급</th>
							<c:if test="${not empty elecapprvo.midapprvo}">
								<td>${elecapprvo.midapprvo.position_name}</td>
							</c:if>
							<td>${elecapprvo.finapprvo.position_name}</td>
						</tr>
						<tr class="tblElecApprLineInfo">
							<th>이름</th>
							<c:if test="${not empty elecapprvo.midapprvo}">
								<td>${elecapprvo.midapprvo.emp_name}</td>
							</c:if>
							<td>${elecapprvo.finapprvo.emp_name}</td>
						</tr>
						<tr class="tblElecApprLineInfo">
							<th>승인여부</th>
							<td>
								<c:if test="${elecapprvo.mid_approval_ok == 1}">
									<i class="fa fa-check-circle"></i>
								</c:if>
							</td>
							<td>
								<c:if test="${elecapprvo.fin_approval_ok == 1}">
									<i class="fa fa-check-circle"></i>
								</c:if>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
			
		</div>	
	
		<div>
			<div class="docListTitle2">세부내용</div>
	<!-- ------------------------------------------------------------------------------------------------------------------------- -->
			
			<!-- 문서 헤더 시작-->
			<%-- 문서종류, 신청자정보 템플릿 --%>
			<div id="docHeader1">
				<table
				style='width: 100%; color: black; background: white; border: 1px solid black; font-size: 12px; font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; border-collapse: collapse !important; height: 187px;'>
				<colgroup>
					<col style='width: 90px;'>
					<col style='width: 180px;'>
					<col style='width: 90px;'>
					<col style='width: 250px;'>
					<col style='width: 90px;'>
					<col style=''>
				</colgroup>
	
				<tbody>
					<tr>
						<td
							style='padding: 3px; border: 1px solid black; font-size: 27px; font-weight: bold; text-align: center; vertical-align: middle; height: 113px;'
							colspan='2'>
							<c:if test="${elecapprvo.fk_approval_sort_no eq 1}">
								<span id="docSortTitle">품 의 서</span>
							</c:if>
							<c:if test="${elecapprvo.fk_approval_sort_no eq 2}">
								<span id="docSortTitle">비용 품의서</span>
							</c:if>
							<c:if test="${elecapprvo.fk_approval_sort_no eq 3}">
								<span id="docSortTitle">증명서 신청서</span>
							</c:if>
								
							</td>
						<td
							style='padding: 3px; height: 113px; vertical-align: middle; border: 1px solid black; text-align: right;'
							colspan='4'><br></td>
					</tr>
					<tr>
						<td
							style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: center; font-weight: bold;'>
							기안부서</td>
						<td
							style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: left;'>
							<span
							style='font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt;'>${elecapprvo.empvo.dept_name}</span>
						</td>
						<td
							style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: center; font-weight: bold;'>
							기 안 일</td>
						<td
							style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: left;'>
							<span
							style='font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt;'>${elecapprvo.writeday}</span>
						</td>
						<td
							style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: center; font-weight: bold;'>
							문서번호</td>
						<td
							style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: left; font-size: 12px;'>
							<span
							style='font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt;'>${elecapprvo.approval_no}</span>
						</td>
					</tr>
				</tbody>
			</table>  
			</div>
					<!-- 비용품의서 또는 증명서신청서인경우 -->
					<c:if test="${elecapprvo.fk_approval_sort_no eq 2}">
						<table
							style='width: 100%; color: black; background: white; border: 0px; font-size: 12px; font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; border-collapse: collapse !important; height: 30px'>
							<colgroup>
								<col style='width: 90px;'>
								<col style='width: 180px;'>
								<col style='width: 90px;'>
								<col style='width: 250px;'>
								<col style='width: 90px;'>
							</colgroup>
				
							<tbody>
								<tr>
									<td
										style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black ; text-align: center; font-weight: bold;'>
										용    도</td>
									<td
										style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: left;'>
										<span
										style='font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt;'>${elecapprvo.contents2}</span>
									</td>
									<td
										style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: center; font-weight: bold;'>
										총 비 용</td>
									<td
										style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: left;'>
										<span
										style='font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt;'>${elecapprvo.contents3}</span>
									</td>
									<td
										style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: center; font-weight: bold;'>
										비용처리방법</td>
									<td
										style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: left;'>
										<span
										style='font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt;'>${elecapprvo.contents4}</span>
									</td>
								</tr>
							</tbody>
						</table> 
					</c:if>
					<c:if test="${elecapprvo.fk_approval_sort_no eq 3}">
						<table
							style='width: 100%; color: black; background: white; border: 0px; font-size: 12px; font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; border-collapse: collapse !important; height: 30px'>
							<colgroup>
								<col style='width: 90px;'>
								<col style='width: 180px;'>
								<col style='width: 90px;'>
								<col style='width: 250px;'>
								<col style='width: 90px;'>
							</colgroup>
				
							<tbody>
								<tr>
									<td
										style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black ; text-align: center; font-weight: bold;'>
										증명서 종류</td>
									<td
										style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: left;'>
										<span
										style='font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt;'>${elecapprvo.contents2}</span>
									</td>
									<td
										style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: center; font-weight: bold;'>
										용    도</td>
									<td
										style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: left;'>
										<span
										style='font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt;'>${elecapprvo.contents3}</span>
									</td>
									<td
										style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: center; font-weight: bold;'>
										제 출 처</td>
									<td
										style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: left;'>
										<span
										style='font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt;'>${elecapprvo.contents4}</span>
									</td>
									
								</tr>
							</tbody>
						</table>
					</c:if>
					


					<!-- 제목 및 내용 시작 -->
	
					<table style="width: 99.85%; border-collapse: collapse !important; color: black; background: white; border: 1px solid black; font-size: 12px; font-family: malgun gothic, dotum, arial, tahoma;">
						<colgroup>
							<col style="width: 90px;">
							<col style="width: 710px;">
						</colgroup>
	
						<tbody>
							<tr>
								<td
									style="padding: 3px; height: 30px; vertical-align: middle; border: 1px solid black; text-align: center; font-weight: bold;">
	
									제 &nbsp;&nbsp;&nbsp; 목</td>
								<td style="padding: 0 3px;">
									${elecapprvo.title}
								</td>
							</tr>
							<tr>
								<td
									style="padding: 20px; height: 540px; vertical-align: top; border: 1px solid black;"
									colspan="2">${elecapprvo.content}</td>
							</tr>
							<%-- === #162. 첨부파일 이름 및 파일크기를 보여주고 첨부파일을 다운로드 되도록 만들기 === --%>
									<c:if test="${elecapprvo.org_file_name != null}">
										<tr>
											<th style="height: 25px; font-weight: bold; border: solid 1px black; text-align: center;">첨부파일</th>
											<td style="padding 0 10px;">
												<a href="<%= request.getContextPath()%>/elecapproval/download.os?approval_no=${elecapprvo.approval_no}">${elecapprvo.org_file_name}</a> 
											</td>
										</tr>
									</c:if>
							</tbody>
					</table> <!-- 제목 및 내용 끝 --> 
					<!-- 푸터-->
	
					<table style="padding: 20px; width: 100%;; font-size: 12px; font-family: malgun gothic, dotum, arial, tahoma;">
						<tbody>
							<tr>
							</tr>
						</tbody>
					</table> <!-- 푸터 끝-->
				
			<!-- ------------------------------------------------------------------------------------------------------------------------- -->
		</div>
		<!-- 해당 결재건의 결재번호를 폼에 넣기 -->
		<input type="hidden" id="approval_no" name="approval_no" value="${elecapprvo.approval_no}"/>
			<!-- 중간결재자가 존재하고, 결재하는 사람이 최종결재자일때만 보이도록 한다 -->
			<c:if test="${(not empty elecapprvo.midapprvo) and (elecapprvo.fk_fin_approver_no eq login_userid)}">
				<div class="docListTitle2">중간결재자 의견</div>
				<span>${elecapprvo.mid_approval_opinion}</span>
			</c:if>
		
			<div class="docListTitle2">결재 의견 작성</div>
			<!-- 해당 결재건이 중간결재자의 승인인 경우 -->
			<c:if test="${elecapprvo.fk_mid_approver_no eq login_userid}">
				<input type="text" id="opinion" name="mid_approval_opinion" style="font-size:11pt"/>
				<input type="hidden" id="approvalType" name="approvalType" value="mid" />
			</c:if>

			<!-- 해당 결재건이 최종결재자의 승인인 경우 -->
			<c:if test="${elecapprvo.fk_fin_approver_no eq login_userid}">
				<input type="text" id="opinion" name="fin_approval_opinion" style="font-size:11pt" />
				<input type="hidden" id="approvalType" name="approvalType" value="fin" />
			</c:if>

			
		  	<p id="submitArea" >
				<button type="button" id="reject" class="btn btn-danger m-l-20 btn-rounded btn-outline hidden-xs hidden-sm waves-effect waves-light">반려</button>
				<button type="button" id="approval" class="btn btn-info m-l-20 btn-rounded btn-outline hidden-xs hidden-sm waves-effect waves-light">승인</button>
			</p>
	</div>
	</div>
	</div>
	</div>
		</form>
	</form>
</form>