<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>
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
		// $(this).val()은 "1" 또는 "2" 또는 "3" 이다.
		var docSortTitle="";
		var html=""
		
		if ($(this).val()==1) {
			docSortTitle += "일반품의서";
			html +="<input type='hidden' name='docContent' value='none' />"+
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
	
	
	
	
	<%-- === 스마트 에디터 구현 시작 === --%>
    //전역변수
    var obj = [];
    
    //스마트에디터 프레임생성
    nhn.husky.EZCreator.createInIFrame({
        oAppRef: obj,
        elPlaceHolder: "content",
        sSkinURI: "<%= request.getContextPath() %>/resources/smarteditor/SmartEditor2Skin.html",
        htParams : {
            // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
            bUseToolbar : true,            
            // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
            bUseVerticalResizer : true,    
            // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
            bUseModeChanger : true,
        }
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
        
		
		<%-- === 스마트에디터 구현 시작 === --%>
        //스마트에디터 사용시 무의미하게 생기는 p태그 제거
        var contentval = $("#content").val();
	        
        // === 확인용 ===
        // alert(contentval); // content에 내용을 아무것도 입력치 않고 쓰기할 경우 알아보는것.
        // "<p>&nbsp;</p>" 이라고 나온다.
        
        // 스마트에디터 사용시 무의미하게 생기는 p태그 제거하기전에 먼저 유효성 검사를 하도록 한다.
        // 글내용 유효성 검사 
        if(contentval == "" || contentval == "<p>&nbsp;</p>") {
        	alert("글내용을 입력하세요!!");
        	return;
        }
        
        // 스마트에디터 사용시 무의미하게 생기는 p태그 제거하기
        contentval = $("textarea#content").val().replace(/<p><br><\/p>/gi, "<br>"); //<p><br></p> -> <br>로 변환
    /*    
              대상문자열.replace(/찾을 문자열/gi, "변경할 문자열");
        ==> 여기서 꼭 알아야 될 점은 나누기(/)표시안에 넣는 찾을 문자열의 따옴표는 없어야 한다는 점입니다. 
                     그리고 뒤의 gi는 다음을 의미합니다.

        	g : 전체 모든 문자열을 변경 global
        	i : 영문 대소문자를 무시, 모두 일치하는 패턴 검색 ignore
    */    
    	contentval = contentval.replace(/<\/p><p>/gi, "<br>"); //</p><p> -> <br>로 변환  
    	contentval = contentval.replace(/(<\/p><br>|<p><br>)/gi, "<br><br>"); //</p><br>, <p><br> -> <br><br>로 변환 
    	contentval = contentval.replace(/(<p>|<\/p>)/gi, ""); //<p> 또는 </p> 모두 제거시
    
        $("textarea#content").val(contentval);
     	// alert(contentval); 	        
        <%-- === 스마트에디터 구현 끝 === --%>
        
    	// 폼(form) 을 전송(submit)
		var frm = document.addFrm;
		frm.method = "POST";
		frm.action = "newApproval.dc";
		frm.submit();   
    }); 
	
    
    ////////////주소록시작//////////////
   	
    
       // ====== 조직도 js ====== //
      $.fn.extend({
             treed: function (o) {
               
               var openedClass = 'glyphicon-minus-sign';
               var closedClass = 'glyphicon-plus-sign';
               
               if (typeof o != 'undefined'){
                 if (typeof o.openedClass != 'undefined'){
                 openedClass = o.openedClass;
                 }
                 if (typeof o.closedClass != 'undefined'){
                 closedClass = o.closedClass;
                 }
               };
               
                 //initialize each of the top levels
                 var tree = $(this);
                 tree.addClass("tree");
                 tree.find('li').has("ul").each(function () {
                     var branch = $(this); //li with children ul
                     branch.prepend("<i class='indicator glyphicon " + closedClass + "'></i>");
                     branch.addClass('branch');
                     branch.on('click', function (e) {
                         if (this == e.target) {
                             var icon = $(this).children('i:first');
                             icon.toggleClass(openedClass + " " + closedClass);
                             $(this).children().children().toggle();
                         }
                     })
                     branch.children().children().toggle();
                 });
                 
                 //fire event from the dynamically added icon
	             tree.find('.branch .indicator').each(function(){
	               $(this).on('click', function () {
	                   $(this).closest('li').click();
	               });
	             });

                 //fire event to open branch if the li contains an anchor instead of text
                 tree.find('.branch>a').each(function () {
                     $(this).on('click', function (e) {
                         $(this).closest('li').click();
                         e.preventDefault();
                     });
                 });
                 
                 //fire event to open branch if the li contains a button instead of text
                 tree.find('.branch>button').each(function () {
                     $(this).on('click', function (e) {
                         $(this).closest('li').click();
                         e.preventDefault();
                     });
                 });
             }
         });

      //Initialization of treeviews

      $('#tree1').treed();

      $('#tree2').treed({openedClass:'glyphicon-folder-open', closedClass:'glyphicon-folder-close'});

      $('#tree3').treed({openedClass:'glyphicon-chevron-right', closedClass:'glyphicon-chevron-down'});    
       
      // ====== 주소록 모달창 js 끝 ====== // 
     
      
      // ====== 조직도에서 팀이름 클릭 했을때 ====== //
      $("li.orgName").each(function(){
         $(this).click(function(){
            var fk_dept_no = $(this).val();
            // alert("클릭한 조직 이름의 value 값은? ==> " + fk_dept_no);
            
            // sessionStorage.setItem("fk_dept_no", fk_dept_no);
            // var fk_dept_noVal = sessionStorage.getItem("fk_dept_no");
            
            console.log("타입" + typeof(fk_dept_no)); // number 
            
            $.ajax({ 
               url:"<%= ctxPath %>/elecapproval/writeAddAddress.os",
               // data: {"fk_dept_no" : fk_dept_noVal},
               data: {"fk_dept_no" : fk_dept_no},
               dataType:"json",
               success:function(json) {
                  
                  var html = "";
                     if(json.length > 0) {
                        $.each(json, function(index, item){
                        
                           html += "<tr>";   
                           html += "<td style='width: 40px; height: 10px; padding-left:2px;'> ";
                           html += "<input type='checkbox' name='chkbox' class='"+ index + "'>";
                           html += "</td>";
                           html += "<td style='width: 80px; height: 10px; padding-left:2px;' class='emp_name'>";
                           html += item.emp_name;
                           html += "</td>";
                           html += "<td style='width: 80px; height: 10px; padding-left:2px;' class='position_name'>";
                           html += item.position_name;
                           html += "</td>";   
                           html += "<td style='width: 80px; height: 10px; padding-left:2px;' class='dept_name'>";
                           html += item.dept_name;
                           html += "</td>";    
                           html += "<td style='width: 80px; height: 10px; padding-left:2px;' class='emp_no'>";
                           html += item.emp_no;
                           html += "</td>";   
                           html += "</tr>";   

                        });
                        
                        
                        $("tbody#empListTbody").html(html);
                        
                     }
                  
               },
                 error: function(request, status, error){
                   alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
                }
               
            });      
            
            
            var emp_name = $(".emp_name").text();
            var position_name = $(".position_name").text();
            var dept_name = $(".dept_name").text();
            var emp_no = $(".emp_no").text();
            
            console.log("사원명 ==> " + emp_name);
            console.log("직급명 ==> " + position_name);
            console.log("부서명 ==> " + dept_name);
            console.log("사원번호 ==> " + emp_no);
                                    
            
         });
      });   
      
      
      
      
      // ====== 주소록에서 중간결재자, 최종결재자 버튼 클릭했을 때 ====== // 
      
      
      
      /////////////////////중간결재자 버튼 클릭////////////////////////////
       $(document).on("click","span.addMidApprover",function() {      
    	   
    	 //체크된 체크박스의 갯수를 구할 수 있음.      
           console.log("length: "+$("input[name=chkbox]:checked").length);
           
           var chkCount = $("input[name=chkbox]:checked").length;
           
           // 체크된 Row의 값을 가져온다.
           var rowData = new Array();
           var tdArr = new Array();
           var checkbox = $("input[name=chkbox]:checked");

           var empList = new Array();
           
           var resultEmpList = "";
           
           var resultEmpListTemp = "";
           
           // 체크된 체크박스 값을 가져온다
           checkbox.each(function(i) {
     
              // checkbox.parent() : checkbox의 부모는 <td>이다.
              // checkbox.parent().parent() : <td>의 부모이므로 <tr>이다.
              var tr = checkbox.parent().parent().eq(i);
              var td = tr.children();
              
              // 체크된 row의 모든 값을 배열에 담는다.
              rowData.push(tr.text().trim());
              
              // td.eq(0)은 체크박스 이므로  td.eq(1)의 값부터 가져온다.
              var emp_name = td.eq(1).text().trim();
              var position_name = td.eq(2).text().trim();
              var dept_name = td.eq(3).text().trim();
              var emp_no = td.eq(4).text().trim(); //  + "\n"; // 엔터 추가
              
              // 가져온 값을 배열에 담는다.(객체 형태로 담는다. [{} ,{}] 형태 )
              empList.push({emp_name: emp_name
                         ,position_name: position_name
                         ,dept_name: dept_name
                         ,emp_no: emp_no
              });
              
              // 배열 반복문, 사원 리스트 중복 값 체크 및 두번재 요소부터 엔터 값 적용하기
              $.each(empList, function(index, item){
                   
                 // console.log("$.each의 empList 결과는무엇?==? " + item.emp_name);
                 // console.log("$.each의 empList 결과는무엇?==? " + item.position_name);
                 // console.log("$.each의 empList 결과는무엇?==? " + item.dept_name);
                 // console.log("$.each의 empList 결과는무엇?==? " + item.emp_no);
                 
                 // 사원 리스트 중복 값 체크를 위한 temp 변수(체크한 내용이 다 들어가있는 변수)
                 resultEmpListTemp = item.emp_name + "/" + item.position_name + "/" +item.dept_name + "/" +item.emp_no;
                 
                 // 누적값과 temp와 비교
                 if(resultEmpList.indexOf(resultEmpListTemp) == -1 ) {
                 
                    if(index == 0) { 
                       resultEmpList += item.emp_name + "/" + item.position_name + "/" +item.dept_name + "/" +item.emp_no;
                    }
                    else { // 첫번째 요소가 아닐때만 사원명 앞에 엔터값 추가
                       resultEmpList += "\n" + item.emp_name + "/" + item.position_name + "/" +item.dept_name + "/" +item.emp_no;;
                    }
                 }
                   
              });
              
           }); // 체크박스 반복
           
           
           // 첫번째 행에 문자열 넣기 (결과값)
           $(".midApprLists").eq(0).text(resultEmpList);
           
         
      }); //중간결재자 버튼클릭 끝
      
      
      
      
      ////////////////최종결재자 버튼 클릭/////////////////////
      $(document).on("click","span.addFinApprover",function() {         
    	  
         //체크된 체크박스의 갯수를 구할 수 있음.      
         console.log("length: "+$("input[name=chkbox]:checked").length);
         
         var chkCount = $("input[name=chkbox]:checked").length;
         
         // 체크된 Row의 값을 가져온다.
         var rowData = new Array();
         var tdArr = new Array();
         var checkbox = $("input[name=chkbox]:checked");

         var empList = new Array();
         
         var resultEmpList = "";
         
         var resultEmpListTemp = "";
         
         // 체크된 체크박스 값을 가져온다
         checkbox.each(function(i) {
   
            // checkbox.parent() : checkbox의 부모는 <td>이다.
            // checkbox.parent().parent() : <td>의 부모이므로 <tr>이다.
            var tr = checkbox.parent().parent().eq(i);
            var td = tr.children();
            
            // 체크된 row의 모든 값을 배열에 담는다.
            rowData.push(tr.text().trim());
            
            // td.eq(0)은 체크박스 이므로  td.eq(1)의 값부터 가져온다.
            var emp_name = td.eq(1).text().trim();
            var position_name = td.eq(2).text().trim();
            var dept_name = td.eq(3).text().trim();
            var emp_no = td.eq(4).text().trim(); //  + "\n"; // 엔터 추가
            
            // 가져온 값을 배열에 담는다.(객체 형태로 담는다. [{} ,{}] 형태 )
            empList.push({emp_name: emp_name
                       ,position_name: position_name
                       ,dept_name: dept_name
                       ,emp_no: emp_no
            });
            
            // 배열 반복문, 사원 리스트 중복 값 체크 및 두번재 요소부터 엔터 값 적용하기
            $.each(empList, function(index, item){
                 
               // console.log("$.each의 empList 결과는무엇?==? " + item.emp_name);
               // console.log("$.each의 empList 결과는무엇?==? " + item.position_name);
               // console.log("$.each의 empList 결과는무엇?==? " + item.dept_name);
               // console.log("$.each의 empList 결과는무엇?==? " + item.emp_no);
               
               // 사원 리스트 중복 값 체크를 위한 temp 변수(체크한 내용이 다 들어가있는 변수)
               resultEmpListTemp = item.emp_name + "/" + item.position_name + "/" +item.dept_name + "/" +item.emp_no;
               
               // 누적값과 temp와 비교
               if(resultEmpList.indexOf(resultEmpListTemp) == -1 ) {
               
                  if(index == 0) { 
                     resultEmpList += item.emp_name + "/" + item.position_name + "/" +item.dept_name + "/" +item.emp_no;
                  }
                  else { // 첫번째 요소가 아닐때만 사원명 앞에 엔터값 추가
                     resultEmpList += "\n" + item.emp_name + "/" + item.position_name + "/" +item.dept_name + "/" +item.emp_no;;
                  }
               }
                 
            });
            
         }); // 체크박스 반복
         
         
         // 첫번째 행에 문자열 넣기 (결과값)
         $(".finApprLists").eq(0).text(resultEmpList);
         
      }); // 최종결재자 버튼 클릭 끝

    
    ////////////주소록끝//////////////
    
    
	}); // end of $(document).ready(function(){})----------------
   

