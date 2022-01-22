<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>


<style type="text/css">

	#table, th, td, input, textarea {border: solid #a0a0a0 1px;}
   
   #table {border-collapse: collapse;
          width: 1175px;
          }
   #table th, #table td{padding: 5px;}
   #table th{ 
         background-color: #6F808A; 
         color: white;
   }
       /* 주소록 CSS 시작 */
      .content_layout_address {
         width: 980px;
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
       cursor: pointer;
       height: 40px;
       line-height: 40px;
       font-size: 13px;
       color: #999;   
       
         list-style-type: none;      
   }
   
   .tab_nav li:first-child {
         margin: 0;
   }
   
   .ul_state_active {
   
          border-bottom: 1px solid #000;
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
   .addArea {
         margin-top: 147px;
   }
   .addList, li {
         list-style-type: none;
   }
   div.receive_wrap div.receive_list ul {
       border: 1px solid #666;
       height: 105px;
       overflow-x: hidden;
       background: #f9f9f9;
       padding: 0 4px;
   } 
   div.receive_wrap div.receive_list {
       display: inline-block;
       margin: 10px 0 0 0;
       width: 270px;
       height: 135px;
   }
      /* 주소록 CSS 끝 */
	
	.titleBox{
		background-color: white;
		padding: 15px;
	}
	
	.titleBox h2{
		margin: 0;
		font-weight: bold;
		color: #6a6a69;
	}
	
	.container{
		background-color: white;
		margin: 0 auto;
		margin-top: 2%;
		width: 97%;
	}
	
	
	.table-borderless > tbody > tr > td,
	.table-borderless > tbody > tr > th,
	.table-borderless > tfoot > tr > td,
	.table-borderless > tfoot > tr > th,
	.table-borderless > thead > tr > td,
	.table-borderless > thead > tr > th {
	    border: none;
	}
	
	.chip {
	  display: inline-block;
	  padding: 0 20px;
	  padding-top: 0.4%;
	  height: 25px;
	  font-size: 12px;
	  border-radius: 25px;
	  background-color: #f1f1f1;
	}
	
	.choiceAtd{
		cursor: pointer;
	}
	
	.blueBtn{
		border-radius: 4px;
		background-color: #0F4C81;
		color: white;
	}
	
	.grayBtn{
		border-radius: 4px;
		background-color: #D8D8D8;
		color: gray;
	}
	
	.redBtn{
		border-radius: 4px;
		background-color: #d53641;
		color: white;
	}

</style>

<script type="text/javascript">
	
	//전체 모달 닫기(전역함수인듯)
	window.closeModal = function(){
	    $('.modal').modal('hide');

	};

	$(document).ready(function() {

		addSch();	// 내 캘린더 불러오기
		//selectAtd();	// 참석자 불러오기
		
		// select 값 변경
		$("input.addSchSelect").val("${cal.scheType}").change();

		// datepicker에 db에서 받아온 시작, 끝 날짜 넣어주기
		$("input[name=startday]").val("${ cal.scheStartDate }".substring(0, 10));
		$("input[name=endday]").val("${ cal.scheEndDate }".substring(0, 10));
		console.log("${ cal.scheStartDate }");
		// 일정이 종일일 경우
		if ( ${ bAllday eq 1 } ) {
			$("input[name=allday]").prop("checked", true);
			$("select.startday_hour").val("${ cal.scheStartString }".substring(11, 16)).change();
			$("select.endday_hour").val("${ cal.scheEndString }".substring(11, 16)).change();	// 종일이면 23:59까지 끊기기 때문에 startday와 endday는 같게 둠
		}else{
			$("input[name=allday]").prop("checked", false);
			$("select.startday_hour").val("${ cal.scheStartString }".substring(11, 16)).change();
			$("select.endday_hour").val("${ cal.scheEndString }".substring(11, 16)).change();
			console.log($("select.endday_hour").val());
		}
		
		// ====== 주소록 모달창 js 시작 ====== // 
	       
	       // ====== 주소록 상단 탭 클릭 한 요소 CSS 적용시키기 ====== //
	      $(".tab_nav li").click(function(event){
	         
	         $(this).addClass("ul_state_active");
	         $(".tab_nav li").not($(this)).removeClass("ul_state_active");
	         
	         
	      });
	      
	      <%-- 주소록 모달:시작 --%>
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
	            
	            // 검색어 비우기 
	             $("input#searchWord").val("");
	            
	            var fk_dept_no = $(this).val();
	            
	            // sessionStorage.setItem("fk_dept_no", fk_dept_no);
	            // var fk_dept_noVal = sessionStorage.getItem("fk_dept_no");
	            
	            $.ajax({ 
	               url:"<%= request.getContextPath() %>/canlendar/writeAddAddress.ca",
	               // data: {"fk_dept_no" : fk_dept_noVal},
	               data: {"deptId" : deptId},
	               dataType:"json",
	               success:function(json) {
	                  
	                  var html = "";
	                     if(json.length > 0) {
	                        $.each(json, function(index, item){
	                        
	                        html += "<tr>";   
	                          html += "<td style='width: 40px; height: 10px; padding-left:2px;'> ";
	                          html += "<input type='checkbox' name='chkbox' class='"+ index + "'>";
	                          html += "</td>";
	                           html += "<td style='width: 80px; height: 10px; padding-left:2px;' class='mName'>";
	                           html += item.mName;
	                           html += "</td>";
	                           html += "<td style='width: 80px; height: 10px; padding-left:2px;' class='jobId'>";
	                           html += item.jobId;
	                           html += "</td>";   
	                           html += "<td style='width: 80px; height: 10px; padding-left:2px;' class='deptId'>";
	                           html += item.deptId;
	                           html += "</td>";    
	                           html += "<td style='width: 80px; height: 10px; padding-left:2px;' class='mId'>";
	                           html += item.mId;
	                           html += "</td>";   
	                           html += "</tr>";   

	                        });
	                        
	                        
	                        $("tbody#empListTbody").html(html);
	                        
	                     }
	               },
	                 error: function(request, status, error){
	                   alert("7에러 code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	                }
	               
	            });      
	            
	         });
	      });   
	      
	      // ====== 주소록 모달창 내에서 사원 검색하는 버튼 클릭(사원명 또는 부서 검색) ====== // 
	      $(document).on("click", "button#btnEmpSearchOk", function(){

	         // 입력되어있는 검색어 구하기 
	         var searchWord = $("input#searchWord").val().trim();
	         
	         if(searchWord == "") {
	            alert("검색어를 입력하세요!");
	            return false;
	         }
	         
	           $.ajax({
	               url : '<%= request.getContextPath() %>/writeAddressSearch.ca',
	               data : {"searchWord" : searchWord},
	               dataType : 'JSON',
	               success : function(json){
	                  var html = "";
	                  if(json.length > 0) {
	                     $.each(json, function(index, item){

	                     html += "<tr>";   
	                       html += "<td style='width: 40px; height: 10px; padding-left:2px;'> ";
	                       html += "<input type='checkbox' name='chkbox' class='"+ index + "'>";
	                       html += "</td>";
	                        html += "<td style='width: 80px; height: 10px; padding-left:2px;' >";
	                        html += item.mName;
	                        html += "</td>";
	                        html += "<td style='width: 80px; height: 10px; padding-left:2px;' >";
	                        html += item.jobId;
	                        html += "</td>";   
	                        html += "<td style='width: 80px; height: 10px; padding-left:2px;' >";
	                        html += item.deptId;
	                        html += "</td>";    
	                        html += "<td style='width: 80px; height: 10px; padding-left:2px;' >";
	                        html += item.mId;
	                        html += "</td>";   
	                        html += "</tr>";   
	                  
	                     });
	                     
	                     
	                     $("tbody#empListTbody").html(html);
	                     
	                  }       
	                  else {
	                     
	                     
	                     html += "<tr>";   
	                     html += "<td colspan='5' style='height: 20px; text-align: center;'> 검색어와 일치한 사원이 없습니다. </td>"
	                     html += "</tr>";
	                     
	                     $("tbody#empListTbody").html(html);
	                  }
	               },
	              error: function(request, status, error){
	                   alert("1에러 code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	            }
	           });

	      });      
	      
	      // ====== 주소록에서 사원목록 전체 선택 or 해제 했을때 하위 사윈 전체 선택 or 해제 ====== //
	      $(document).on("click", "input#checkAll", function() {
	                  
	         if($(this).prop("checked")) {
	            $("input[name=chkbox]").prop("checked", true);
	         }
	         else {
	            $("input[name=chkbox]").prop("checked", false);
	         }
	      });
	      
	      
	      // ====== 주소록에서 사원버튼 클릭했을 때 ====== // 
	      $(document).on("click","span.addUser",function() {         
	         
	         //체크된 체크박스의 갯수를 구할 수 있음.      
	         var chkCount = $("input[name=chkbox]:checked").length;
	         
	         // 체크된 Row의 값을 가져온다.
	         var rowData = new Array();
	         var tdArr = new Array();
	         var checkbox = $("input[name=chkbox]:checked");

	         var mList = new Array();
	         
	         var resultMList = "";
	         
	         var resultMListTemp = "";
	         
	         // 체크된 체크박스 값을 가져온다
	         checkbox.each(function(i) {
	   
	            // checkbox.parent() : checkbox의 부모는 <td>이다.
	            // checkbox.parent().parent() : <td>의 부모이므로 <tr>이다.
	            var tr = checkbox.parent().parent().eq(i);
	            var td = tr.children();
	            
	            // 체크된 row의 모든 값을 배열에 담는다.
	            rowData.push(tr.text().trim());
	            
	            // td.eq(0)은 체크박스 이므로  td.eq(1)의 값부터 가져온다.
	            var mName = td.eq(1).text().trim();
	            var jobId = td.eq(2).text().trim();
	            var deptId = td.eq(3).text().trim();
	            var mId = td.eq(4).text().trim(); //  + "\n"; // 엔터 추가
	            
	            // 가져온 값을 배열에 담는다.(객체 형태로 담는다. [{} ,{}] 형태 )
	            mList.push({mName: mName
	                       ,jobId: jobId
	                       ,deptId: deptId
	                       ,mId: mId
	            });
	            
	            // 배열 반복문, 사원 리스트 중복 값 체크 및 두번재 요소부터 엔터 값 적용하기
	            $.each(mList, function(index, item){
	                 
	               // console.log("$.each의 empList 결과는무엇?==? " + item.emp_name);
	               // console.log("$.each의 empList 결과는무엇?==? " + item.position_name);
	               // console.log("$.each의 empList 결과는무엇?==? " + item.dept_name);
	               // console.log("$.each의 empList 결과는무엇?==? " + item.emp_no);
	               
	               // 사원 리스트 중복 값 체크를 위한 temp 변수(체크한 내용이 다 들어가있는 변수)
	               resultMListTemp = item.mName + "/" + item.jobId + "/" +item.deptId + "/" +item.mId;
	               
	               // 누적값과 temp와 비교
	               if(resultMList.indexOf(resultMListTemp) == -1 ) {
	               
	                  if(index == 0) { 
	                	  resultMList += item.mName + "/" + item.jobId + "/" +item.deptId + "/" +item.mId;
	                  }
	                  else { // 첫번째 요소가 아닐때만 사원명 앞에 엔터값 추가
	                	  resultMList += "\n" + item.mName + "/" + item.jobId + "/" +item.deptId + "/" +item.mId;
	                  }
	               }
	                 
	            });

	         }); // 체크박스 반복
	         
	         
	         // 첫번째 행에 문자열 넣기 (결과값)
	         $(".empAddLists").eq(0).text(resultMList);
	         
	      }); // 버튼 클릭 끝
	      <%-- 주소록 모달:끝 --%>

	});
	
	<%-- 주소록 모달 버튼 이벤트리스너:시작 --%>
	// ====== 주소록에서 확인 버튼 눌렀을때 ====== //  
	  function findEmpOk() {
	     
	     // 넣은 문자열 추출
	     var data = $(".empAddLists").eq(0).text();

	     // 엔터를 구분자를 기준으로 잘라서 배열 만들기 
	     var arrData = data.split("\n");

	     // 사원번호 얻기
	     var empnoExtract = "";
	     var arrEmpno = [];
	     
	     // 사원명 얻기
	     var empNameExtract = ""; 
	     var arrEmpName = [];     
	     
	     // 배열 반복문 출력
	     arrData.forEach(function(item, index, arr){
	          
	        // 사원번호
	        empnoExtract = arr[index].lastIndexOf('/'); // 배열[index]의 마지막 /의 위치를 구한다. 
	        // arrDeptno += arr[index].slice(deptnoExtract+1) + ","; // 마지막 / 의 다음부터 끝까지 추출해서 새로운 arrDeptno 배열에 담는다.
	        // console.log("배열 요소 arrEmpno ===> " + arrEmpno); 
	        // 2020012,2020007,
	        
	        arrEmpno.push(arr[index].slice(empnoExtract+1));
	        
	        // 사원명
	        empNameExtract = arr[index].indexOf('/');
	        arrEmpName.push(arr[index].slice(0, empNameExtract)); // slice : 0번째부터 empNameExtract 앞까지 추출
	        
	     });

	     for(var i=0; i<arrEmpName.length; i++) {
	        //console.log("배열 " + i + "=> " + arrEmpName[i]);
	        
	     }
	     
	     for(var i=0; i<arrEmpno.length; i++) {
	       // console.log("배열 " + i + "=> " + arrEmpno[i]);
	        
	     }     
	     
	     // 배열을 문자열로 바꾸기
	     var strEmpno = arrEmpno.join(",");
	     
	     var strEmpName = arrEmpName.join(",");
	     
	     // 참석자 칸 초기화
	     $("td.atandee_td").html('<a data-toggle="modal" data-target="#findEmpListModal"><i class="fa fa-plus" style="padding: 0 10px;"> 참석자 선택</i></a>');
	     
	     // 선택한 사원이 있을 때만 실행
	     if (strEmpName != "") {
	    	 
	    	 var atdHtml = "";
		     $.each(arrEmpName, function(index, item){
		    	 
		    	 atdHtml += '<div class="chip" id="mId_name" style="margin-right: 0.5%;">';
		    	 atdHtml += item
		    	 atdHtml += '</div>';
		     });
		     
		     atdHtml += '<a data-toggle="modal" data-target="#findEmpListModal"><i class="fa fa-plus" style="padding: 0 10px;"> 참석자 선택</i></a>';
		     
		     $("td.atandee_td").html(atdHtml);
	     }
	     
	     $("input.mId").val(strEmpno); // 컨트롤러로 가져갈 사원번호(hidden)

	     $('.modal').modal('hide'); // 확인버튼 누르자 마자 모달창 숨기기
	  }
	  <%-- 주소록 모달:끝 --%>
	
	
	function addSch(){

		$.ajax({
			url:"<%= request.getContextPath() %>/readAdminCalList.ca",
			type:"get",
			dataType:"JSON",
			success:function(json){
				var html = "";
				if (json.length > 0) {
					$.each(json, function(index, item){
						var name = "";
						if (item.name.length > 8) {
							name = item.name.substring(0,8) + "...";
						}else{
							name = item.name;
						}
						
						// 해당 일정에 맞는 캘린더를 selected 해줌
						if("${cal.scheNo}" == item.calendar_no){
							html += "<option value='" + item.calendar_no + "' selected >" + item.name + "</option>";
						}else{
							html += "<option value='" + item.calendar_no + "'>" + item.name + "</option>";
						}
						
					});
				}else{
					html += "<li style='height: 20px;'> 캘린더를 생성해주세요.";
					html += "</li>";
				}
				
				$("input.addSchSelect").html(html);
			},
			error: function(request, status, error){
				alert("addSch error" +"\n" + "code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		 	}
		});
		
	  }
	
	// 일정등록에서 등록버튼을 클릭했을시 실행하는 함수
	  function addSchBtn(){
		  
		  // 입력받은 값들 유효성 검사: 시작

		  var title = $("input.title").val();
		  if (title.trim() == "") {
			  alert("일정명을 입력해주세요.");
			  $("input.title").focus();
			  return false;
		  }

		  var startday = $("input[name=startday]").val() + " " + $("select.startday_hour").val() + ":00";
		  var endday = "";
		  
		  // 종일 체크 시 시작 날짜를 기준으로 변경
		  if ($("input#allday:checked").val()) {
			  startday = $("input[name=startday]").val() + " 00:00:00";
			  endday = $("input[name=startday]").val() + " 21:00:00";
		  }else{
			  endday = $("input[name=endday]").val() + " " + $("select.endday_hour").val() + ":00";
		  }
		  
		  // true: 통과   false: 불통
		  if (!(startday < endday && startday != endday)) {
			  alert("올바른 일시를 선택해주세요.");
			  return false;
		  }

		  var scheType = $("input[name=scheType]").val();
// 		  if (scheType.trim() == "") {
// 			  alert("캘린더를 선택해주세요.");
// 			  return false;
// 		  }
		  
		  
		  var content = $("textArea[name=content]").val();
		  if (content.trim() == "") {
			  alert("일정내용을 입력해주세요.");
			  $("textArea[name=content]").focus();
			  return false;
		  }
		  var color = $("select[name=color]").val();

		// 입력받은 값들 유효성 검사: 끝
		
		
		// db에 넣기
		$.ajax({
			url:"<%= request.getContextPath() %>/addDetailSch.ca",
			data:{title:title, startday:startday, endday:endday, scheNo:scheNo, color:color, content:content, mId:mId},
			type:"POST",
			dataType:"JSON",
			success:function(json){
				
				if (json.result == 1) {
					location.href = "<%= request.getContextPath() %>/goCalendar.ca";
					
				}else if(json.result == 0){
					alert("일정등록에서 등록버튼을 클릭했을시DB 오류");
				}
				
			},
			error: function(request, status, error){
				alert("2에러 code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		 	}
		});
		  
	  }
	
	// 참가자 불러오는 함수
	function selectAtd(){
		
		$.ajax({
			url:"<%= request.getContextPath() %>/selectAtd.ca",
			data:{scheNo:"${cal.scheNo}"},
			type:"POST",
			dataType:"JSON",
			success:function(json){

				if (json.result != 0) {
					// 참석자 칸 초기화
				     $("td.atandee_td").html('<a class="choiceAtd" data-toggle="modal" data-target="#findEmpListModal"><i class="fa fa-plus" style="padding: 0 10px;"> 참석자 선택</i></a>');

			    	 var atdHtml = "";
			    	 var str = "";	// 처음 페이지에 들어왔을 때 참석자input에 넣어줄 회원번호
				     $.each(json, function(index, item){
				    	 
				    	 atdHtml += '<div class="chip" id="mId_name" style="margin-right: 0.5%;">';
				    	 atdHtml += item.mName
				    	 atdHtml += '</div>';
				    	 
				    	 str += item.fk_emp_no + ",";
				    	 
				     });
				     
				     str = str.substr(0, str.length -1);    
				     atdHtml += '<a class="choiceAtd" data-toggle="modal" data-target="#findEmpListModal"><i class="fa fa-plus" style="padding: 0 10px;"> 참석자 선택</i></a>';
				     
				     $("td.atandee_td").html(atdHtml);
				     $("input.mId").val(str);

				}else{
					alert("참가자 불러오는DB 오류");
				}
				
			},
			error: function(request, status, error){
				alert("3에러 code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		 	}
		});
		
	}
	
	// 삭제할 일정이 초대받은 일정인지 검사
	function checkInviteSch(type) {
		
		// type 1 삭제, 2 수정
		$.ajax({
			url:"<%= request.getContextPath() %>/checkDelInviteSch.ca",
			data:{ scheNo: "${ cal.scheNo }", scheType: "${cal.scheType}", title:"${ cal.scheTitle }", startday:"${ cal.scheStartString }", endday:"${ cal.scheEndString }", allday:"${ cal.allDayYn }", mId:"${ cal.mId }", content:"${ cal.scheContent }" },
			type:"POST",
			dataType:"JSON",
			success:function(json){

				if (json.result > 0) {
					console.log(json.result);
					if (type == 1) {
						delSchBtn();
					}else{
						editSchBtn();
					}
					location.href = "<%= request.getContextPath() %>/goCalendar.ca";
				}
				
			},
			error: function(request, status, error){
				console.log(json);
		 	}
		});
		
	}
	
	// 일정 삭제하는 함수(참석자로 묶인 일정들도 전부 함께 삭제)
	function delSchBtn() {
		console.log("진입");
		$.ajax({
			url:"delSch.ca",
			data: { scheNo: "${ cal.scheNo }", scheType: "${cal.scheType}", title:"${ cal.scheTitle }", startday:"${ cal.scheStartString }", endday:"${ cal.scheEndString }", allday:"${ cal.allDayYn }", mId:"${ cal.mId }", content:"${ cal.scheContent }" }, 
			type:"POST",
			dataType:"JSON",
			success:function(result){
				if(result == 1){
					location.href = "<%= request.getContextPath() %>/goCalendar.ca";
				} else{
					console.log(result)
				}
			},
			error: function(request, status, error){
				alert("5에러 code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		 	}
		});
		
	}
	
	// 일정을 수정하는 함수(참석자로 묶인 일정들도 전부 함께 수정)
	function editSchBtn() {
		
		// 입력받은 값들 유효성 검사: 시작

		  var title = $("input.title").val();
			console.log(title);
		  if (title.trim() == "") {
			  alert("일정명을 입력해주세요.");
			  $("input.title").focus();
			  return false;
		  }

		  var startday = $("input[name=startday]").val() + " " + $("select.startday_hour").val() + ":00";
		  var endday = "";
		  
		  // 종일 체크 시 시작 날짜를 기준으로 변경
		  if ($("input#allday:checked").val()) {
			  startday = $("input[name=startday]").val() + " 00:00:00";
			  endday = $("input[name=startday]").val() + " 21:00:00";
		  }else{
			  endday = $("input[name=endday]").val() + " " + $("select.endday_hour").val() + ":00";
		  }
		  
		  // true: 통과   false: 불통
		  if (!(startday < endday && startday != endday)) {
			  alert("올바른 일시를 선택해주세요.");
			  return false;
		  }

		  var scheType = $("input[name=scheType]").val();
// 		  if (scheType.trim() == "") {
// 			  alert("캘린더를 선택해주세요.");
// 			  return false;
// 		  }
		  
		  var content = $("textArea[name=content]").val();
		  if (content.trim() == "") {
			  alert("일정내용을 입력해주세요.");
			  $("textArea[name=content]").focus();
			  return false;
		  }
		  var color = $("select[name=color]").val();
		// 입력받은 값들 유효성 검사: 끝
		var scheNo = ${ cal.scheNo };
			console.log(scheNo);
		// db에 넣기
		$.ajax({
			url:"doEditSch.ca",
			data:{scheNo:scheNo, title:title, color:color, startday:startday, endday:endday, scheType:scheType, content:content, mId:"${ cal.mId }"},
			type:"POST",
			dataType:"JSON",
			success:function(json){
				if(json.result == 1 ){
					location.href = "<%= request.getContextPath() %>/goCalendar.ca";
				}else if(json.result == 0){
					alert("DB오류");
				}
				
			},
			error: function(request, status, error){
				alert("6에러 code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		 	}
		});
		
	}
	


	
	

</script>

</head>
<body>
	<c:import url="../common/menubar.jsp"/>
	<!--**********************************
	            Content body start
	***********************************-->
	<div class="content-body" >
	<div class="titleBox">
		<h2><i class="fa fa-calendar fa-fw" aria-hidden="true"></i>&nbsp;&nbsp;일정상세</h2>
	</div>
	<hr style="margin: 0; color: #9d9d9d;">

  <div class="container">
	<form name="addSchFrm">
		<input type="hidden" class="mId" />
		 <table class="table table-borderless">
	      <tbody>
	        <tr>
	          <th>일정명</th>
	          <td><input class="form-control title modal_input" maxlength="13" name="title" type="text" value="${ cal.scheTitle }" /></td>
	        </tr>
	        <tr>
	          <th>일시</th>
	          <td>
		          <input type="date" class="datepicker" name="startday">
		          <select class="startday_hour" style="width: 70px;">
					<c:set var="breakPoint" value="0" />
					<c:forEach var="i" begin="0" end="20">
					    <c:forEach var="j" begin="0" end="1">
					        <c:if test="${(i == 21) && (j == 1)}">    
					            <c:set var="breakPoint" value="1" />                                    
					        </c:if>
					        <c:if test="${breakPoint == 0}">                           
					            <option value="<fmt:formatNumber pattern="00" value="${i}" />:<fmt:formatNumber pattern="00" value="${j*30}" />">
					            <fmt:formatNumber pattern="00" value="${i}" />:<fmt:formatNumber pattern="00" value="${j*30}" /></option>                                                                            
					        </c:if>
					    </c:forEach>
					</c:forEach>
				</select>
				~
				<input type="date" class="datepicker" name="endday">
		          <select class="endday_hour" style="width: 70px;">
					<c:set var="breakPoint" value="0" />
					<c:forEach var="i" begin="0" end="21">
					    <c:forEach var="j" begin="0" end="0">
					        <c:if test="${(i == 22) && (j == 1)}">    
					            <c:set var="breakPoint" value="1" />                                    
					        </c:if>
					        <c:if test="${breakPoint == 0}">                           
					            <option value="<fmt:formatNumber pattern="00" value="${i}" />:<fmt:formatNumber pattern="00" value="${j*30}" />">
					            <fmt:formatNumber pattern="00" value="${i}" />:<fmt:formatNumber pattern="00" value="${j*30}" /></option>                                                                            
					        </c:if>
					    </c:forEach>
					</c:forEach>
				</select>
				
				<input type="checkbox" id="allday" name="allday" /><label for="allday">종일</label>
	          </td>
	        </tr>
	        
<!-- 	        <tr> -->
<!-- 	          <th>내 캘린더</th> -->
<!-- 	        </tr> -->
	        
	        <!-- selected -->
	        
	         <tr>
		          <th>색상</th>
		          <td>
		          		<select class="colorSelect form-control" name="color" style="width: 15%; height: 35px;">
		          			<option value="#6b51df" <c:if test ="${cal.color eq '#6b51df'}">selected="selected"</c:if>>보라색</option>
		          			<option value="green" <c:if test ="${cal.color eq 'green'}">selected="selected"</c:if>>초록색</option>
		          			<option value="red" <c:if test ="${cal.color eq 'red'}">selected="selected"</c:if>>빨간색</option>
		          			<option value="black" <c:if test ="${cal.color eq 'black'}">selected="selected"</c:if>>검정색</option>
		          		</select>
		          </td>
	        </tr>
	        
	        <tr>
<!-- 	          <th>일정등록자</th> -->
	          <td><input class="form-control title modal_input" maxlength="13" name="mId" type="hidden" value="${ cal.mId }" readonly/></td>
	        </tr>
	        
	        <tr>
	          <th>일정내용</th>
	          <td><textarea class="form-control modal_input" cols="30" rows="8" name="content" style="resize: none;" >${ cal.scheContent }</textarea></td>
	          <td><input type ="hidden" class="addSchSelect form-control" name="scheType" style="width: 30%; height: 35px;" value="${cal.scheType}"/></td>
	        </tr>
	        
	      </tbody>
	    </table>
		
		<div style="float: right;">
			<button class="btn redBtn" type="button" onclick="checkInviteSch(1)">일정 삭제</button>
			<button class="btn blueBtn" type="button" onclick="checkInviteSch(2)">수정</button>
		</div>
		<br style="clear: both;">
	   </form>
	</div>
	
	
	
	<%-- ---------------- 모달 ---------------- --%>
	
	<%-- 주소록 모달 --%>
<!-- Modal -->
<div id="findEmpListModal" class="modal fade" role="dialog" data-keyboard="false" data-backdrop="static">
 <div class="modal-dialog" style="width: 800px;">
 
   <div class="modal-content" style="width: 1150px;">
     <div class="modal-header" style="height: 60px;">
       <button type="button" class="close" data-dismiss="modal" onclick="window.closeModal()"><span style="font-size: 26pt;">&times;</span></button>
       <h3 class="modal-title" style="font-weight: bold">주소록</h3>
     </div>
     <div class="modal-body">
       <div id="employeeList" style="border: none; width: 100%; height: 470px;"><!-- style="border: none; width: 100%; height: 470px;"> -->
             <%-- findEmpList.jsp --%>
         <div class="empList_Popup" style="overflow-x:hidden;">
             
            <div class="content" >
            
               <div class="content_layout_address" style="margin-left : 60px;">
                  <div id="tabArea" style="margin-left : -40px;">
                     <ul class="tab_nav nav_layer" style="margin-bottom: 22px;">
                        
                     </ul>
                  </div>
                  
                  <div class="tabWrap father" style="margin-left : -1px; height: 400px;"> <!-- border: solid 5px yellow;"> -->
                     <div class="father" style=" border : solid 1px #999; overflow-y:auto;">
                     <%-- 조직도 시작--%>
                     <div class="container" style="padding-top:10px; width: 200px; border-right: solid 1px #999; "> <%-- border: solid 2px navy; " --%>
                         <div class="row box" style="width: 200px; "> <%--border: solid 2px pink;" --%>
                             <div class="col-md-4">
                                 <ul id="tree1">
                                     <li style="width:130px;">
                                        <a href="#">코드어스</a>         
                                         <ul>
                                             <li class="orgName" style="width:120px;" value="1">전략기획팀</li>
                                             
                                             <li class="orgName" style="width:120px;" value="2">경영지원팀
                                                 
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
                        	<input type="hidden">
                           <input id="searchWord" class="search" type="text" placeholder="이름,부서">
                            <button type="button" id="btnEmpSearchOk" class="btn btn-primary btnSearch" style="background-color: #00a1b9; border: solid 1px #00a1b9; border-radius: 3px; color: white;">검색</button>   
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
                              <c:forEach var="mem" items="${mSearchList}" varStatus="status">
                                       <tr style="height: 20px;" id="empRow" class="${status.index}">
                                           <td style="width: 40px; height: 10px; padding-left:2px;"> 
                                              <input type="checkbox" name="chkbox" class="check${status.index}">
                                           </td>
                                           <td style="width: 80px; height: 10px; padding-left:2px;" id="mName">
                                              ${mem.mName}
                                           </td>
                                           <td style="width: 50px; height: 10px; padding-left:2px;" id="jobId">
                                              ${mem.jobId}
                                           </td>
                                           <td style="width: 80px; height: 10px; padding-left:2px;" id="deptId">
                                              ${mem.deptId}
                                           </td>
                                           <td style="width: 120px; height: 10px; padding-left:2px;" id="mId">
                                              ${mem.mId}
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
                                 <span class="btn_bg addUser" style="display: inline-block; width: 50px; font-size: 10pt; ">
                                    사용자
                                 </span>            
                              </li>                     
                           </ul>
                        </div>
                     </div>
                  </div>   
                  <%-- 추가 끝--%>
                  
                  <%-- 받는 사람 시작--%>  
                  <div class="receive_wrap" style="margin-left: 15px; margin-top: 80px;">
                      <div id="mailReceive" class="receive_list">
                          <span class="title">받는사람</span>
                          <ul id="empAddListGroup">
                              <!-- 비어있는 li 네개 지우면 안됨 -->
                              <li class="empAddLists" value="1"></li>
                              <li class="empAddLists"></li>
                              <li class="empAddLists"></li>
                              <li class="empAddLists"></li>
                          </ul>
                      </div>
                  </div>
                  <%-- 받는 사람 끝--%>                
               
            </div>
            
            </div>
            </div>
         </div>               
      <%-- findEmpList.jsp --%>               
       </div>
     </div>
     <%-- modal-body 끝 --%>
     <div class="modal-footer">
        <button type="button" class="btn btn-primary" 
                style="background-color: #00a1b9; border-color: #00a1b9;" onclick="findEmpOk()">확인</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="
        	window.closeModal()">취소</button>
      </div>
   </div>

 </div>
</div>
</div>
<!--**********************************
	            Content body end
	***********************************-->

   <!--**********************************
            Footer start
        ***********************************-->
        <div class="footer">
            <div class="copyright">
                <p>Copyright © Designed &amp; Developed by <a href="#" target="_blank">CODEUS</a> 2021</p>
            </div>
        </div>
        <!--**********************************
            Footer end
        ***********************************-->

</body>
</html>