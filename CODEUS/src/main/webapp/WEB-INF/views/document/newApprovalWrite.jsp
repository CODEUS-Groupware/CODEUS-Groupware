<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<link href="https://fonts.googleapis.com/css?family=Roboto:400,500,700" rel="stylesheet">

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   


<style type="text/css">
#containerBox {
	margin: 50px 120px;
}

#titleInBox {
	margin: 50px 30px;
}

#btnNewAppr {
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

.table>tbody>tr>td, .table>tbody>tr>th, .table>tfoot>tr>td, .table>tfoot>tr>th,
	.table>thead>tr>td, .table>thead>tr>th {
	vertical-align: middle;
	align-items: center;
	padding: 0;
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

div.divElecApprInfo {
	display: inline-block;
	float: left;
	align-items: center;
}

.tblElecApprLineInfo {
	text-align: center;
	height: 35px;
}

tr.tblElecApprLineInfo>th {
	text-align: center;
	color: white;
	background-color: #c5ccd3;
}

#title {
	width: 85%;
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

input:checked+.slider {
	background-color: #cbb2ae;
}

input:focus+.slider {
	box-shadow: 0;
}

input:checked+.slider:before {
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

#submitArea>a {
	width: 100px;
}

      /* 주소록 CSS 시작 */
      .content_layout_address {
         width: 1200px;
         background-color:#fff;
   
   }
   
   .nav_layer{
         width:100%;
         height: 25px;
         display: block;
         float: left;
   }
   
   .tab_nav li {
       float: left;
       margin: 0 0 -1px 24px;
       padding: 0;
       height: 40px;
       line-height: 40px;
       font-size: 13px;
       color: #999;   
       
         list-style-type: none;      
   }
   
   .tab_nav li:first-child {
         margin: 0;
   }
   
   .tab_wrap {
         width: 550px;
         display: inline-block;
   }
   .tree, .tree ul {
       margin:0;
       padding:0;
       list-style:none
   }
   .tree ul {
       margin-left:1em;
       position:relative
   }
   .tree ul ul {
       margin-left:.5em
   }
   .tree ul:before {
       content:"";
       display:block;
       width:0;
       position:absolute;
       top:0;
       bottom:0;
       left:0;
       border-left:1px solid
   }
   .tree li {
       margin:0;
       padding:0 1em;
       line-height:2em;
       color:#369;
       font-weight:700;
       position:relative
   }
   .tree ul li:before {
       content:"";
       display:block;
       width:10px;
       height:0;
       border-top:1px solid;
       margin-top:-1px;
       position:absolute;
       top:1em;
       left:0
   }
   .tree ul li:last-child:before {
       background:#fff;
       height:auto;
       top:1em;
       bottom:0
   }
   .indicator {
       margin-right:5px;
   }
   .tree li a {
       text-decoration: none;
       color:#369;
   }
   .tree li button, .tree li button:active, .tree li button:focus {
       text-decoration: none;
       color:#369;
       border:none;
       background:transparent;
       margin:0px 0px 0px 0px;
       padding:0px 0px 0px 0px;
       outline: 0;
   }   
   .father {
         display: flex;
   }
   .search {
         width: 338px;
         border-radius: 3px;
         border: 2px solid #adb5bd;
   }
   .emp_search {
         margin-bottom: 0; 
   }
   .search, .btnSearch {
         height: 32px;   
   } 
   span.btn_bg {
        position: relative;
       cursor: pointer;
       padding: 4px 4px 6px;
       background-color: #fff;
       border: 1px solid #ddd;
       text-align: left;
       margin-bottom: 10px;
   }
   span.addGroup {
         
   }
   span.addFinApprover {
         
   }
   .addArea {
   		display: flex;
        flex-direction: column;
		justify-content: center;
        vertical-align: middle;
        margin: 0 20px;
   }
   .addList, li {
         list-style-type: none;
   }
   div.approver_wrap div.approver_list ul {
       border: 1px solid #666;
       height: 105px;
       overflow-x: hidden;
       background: #f9f9f9;
       padding: 0 4px;
   } 
   div.approver_wrap div.approver_list {
       display: inline-block;
       margin: 10px 0 0 0;
       width: 270px;
   }
   
   li.orgName {
          cursor: pointer;
   
   }
      /* 주소록 CSS 끝 */


</style>



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
		<form action="newApproval.dc" method="post"> 

<script type="text/javascript">

	//전체 모달 닫기(전역함수인듯)
	window.closeModal = function(){
	    $('.modal').modal('hide');
	    // javascript:history.go(0);
	};
	
	$(document).ready(function(){
		
		
		//라디오 요소처럼 동작시킬 체크박스 그룹 셀렉터
	    $('input[name=chkbox]').click(function(){
	        //클릭 이벤트 발생한 요소가 체크 상태인 경우
	        if ($(this).prop('checked')) {
	            //체크박스 그룹의 요소 전체를 체크 해제후 클릭한 요소 체크 상태지정
	            $('input[name=chkbox]').prop('checked', false);
	            $(this).prop('checked', true);
	        }
	    });
	  
	    getDate();
	
	// 기본설정에서 문서종류를 선택시 상세입력의 템플릿을 바꾸기
	$("select#approvalSort").bind("change", function() {
		// func_choice($(this).val()); 
		// $(this).val()은 "1" 또는 "2" 또는 "3" 또는 "4" 이다.
		var docSortTitle="";
		var html=""
		
		if ($(this).val()==1) {
			docSortTitle += "일반품의서";
			html +="<input type='hidden' name='docContent' value='일반 품의 내용입니다.' />"+
				   "<input type='hidden' name='docContent' value='none' />"+
				   "<input type='hidden' name='docContent' value='none' />";
				 
				 
			
		}
		else if ($(this).val()== 2) {
			docSortTitle += "비용품의서";
			html += "<table  " + 
			"			style='width: 100%; color: black; background: white; border: 0px; font-size: 12px; font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; border-collapse: collapse !important; height: 30px'>  " + 
			"			<colgroup>  " + 
			"				<col style='width: 90px;'>  " + 
			"				<col style='width: 180px;'>  " + 
			"				<col style='width: 90px;'>  " + 
			"				<col style='width: 250px;'>  " + 
			"				<col style='width: 90px;'>  " + 
			"			</colgroup>  " + 
			"  " + 
			"			<tbody>  " + 
			"				<tr>  " + 
			"					<td  " + 
			"						style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black ; text-align: center; font-weight: bold;'>  " + 
			"						용    도</td>  " + 
			"					<td  " + 
			"						style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: left;'>  " + 
			"						<span  " + 
			"						style='font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt;'><input type='text' name='docContent' style='width: 99%;'/></span>  " + 
			"					</td>  " + 
			"					<td  " + 
			"						style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: center; font-weight: bold;'>  " + 
			"						총 비 용</td>  " + 
			"					<td  " + 
			"						style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: left;'>  " + 
			"						<span  " + 
			"						style='font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt;'><input type='text' name='docContent' style='width: 90%;' />  원</span>  " + 
			"					</td>  " + 
			"					<td  " + 
			"						style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: center; font-weight: bold;'>  " + 
			"						비용처리방법</td>  " + 
			"					<td  " + 
			"						style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: left;'>  " + 
			"						<span  " + 
			"						style='font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt;'><input type='text' name='docContent' style='width: 99%;' /></span>  " + 
			"					</td>  " + 
			"					  " + 
			"				</tr>  " + 
			"			</tbody>  " + 
			"		</table> ";
			
		}
		else if ($(this).val()== 3){
			docSortTitle += "증명서신청";
			html += "<table  " + 
			"			style='width: 100%; color: black; background: white; border: 0px; font-size: 12px; font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; border-collapse: collapse !important; height: 30px'>  " + 
			"			<colgroup>  " + 
			"				<col style='width: 90px;'>  " + 
			"				<col style='width: 180px;'>  " + 
			"				<col style='width: 90px;'>  " + 
			"				<col style='width: 250px;'>  " + 
			"				<col style='width: 90px;'>  " + 
			"			</colgroup>  " + 
			"  " + 
			"			<tbody>  " + 
			"				<tr>  " + 
			"					<td  " + 
			"						style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black ; text-align: center; font-weight: bold;'>  " + 
			"						증명서 종류</td>  " + 
			"					<td  " + 
			"						style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: left;'>  " + 
			"						<span  " + 
			"						style='font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt;'><input type='text' name='docContent' style='width: 99%;'/></span>  " + 
			"					</td>  " + 
			"					<td  " + 
			"						style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: center; font-weight: bold;'>  " + 
			"						용    도</td>  " + 
			"					<td  " + 
			"						style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: left;'>  " + 
			"						<span  " + 
			"						style='font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt;'><input type='text' name='docContent' style='width: 90%;' /></span>  " + 
			"					</td>  " + 
			"					<td  " + 
			"						style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: center; font-weight: bold;'>  " + 
			"						제 출 처</td>  " + 
			"					<td  " + 
			"						style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: left;'>  " + 
			"						<span  " + 
			"						style='font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt;'><input type='text' name='docContent' style='width: 99%;' /></span>  " + 
			"					</td>  " + 
			"					  " + 
			"				</tr>  " + 
			"			</tbody>  " + 
			"		</table> ";
		}
		else if ($(this).val()== 4){
			docSortTitle += "휴가신청서";
			html += "<table  " + 
			"			style='width: 100%; color: black; background: white; border: 0px; font-size: 12px; font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; border-collapse: collapse !important; height: 30px'>  " + 
			"			<colgroup>  " + 
			"				<col style='width: 90px;'>  " + 
			"				<col style='width: 180px;'>  " + 
			"				<col style='width: 90px;'>  " + 
			"				<col style='width: 250px;'>  " + 
			"				<col style='width: 90px;'>  " + 
			"			</colgroup>  " + 
			"  " + 
			"			<tbody>  " + 
			"				<tr>  " + 
			"					<td  " + 
			"						style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black ; text-align: center; font-weight: bold;'>  " + 
			"						휴가 종류</td>  " + 
			"					<td  " + 
			"						style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: left;'>  " + 
			"						<span  " + 
			"						style='font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt;'><input type='text' name='docContent' style='width: 99%;'/></span>  " + 
			"					</td>  " + 
			"					<td  " + 
			"						style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: center; font-weight: bold;'>  " + 
			"						잔여연차</td>  " + 
			"					<td  " + 
			"						style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: left;'>  " + 
			"						<span  " + 
			"						style='font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt;'><input type='text' name='docContent' style='width: 90%;' />일</span>  " + 
			"					</td>  " + 
			"					<td  " + 
			"						style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: center; font-weight: bold;'>  " + 
			"						사용희망연차</td>  " + 
			"					<td  " + 
			"						style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: left;'>  " + 
			"						<span  " + 
			"						style='font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt;'><input type='text' name='docContent' style='width: 90%;' />일</span>  " + 
			"					</td>  " + 
			"					  " + 
			"				</tr>  " + 
			"				<tr>  " + 
			"					<td  " + 
			"						style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black ; text-align: center; font-weight: bold;'>  " + 
			"						휴가 일시</td>  " + 
			"					<td  " + 
			"						style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: left;'>  " + 
			"						<span  " + 
			"						style='font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt;'><input type='date' name='docStartDate' style='width: 90%;' />~</span>  " +
			"						<span  " + 
			"						style='font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt;'><input type='date' name='docEndDate' style='width: 90%;' /></span>  " +
			"				</tr>  " + 
			"			</tbody>  " + 
			"		</table> ";
		}
			$("span#docSortTitle").text(docSortTitle);
		
			$("div#docHeader2").html(html);
			$("div#docHeader2").show();
	}); 
	
	
	
	
	
    <%-- === 스마트 에디터 구현 끝 === --%>
    

	   $("button#btnWrite").click(function(){
		
		<%-- === 스마트 에디터 구현 시작 === --%>
        //id가 content인 textarea에 에디터에서 대입
        obj.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
        <%-- === 스마트 에디터 구현 끝 === --%>

        var selectVal = $("select#approvalSort").val().trim();
        if(selectVal == null || selectVal == "") {
			alert("문서종류를 선택하세요!!");
        	return;
        }
        
        var finApprVal =  $("#fk_fin_approver_no").val().trim();
        if(finApprVal == null || finApprVal == ""){
			alert("조직도검색을 이용하여 최종결재자를 선택해주세요.");
        	return;
        }
        
	    // 글제목 유효성 검사
		var titleVal = $("input#title").val().trim();
		if(titleVal == "") {
			alert("글제목을 입력하세요!!");
			return;
		}
        
	
</script>

<div id="titleInBox" style="font-weight: bold; font-size: 19px;">새 결재 진행</div>
	<div id="containerBox">

	
	<div class="docListTitle">기본설정</div>
	
	<div style="display: inline-block; width: 100%">

		<div class="divElecApprInfo table-responsive"
			style="float: left; width: 45%">
			<table class="table table-bordered tblElecApprInfo"
				style="font-size: 14px;">
				<tr class="tblElecApprInfo">
					<th class="tblElecApprInfo">문서종류</th>
					<td class="tblElecApprInfo" style="align-items: center;">
						<div class="box" style="width: 93%; align-items: center;">
							<select id="approvalSort" class="form-control pull-right row b-none"
								style="align-items: center;">
								<option value="">구분 선택</option>
								<option value="1">일반품의서</option>
								<option value="2">비용품의서</option>
								<option value="3">증명서신청</option>
								<option value="4">휴가신청서</option>
								
							</select>
							<input type="hidden" id="selectedSort" name="selectedSort" />
						</div>
					</td>
				</tr>
				</tbody>
			</table>
		</div>

		<div class="divElecApprInfo table-responsive"
			style="float: right; width: 45%">
			<table class="table table-bordered tblElecApprInfo"
				style="font-size: 14px;">
				<tr class="tblElecApprInfo">
					<th class="tblElecApprInfo">기안작성자</th>
					<!-- *** session에서 로그인유저값 받아서 넣을것*** -->
					<%-- "${sessionScope.loginuser.name}" --%>
					<td class="tblElecApprInfo">${sessionScope.loginUser.mId}</td>
				</tr>
				</tbody>
			</table>
			<!-- *** session에서 로그인유저값 받아서 넣을것*** -->
			<%-- <input type="hidden" name="fk_emp_no" value="${sessionScope.loginuser.userid}" /> --%>
			<input type="hidden" name="drafterMId" id="drafterMId" value="${sessionScope.loginUser.mId}" />
		</div>

	</div>

	<div class="docListTitle">
	결재선 지정
    <%-- 주소록 모달 불러오기  --%>
	<button type="button" id="empList" class="btn btn-info" style="margin-left: 20px; border-radius: 3px;" data-toggle="modal" data-target="#findEmpListModal">조직도검색</button>
	</div> 
	
	<div class="table-responsive"
		style="display: inline-block; width: 100%">
		<table class="table table-bordered tblElecApprLineInfo">
			<tbody>
				<tr class="tblElecApprLineInfo">
					<th style="width: 22%;">구분</th>
					<th>중간 합의자1</th>
					<th>중간 합의자2</th>
					<th>최종 결재자 <span style="">*</span></th>
				</tr>
				<tr class="tblElecApprLineInfo">
					<th style="width: 22%;">이름</th>
					<td>
						<input type="text" name="approval_mid_name1" id="approval_mid_name1" style="width:50%; margin-left:10px; margin-right: 1%; border-radius:3px; border: 1px solid #adb5bd; " />
					</td>
					<td>
						<input type="text" name="approval_mid_name2" id="approval_mid_name2" style="width:50%; margin-left:10px; margin-right: 1%; border-radius:3px; border: 1px solid #adb5bd; " />
					</td>
					<td>
						<input type="text" name="approvalMId" id="approvalMId" value="${document.approvalMId}" style="width:50%; margin-left:10px; margin-right: 1%; border-radius:3px; border: 1px solid #adb5bd; " /> 
					</td>
				</tr>
				<tr class="tblElecApprLineInfo">
					<th style="width: 22%;">부서</th>
					<td>
						<input type="text" name="approval_mid_dept1" id="approval_mid_dept1" style="width:50%; margin-left:10px; margin-right: 1%; border-radius:3px; border: 1px solid #adb5bd; " />
					</td>
					<td>
						<input type="text" name="approval_mid_dept2" id="approval_mid_dept2" style="width:50%; margin-left:10px; margin-right: 1%; border-radius:3px; border: 1px solid #adb5bd; " />
					</td>
					<td>
						<input type="text" name="approval_dept" id="approval_dept"  value="코더스팀" style="width:50%; margin-left:10px; margin-right: 1%; border-radius:3px; border: 1px solid #adb5bd; " />
					</td>
				</tr>
				<tr class="tblElecApprLineInfo">
					<th style="width: 22%;">직위</th>
					<td>
						<input type="text" name="approval_mid_position1" id="approval_mid_position1" style="width:50%; margin-left:10px; margin-right: 1%; border-radius:3px; border: 1px solid #adb5bd; " />
					</td>
					<td>
						<input type="text" name="approval_mid_position2" id="approval_mid_position2" style="width:50%; margin-left:10px; margin-right: 1%; border-radius:3px; border: 1px solid #adb5bd; " />
					</td>
					<td>
						<input type="text" name="approval_position" id="approval_position" value="부장" style="width:50%; margin-left:10px; margin-right: 1%; border-radius:3px; border: 1px solid #adb5bd; " />
					</td>
				</tr>
			</tbody>
		</table>
		<%-- 모달창에서 받은 사번이 들어옴 --%>
		<input type="hidden" name="fk_mid_approver_no" id="fk_mid_approver_no" style="width:50%; margin-left:10px; margin-right: 1%; border-radius:3px; border: 1px solid #adb5bd; " />
		<input type="hidden" name="fk_fin_approver_no" id="fk_fin_approver_no" style="width:50%; margin-left:10px; margin-right: 1%; border-radius:3px; border: 1px solid #adb5bd; " />
	</div>

	<div class="docListTitle2">상세입력</div>

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
							colspan='2'><span id="docSortTitle">기안문서</span></td>
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
							style='font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt;'>코더스팀</span>
						</td>
						<td
							style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: center; font-weight: bold;'>
							기 안 일</td>
						<td
							style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: left;'>
							<span id="docCreateDate"
							 style='font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt;' >2022-01-26</span>
						</td>
						<td
							style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: center; font-weight: bold;'>
							문서번호</td>
						<td
							style='padding: 3px; height: 20px; vertical-align: middle; border: 1px solid black; text-align: left; font-size: 12px;'>
							<span
							style='font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt;'>자동설정</span>
						</td>
					</tr>
				</tbody>
			</table> 
			</div>
			
			
			<%-- 문서 비용, 용도부분 contents2에 넣을것 --%>
			<div id="docHeader2"> 
			
			</div>
		
	
	
		<!-- 문서 헤더 끝--> 
			
			<!-- 제목 시작 -->
	
			<table
				style="width: 99.85%; border-collapse: collapse !important; color: black; background: white; border: 1px solid black; font-size: 12px; font-family: malgun gothic, dotum, arial, tahoma;">
				<colgroup>
					<col style="width: 90px;">
					<col style="width: 710px;">
				</colgroup>
			
			
				<tbody>
					<tr>
						<td
							style="padding: 3px; height: 25px; vertical-align: middle; border: 1px solid black; text-align: center; font-weight: bold;">
							제 &nbsp;&nbsp;&nbsp; 목</td>
						<td style="vertical-align: middle; padding: 7px 0 0 10px;"><input
							type="text" id="docName" name="docName" value="기안 신청합니다."
							style="font-size: 11pt; vertical-align: middle;">
							<div id="checkUrgent" style="float: right; margin-right: 10px">
								<span
									style="display: inline-block; font-weight: bold; margin: 10px;">긴급</span>
								<span> <!-- Rounded switch --> <label class="switch">
										<input type="checkbox" id="emergency" name="emergency" onclick="emergencyChk()"/> <span class="slider round"
										style="display: inline-block;"></span>
								</label>
								</span>
							</div></td>
					</tr>
	
					<!-- 제목 끝 -->
	
					<!-- 내용 시작 -->
	
					<!-- content 시작 -->
					<tr>
						<td
							style="padding: 3px; height: 350px; vertical-align: top; border: 1px solid black;"
							colspan="2">
							<textarea name="docContent" id="docContent" rows="30"
								cols="100" style="width: 100%; height: 500px;">기안 내용입니다.
							</textarea>
						</td>
					</tr>
					<!-- content 종료 -->
					<%-- === 파일첨부 타입 추가하기 === --%>
			         <tr>
			            <th style="padding: 3px; height: 30px; text-align: center; border: 1px solid black; font-weight: bold">파일첨부</th>
			            <td style="padding: 0 10px">
			               <input type="file" name="uploadFile" />       
			            </td>
			         </tr>
			         
				</tbody>
			</table> <!-- 내용 끝 -->
			
			<p id="submitArea">
       		<button id="cancel" type="button" onclick="javascript:history.back()" style="width: 100px" class="btn btn-danger m-l-20 btn-rounded btn-outline hidden-xs hidden-sm waves-effect waves-light">
       			취소</button>		
			 <button id="btnWrite" type="submit" style="width: 100px" class="btn btn-info m-l-20 btn-rounded btn-outline hidden-xs hidden-sm waves-effect waves-light">
			 	상신</button>
			</p>		
			
		</form>
		</div>
		</div>
		<!-- ------------------------------------------------------------------------------------------------------------------------- -->



   </div>

		
	                  
	                  <%-- 추가 시작--%>
	                  <div class="addArea">
	                     <div>
	                        <div class="move_wrap">
	                           <ul class="addListGroup" style="padding-left: 10px;">
	                              <li class="addList">
	                                 <span class="btn_bg addMidApprover" style="display: inline-block; margin: 50px 0; width: 80px; font-size: 10pt; text-align: center;">
	                                    중간결재자
	                                 </span>
	                              </li>
	                              <li class="addList">
	                                 <span class="btn_bg addFinApprover" style="display: inline-block; margin: 50px 0; width: 80px; font-size: 10pt; text-align: center;">
	                                    최종결재자
	                                 </span>            
	                              </li>                     
	                           </ul>
	                        </div>
	                     </div>
	                  </div>   
	                  <%-- 추가 끝--%>
	                  
	                  <%-- 결재자 시작--%>  
	                  <div id="approvers" style="width: 300px; padding: 30px 0 ;display: flex; flex-direction: column; flex: auto;">
	                  
		                  <div class="approver_wrap" style="margin-left: 15px; display: inline-block; flex:auto;">
		                      <div id="midApprover" class="approver_list">
		                          <span class="title">중간 결재자</span>
		                          <ul id="midApprListGroup">
		                              <!-- 비어있는 li 네개 지우면 안됨 -->
		                              <li class="midApprLists" value="1"></li>
		                              <li class="midApprLists"></li>
		                              <li class="midApprLists"></li>
		                              <li class="midApprLists"></li>
		                          </ul>
		                      </div>
		                  </div>
		                  <%-- 받는 사람 끝--%>                
		               
		                <%-- 받는 사람 시작--%>  
		                  <div class="approver_wrap" style="margin-left: 15px; display: inline-block;">
		                      <div id="finApprover" class="approver_list">
		                          <span class="title">최종 결재자</span><span style="color: red">*</span>
		                          <ul id="finApprListGroup">
		                              <!-- 비어있는 li 네개 지우면 안됨 -->
		                              <li class="finApprLists" value="1"></li>
		                              <li class="finApprLists"></li>
		                              <li class="finApprLists"></li>
		                              <li class="finApprLists"></li>
		                          </ul>
		                      </div>
		                  </div>
	                  </div>
	                  <%-- 결재자 끝--%>          
	               
	            </div>
	            
	         
	            
	            
	                        
	      <%-- findEmpList.jsp --%>               
	      
	     <%-- modal-body 끝 --%>
	     <div class="modal-footer">
	        <button type="button" class="btn btn-info" style="border-radius: 3px;"
	                onclick="findEmpOk()">확인</button>
	        <button type="button" class="btn btn-secondary" data-dismiss="modal" style="border-radius: 3px;" onclick="
	            window.location.reload()">취소</button>
	      </div>
	  