// ====== 주소록에서 확인 버튼 눌렀을때 ====== //  
   function findEmpOk() {
      
	///////////////////////중간결재자부분처리//////////////////////////////////
	// 넣은 문자열 추출
      var data_mid = $(".midApprLists").eq(0).text();
      
      // 엔터를 구분자를 기준으로 잘라서 배열 만들기 
      var arrData_mid = data_mid.split("\n");
      
      // 사원번호 얻기
      var empnoExtract_mid = "";
      var arrEmpno_mid = [];
      
      var empPositionExtract_mid = "";
      var arrEmpPosition_mid = [];
      
      var empDeptExtract_mid = "";
      var arrEmpDept_mid = [];
      
      // 사원명 얻기
      var empNameExtract_mid = ""; 
      var arrEmpName_mid = [];     
      
      // 배열 반복문 출력
      arrData_mid.forEach(function(item, index, arr){
          //최과장/과장/인사/2019003 
	    	  
	       // 사원명
	       empNameExtract_mid = arr[index].indexOf('/'); // 배열[index]의 첫번째 /의 위치를 구한다. 
	       arrEmpName_mid.push(arr[index].slice(0, empNameExtract_mid)); // slice : 0번째부터 empNameExtract 앞까지 추출
	
	       // 직급
	       empPositionExtract_mid = arr[index].indexOf('/',empNameExtract_mid+1);
	       arrEmpPosition_mid.push(arr[index].slice(empNameExtract_mid+1, empPositionExtract_mid)); // slice : empNameExtract+1번째부터 empPositionExtract 앞까지 추출
	
	       // 부서명
	       empDeptExtract_mid = arr[index].indexOf('/', empPositionExtract_mid+1);
	       arrEmpDept_mid.push(arr[index].slice(empPositionExtract_mid+1, empDeptExtract_mid)); // slice : empPositionExtract+1번째부터 empDeptExtract 앞까지 추출
	
	       // 사원번호
	       empnoExtract_mid = arr[index].lastIndexOf('/'); // 배열[index]의 마지막 /의 위치를 구한다. 
	       arrEmpno_mid.push(arr[index].slice(empnoExtract_mid+1));
	         
         
      });
      
      
   	  // 사원명
      for(var i=0; i<arrEmpName_mid.length; i++) {
         console.log("배열 " + i + "=> " + arrEmpName_mid[i]);
         
      }
      
      // 직급
      for(var i=0; i<arrEmpPosition_mid.length; i++) {
         console.log("배열 " + i + "=> " + arrEmpPosition_mid[i]);
         
      } 
      
   	  // 부서명
      for(var i=0; i<arrEmpDept_mid.length; i++) {
          console.log("배열 " + i + "=> " + arrEmpDept_mid[i]);
          
       }    
   	  
      // 사원번호
      for(var i=0; i<arrEmpno_mid.length; i++) {
          console.log("배열 " + i + "=> " + arrEmpno_mid[i]);
          
       }    
      
      // 배열을 문자열로 바꾸기
      
      var strEmpName_mid = arrEmpName_mid.join(",");
      var strEmpPosition_mid = arrEmpPosition_mid.join(",");
      var strEmpDept_mid = arrEmpDept_mid.join(",");
      var strEmpno_mid = arrEmpno_mid.join(",");
      
      console.log("마지막 arrEmpName_mid 추출을 문자열로 만들기  =====> " + strEmpName_mid);
      // 강과장,남과장

      console.log("마지막 strEmpPosition_mid 추출을 문자열로 만들기  =====> " + strEmpPosition_mid);

      console.log("마지막 strEmpDept_mid 추출을 문자열로 만들기  =====> " + strEmpDept_mid);

      console.log("마지막 arrEmpno_mid 추출을 문자열로 만들기  =====> " + strEmpno_mid);
      // 2020013,2020019
      
    
      // 빋는 사람 태그 내에 value 넣기
      $("input#fk_fin_approver_no_name_mid").val(strEmpName_mid); // 사원명
      $("input#fk_fin_approver_no_dept_mid").val(strEmpDept_mid); // 부서
      $("input#fk_fin_approver_no_position_mid").val(strEmpPosition_mid); // 직급
      $("input#fk_mid_approver_no").val(strEmpno_mid); // 사원번호
	
	///////////////////////최종결재자부분처리//////////////////////////////////
      // 넣은 문자열 추출
      var data = $(".finApprLists").eq(0).text();
      
      console.log("ul 태그에서 읽어온 data 값 ==> " + data);
    
      // 엔터를 구분자를 기준으로 잘라서 배열 만들기 
      var arrData = data.split("\n");
      
      console.log("\n를 기준으로 자른결과 ==> " + arrData);
      // console.log("타입" + typeof(arrData)); // Object 
      
      // 사원번호 얻기
      var empnoExtract = "";
      var arrEmpno = [];
      
      var empPositionExtract = "";
      var arrEmpPosition = [];
      
      var empDeptExtract = "";
      var arrEmpDept = [];
      
      // 사원명 얻기
      var empNameExtract = ""; 
      var arrEmpName = [];     
      
      // 배열 반복문 출력
      arrData.forEach(function(item, index, arr){
          //최과장/과장/인사/2019003 
    	  
         // 사원명
         empNameExtract = arr[index].indexOf('/'); // 배열[index]의 첫번째 /의 위치를 구한다. 
         arrEmpName.push(arr[index].slice(0, empNameExtract)); // slice : 0번째부터 empNameExtract 앞까지 추출

         // 직급
         empPositionExtract = arr[index].indexOf('/',empNameExtract+1);
         arrEmpPosition.push(arr[index].slice(empNameExtract+1, empPositionExtract)); // slice : empNameExtract+1번째부터 empPositionExtract 앞까지 추출

         // 부서명
         empDeptExtract = arr[index].indexOf('/', empPositionExtract+1);
         arrEmpDept.push(arr[index].slice(empPositionExtract+1, empDeptExtract)); // slice : empPositionExtract+1번째부터 empDeptExtract 앞까지 추출

         // 사원번호
         empnoExtract = arr[index].lastIndexOf('/'); // 배열[index]의 마지막 /의 위치를 구한다. 
         arrEmpno.push(arr[index].slice(empnoExtract+1));
         
         
         
      });
      
      
   	  // 사원명
      for(var i=0; i<arrEmpName.length; i++) {
         console.log("배열 " + i + "=> " + arrEmpName[i]);
         
      }
      
      // 직급
      for(var i=0; i<arrEmpPosition.length; i++) {
         console.log("배열 " + i + "=> " + arrEmpPosition[i]);
         
      } 
      
   	  // 부서명
      for(var i=0; i<arrEmpDept.length; i++) {
          console.log("배열 " + i + "=> " + arrEmpDept[i]);
          
       }    
   	  
      // 사원번호
      for(var i=0; i<arrEmpno.length; i++) {
          console.log("배열 " + i + "=> " + arrEmpno[i]);
          
       }    
      
      // 배열을 문자열로 바꾸기
      
      var strEmpName = arrEmpName.join(",");
      var strEmpPosition = arrEmpPosition.join(",");
      var strEmpDept = arrEmpDept.join(",");
      var strEmpno = arrEmpno.join(",");
      
      console.log("마지막 arrEmpName 추출을 문자열로 만들기  =====> " + strEmpName);
      // 강과장,남과장

      console.log("마지막 strEmpPosition 추출을 문자열로 만들기  =====> " + strEmpPosition);

      console.log("마지막 strEmpDept 추출을 문자열로 만들기  =====> " + strEmpDept);

      
      console.log("마지막 arrEmpno 추출을 문자열로 만들기  =====> " + strEmpno);
      // 2020013,2020019
      
    
      // 받는 사람 태그 내에 value 넣기
      $("input#fk_fin_approver_no_name").val(strEmpName); // 사원명
      $("input#fk_fin_approver_no_dept").val(strEmpDept); // 부서
      $("input#fk_fin_approver_no_position").val(strEmpPosition); // 직급
      $("input#fk_fin_approver_no").val(strEmpno); // 사원번호
           
      $('.modal').modal('hide'); // 확인버튼 누르자 마자 모달창 숨기기
   }
   
	// '긴급' 체크시 값넣기 (체크된경우 1, 체크해지시 0)
	function emergencyChk(){
		if($("input#emergency").is(":checked") == true ){
			$("input#emergency").val('1');
		}
			
		if( $("input#emergency").is(":checked") == false ){
			$("input#emergency").val('0');
		}
		
	}
	   
	function getDate(){
		var d = new Date();
		
		var mm; 
		if( (d.getMonth() + 1) < 10 ) {
			mm = '0'+(d.getMonth() + 1);
		}else {
			mm = (d.getMonth() + 1) 
		}
		
		var dd;
		if( d.getDate() < 10 ) {
			dd = '0'+ d.getDate();
		}else {
			dd = d.getDate();
		}
		
		var dateText = d.getFullYear() + '-' + mm + '-' +  dd;
		$("#date").text(dateText);
	}
	
	
</script>

<div id="titleInBox" style="font-weight: bold; font-size: 19px;">새 결재 진행</div>
<div id="containerBox">

	<form name="addFrm"  enctype="multipart/form-data">
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
							<select name="formNum" id="approvalSort" class="form-control pull-right row b-none"
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
					<td class="tblElecApprInfo">${sessionScope.loginUser.mName}</td>
				</tr>
				</tbody>
			</table>
			<!-- *** session에서 로그인유저값 받아서 넣을것*** -->
			<%-- <input type="hidden" name="fk_emp_no" value="${sessionScope.loginuser.userid}" /> --%>
			<input type="hidden" name="drafterMId" value="${sessionScope.loginUser.mName}" />
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
						<input type="text" name="approvalMId" id="approvalMId"  style="width:50%; margin-left:10px; margin-right: 1%; border-radius:3px; border: 1px solid #adb5bd; " /> 
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
					<th style="width: 22%;">직급</th>
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
							colspan='2'><span id="docSortTitle">문서종류</span></td>
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
							<span id="date"
							name="docCreateDate" style='font-family: &amp; amp; quot; malgun gothic&amp;amp; quot; , dotum , arial, tahoma; font-size: 9pt;' ></span>
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
							type="text" id="docName" name="docName"
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
								cols="100" style="width: 100%; height: 412px;">
									
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
			
			
			
		</form>
		<!-- ------------------------------------------------------------------------------------------------------------------------- -->


		<p id="submitArea">
       		<button id="cancel" type="button" onclick="javascript:history.back()" style="width: 100px" class="btn btn-danger m-l-20 btn-rounded btn-outline hidden-xs hidden-sm waves-effect waves-light">
       			취소</button>		
			 <button id="btnWrite" type="submit" id="btnWrite" style="width: 100px" class="btn btn-info m-l-20 btn-rounded btn-outline hidden-xs hidden-sm waves-effect waves-light">
			 	상신</button>
		</p>
   </div>

		<!-- ----------------------------------------------------------------주소록모달시작--------------------------------------------------------- -->


	<%-- 주소록 모달 --%>
	<!-- Modal -->
	<div id="findEmpListModal" class="modal fade" role="dialog" data-keyboard="false" data-backdrop="static">
	 <div class="modal-dialog" style="width: 1200px;">
	 
	   <!-- Modal content-->
	   <div class="modal-content">
	     <div class="modal-header" style="height: 60px;">
	       <button type="button" class="close" data-dismiss="modal" onclick="window.closeModal()"><span style="font-size: 26pt;">&times;</span></button>
	       <h3 class="modal-title" style="font-weight: bold">조직도 검색</h3>
	     </div>
	     <div class="modal-body">
	       <div id="employeeList" style="border: none; width: 100%; height: 470px;"><!-- style="border: none; width: 100%; height: 470px;"> -->
	             <%-- findEmpList.jsp --%>
	         <div class="empList_Popup" style="overflow-x:hidden;">
	             
	            <div class="content" >
	            
	               <div class="content_layout_address" style="margin-left : 40px;">
	                  <div id="tabArea" style="margin-left : -40px;">
	                     <ul class="tab_nav nav_layer" style="margin-bottom: 22px;">
	                        <li value="org">
	                           <span style="font-size: 12pt; font-weight: bold;">조직도</span>
	                        </li>
	                     </ul>
	                  </div>
	                  
	                  <div class="tabWrap father" style="margin-left : -1px; height: 400px;"> <!-- border: solid 5px yellow;"> -->
	                     <div class="father" style=" border : solid 1px #999; overflow-y:auto; width: 600px">
	                     <%-- 조직도 시작--%>
	                     <div class="container" style="padding-top:10px; width: 200px; border-right: solid 1px #999; "> <%-- border: solid 2px navy; " --%>
	                         <div class="row box" style="width: 200px; "> <%--border: solid 2px pink;" --%>
	                             <div class="col-md-4">
	                                 <ul id="tree1">
	                                     <li style="width:130px;">
	                                        <a href="#">CODEUS</a>         
	                                         <ul>
	                                             <li class="orgName" style="width:120px;" value="1">전략기획팀</li>
	                                             
	                                             <li class="orgName" style="width:120px;" value="2">경영지원팀
	                                                 <%-- 
	                                                 <ul>
	                                                     <li style="width:120px;">Reports
	                                                         <ul>
	                                                             <li>Report1</li>
	                                                             <li>Report2</li>
	                                                             <li>Report3</li>
	                                                         </ul>
	                                                     </li>
	                                                 </ul>
	                                                 --%>
	                                             </li>
	                                             <li class="orgName" value="3">인사팀</li>
	                                             <li class="orgName" value="4">회계팀</li>
	                                             <li class="orgName" value="5">영업팀</li>
	                                             <li class="orgName" value="6">마케팅팀</li>
	                                             <li class="orgName" value="7">IT팀</li>
	                                             
	                                         </ul>
	                                     </li>
	                                 </ul>
	                             </div>
	                     </div>
	                  </div>
	                  <%-- 조직도 끝--%>
	                  
	                  <%-- 사원리스트 시작--%>
	                  <div class="content_list box">
	                     <div class="search_wrap">
	                        <form class="emp_search">
	                           <input id="searchWord" class="search" type="text" placeholder="이름,부서">
	                            <button type="button" class="btn btn-info btnSearch" style="border-radius: 3px; color: white;">검색</button>   
	                        </form>  
	                     </div>
	                     <div class="scroll_wrap" style="height: 360px;">
	                        <table style="width: 396px; height: 366px; border: 0px; overflow-y:auto;">
	                           <thead style="padding:0;">
	                              <tr style="text-align: left; background: #efefef; font-weight: normal;">
	                                   <th style="padding-left:2px;">
	                                      <input type="checkbox" name="checkAll" id="checkAll">
	                                   </th>
	                                   <th style="padding-left:2px;">이름</th>
	                                   <th style="padding-left:2px;">직위</th>
	                                   <th style="padding-left:2px;">부서</th>
	                                   <th style="padding-left:2px;">사원ID</th>
	                               </tr>
	                           </thead>
	            
	                           <tbody style="height: 300px; " id="empListTbody">
	                              <c:forEach var="emp" items="${empAllList}" varStatus="status">
	                                       <tr style="height: 20px;" id="empRow" class="${status.index}">
	                                           <td style="width: 40px; height: 10px; padding-left:2px;"> 
	                                              <input type="checkbox" name="chkbox" class="check${status.index}">
	                                           </td>
	                                           <td style="width: 80px; height: 10px; padding-left:2px;" id="emp_name">
	                                              ${emp.emp_name}
	                                           </td>
	                                           <td style="width: 50px; height: 10px; padding-left:2px;" id="position_name">
	                                              ${emp.position_name}
	                                           </td>
	                                           <td style="width: 80px; height: 10px; padding-left:2px;" id="dept_name">
	                                              ${emp.dept_name}
	                                           </td>
	                                           <td style="width: 120px; height: 10px; padding-left:2px;" id="emp_no">
	                                              ${emp.emp_no}
	                                           </td>
	                                       </tr>                          
	                                   </c:forEach>                                    
	                            </tbody>               
	                        </table>
	                     </div>
	                  
	                  </div>
	                  <%-- 사원리스트 끝--%>
	                  
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
	            
	         
	            
	            </div>
	            </div>
	         </div>               
	      <%-- findEmpList.jsp --%>               
	       </div>
	     </div>
	     <%-- modal-body 끝 --%>
	     <div class="modal-footer">
	        <button type="button" class="btn btn-info" style="border-radius: 3px;"
	                onclick="findEmpOk()">확인</button>
	        <button type="button" class="btn btn-secondary" data-dismiss="modal" style="border-radius: 3px;" onclick="
	            window.location.reload()">취소</button>
	      </div>
	   </div>
	
	 </div>
	</div>
	</form>
	</div>
	</div>
</div>