<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>회의실 예약 - 예약 하기 </title>
    <!-- Pick date -->
    <link rel="stylesheet" href="${contextPath}/resources/assets/vendor/pickadate/themes/default.css">
    <link rel="stylesheet" href="${contextPath}/resources/assets/vendor/pickadate/themes/default.date.css">
    <!-- Custom Stylesheet -->
    <link href="${contextPath}/resources/assets/css/style.css" rel="stylesheet">
    <style>
        #chkMsg {
            color: black;
        }
    </style>
</head>

<body>

    <!--**********************************
        Main wrapper start
    ***********************************-->
    <div id="main-wrapper">	

		<c:import url="../common/menubar.jsp"/>
    
        <!--**********************************
            Content body start
        ***********************************-->
        <div class="content-body">
            <div class="container-fluid">
                <div class="row page-titles mx-0">
                    <div class="col-sm-6 p-md-0">
                        <div class="welcome-text">
                            <h4>예약 신청</h4>
                        </div>
                    </div>
                    <div class="col-sm-6 p-md-0 justify-content-sm-end mt-2 mt-sm-0 d-flex">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item">회의실 예약</li>
                            <li class="breadcrumb-item active"><a href="mrlist.mr">예약 목록</a></li>
                            <li class="breadcrumb-item active"><a href="mrinsertview.mr">예약 신청</a></li>
                        </ol>
                    </div>
                </div>
                <!-- row -->
                <div class="row">
                    <div class="col-lg-12">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">예약 정보 입력</h4>
                            </div>
                            <div class="card-body">
                                <div class="form-validation">
                                    <form class="form-valide" action="mrinsert.mr" method="post" onsubmit="return insertValidate();">
                                        <div class="row">
                                            <div class="col-xl-6">
                                                <div class="form-group row">
                                                    <label class="col-lg-4 col-form-label" for="mName">사원명</label>
                                                    <div class="col-lg-6">
                                                        <input type="text" class="form-control" id="mName" name="mName" value="${ loginUser.mName != NULL ? loginUser.mName : '-' }" readonly>
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <label class="col-lg-4 col-form-label" for="email">이메일</label>
                                                    <div class="col-lg-6">
                                                        <input type="text" class="form-control" id="email" name="email" value="${ loginUser.email != NULL ? loginUser.email : '-' }" readonly>
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <label class="col-lg-4 col-form-label" for="jobName">직위</label>
                                                    <div class="col-lg-6">
                                                        <input type="text" class="form-control" id="jobName" name="jobName" value="${ loginUser.jobName != NULL ? loginUser.jobName : '-' }" readonly>
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <label class="col-lg-4 col-form-label" for="deptName">부서</label>
                                                    <div class="col-lg-6">
                                                        <input type="text" class="form-control" id="deptName" name="deptName" value="${ loginUser.deptName != NULL ? loginUser.deptName : '-' }" readonly>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xl-6">
                                                <div class="form-group row">
                                                    <label class="col-lg-4 col-form-label" for="r_date">예약날짜
                                                        <span class="text-danger">*</span>
                                                    </label>
                                                    <div class="col-lg-6 input-group datepicker">
                                                        <input name="datepicker" class="datepicker-default form-control" id="r_date" required> <span class="input-group-append"><span class="input-group-text"><i
                                                                    class="fa fa-calendar-o"></i></span></span>
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <label class="col-lg-4 col-form-label" for="r_start_time">시작시간
                                                        <span class="text-danger">*</span>
                                                    </label>
                                                    <div class="col-lg-6">
                                                        <select class="form-control" id="r_start_time" name="r_start_time" required></select>
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <label class="col-lg-4 col-form-label" for="r_end_time">종료시간
                                                        <span class="text-danger">*</span>
                                                    </label>
                                                    <div class="col-lg-6">
                                                        <select class="form-control" id="r_end_time" name="r_end_time" required></select>
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <label class="col-lg-4 col-form-label" for="r_room">회의실
                                                        <span class="text-danger">*</span>
                                                    </label>
                                                    <div class="col-lg-6">
                                                        <select class="form-control" id="r_room" name="r_room" required></select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xl-12">
                                                <div class="form-group row">
                                                    <label class="col-lg-2 col-form-label" for="r_content">예약목적
                                                        <span class="text-danger">*</span>
                                                    </label>
                                                    <div class="col-lg-10 form-group">
                                                        <textarea class="form-control" rows="6" id="r_content" name="r_content" placeholder="- 사용 목적 : &#13;&#10;&#13;&#10;- 사용 인원 : " required></textarea>
                                                    </div>
                                                </div>
                                                <div class="d-flex justify-content-end">
                                                    <!-- 버튼 -->
                                                    <button type="button" class="btn btn-primary btn-sm mr-2" data-toggle="modal" data-target="#basicModal" onclick="lastCheck();">신청하기</button>
                                                    <button type="button" class="btn btn-outline-primary btn-sm" onclick="location.href='mrlist.mr'">돌아가기</button>
                                                    <!-- Modal -->
                                                    <div class="modal fade" id="basicModal">
                                                        <div class="modal-dialog" role="document">
                                                            <div class="modal-content">
                                                                <div class="modal-header">
                                                                    <h5 class="modal-title">회의실 예약 신청 확인</h5>
                                                                    <button type="button" class="close" data-dismiss="modal"><span>&times;</span>
                                                                    </button>
                                                                </div>
                                                                <div class="modal-body" id="chkMsg"></div>
                                                                <div class="modal-footer">
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
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
          
    </div>
    <!--**********************************
        Main wrapper end
    ***********************************-->
    
    
	    <!--**********************************
	        Scripts
	    ***********************************-->
    <!-- Required vendors -->
    <script src="${contextPath}/resources/assets/vendor/global/global.min.js"></script>
    <script src="${contextPath}/resources/assets/js/quixnav-init.js"></script>
    <script src="${contextPath}/resources/assets/js/custom.min.js"></script>



    <!-- Daterangepicker -->
    <!-- momment js is must -->
    <script src="${contextPath}/resources/assets/vendor/moment/moment.min.js"></script>
    <script src="${contextPath}/resources/assets/vendor/bootstrap-daterangepicker/daterangepicker.js"></script>
    <!-- pickdate -->
    <script src="${contextPath}/resources/assets/vendor/pickadate/picker.js"></script>
    <script src="${contextPath}/resources/assets/vendor/pickadate/picker.time.js"></script>
    <script src="${contextPath}/resources/assets/vendor/pickadate/picker.date.js"></script>
    <script src="${contextPath}/resources/assets/vendor/pickadate/translations/ko_KR.js"></script>
    <!-- pickadate 옵션 수정 : 오늘 날짜 이후 + 주중만 선택 가능 -->
    <script>
        jQuery.extend(jQuery.fn.pickadate.defaults,{format: "yyyy-mm-dd", formatSubmit: "yyyy-mm-dd", disable: [1, 7], min: "0"});
    </script>



    <!-- Pickdate -->
    <script src="${contextPath}/resources/assets/js/plugins-init/pickadate-init.js"></script>

    <!-- Jquery Validation -->
    <script src="${contextPath}/resources/assets/vendor/jquery-validation/jquery.validate.min.js"></script>
    <!-- Form validate init -->
    <script src="${contextPath}/resources/assets/js/plugins-init/jquery.validate-init.js"></script>

    <script>
        /********** 사용할 변수 정의 **********/
        var isDateUsable = false;       // 예약날짜 입력값 사용 가능 여부
        var inputDate = null;           // 예약날짜 입력값
        
        var isTimeUsable = false;       // 예약시간 입력값 사용 가능 여부
        var inputStartTime = null;      // 예약시간 시작 입력값
        var inputEndTime = null;        // 예약시간 종료 입력값
        
        var isRoomUsable = false;       // 예약 회의실 입력값 사용 가능 여부
        var inputRoom = null;           // 예약 회의실 입력값(val)
        var inputRoomName = null;       // 예약 회의실 입력값(text)
        
        var isContentUsable = false;    // 예약목적 입력값 사용 여부
        var inputContent = null;        // 예약목적 입력값
        
        var isEmpty = function(value) { // 입력값이 비어있는 지 확인하는 함수
            if(value == "" || value == null || value == undefined || (value != null && typeof value == "object" && !Object.keys(value).length))
                return true;
            else
                return false;
        }
        
        
        
        
        
        /********** 1. 예약날짜 선택 **********/
        var $input = $('#r_date').pickadate();
        var picker = $input.pickadate('picker');
        
        $('#r_date').on('propertychange change keyup paste input', function() {
            inputDate = picker.get('select', 'yyyy-mm-dd');
        });
        
        $("#r_date").change(function() {
            if(!isEmpty(inputDate))
                isDateUsable = true;
        });
        
        
        
        
        
        /********** 2. 예약시간 선택 **********/
        var r_startTime = ['09:00', '09:30', '10:00', '10:30', '11:00', '11:30', '12:00', '12:30', '13:00', '13:30', '14:00', '14:30', '15:00', '15:30', '16:00', '16:30', '17:00', '17:30'];
        var r_endTime = ['09:30', '10:00', '10:30', '11:00', '11:30', '12:00', '12:30', '13:00', '13:30', '14:00', '14:30', '15:00', '15:30', '16:00', '16:30', '17:00', '17:30', '18:00'];
        
        $('#r_start_time').one('click', function() {
            for(var i = 0; i < r_startTime.length; i++) {
                $('#r_start_time').append('<option value="' + r_startTime[i] + '">' + r_startTime[i] + '</option>');
            }
            
            for(var i = 0; i < r_startTime.length; i++) {
                if($('#r_start_time').val() == r_startTime[i]) {
                    for(; i < r_endTime.length; i++) {
                        $('#r_end_time').append('<option value="' + r_endTime[i] + '">' + r_endTime[i] + '</option>');
                    }
                }
            }
            
            inputStartTime = $('#r_start_time').val();
            inputEndTime = null;
            isTimeUsable = false;
        }).on('change paste input', function() {
            if(!isEmpty($('#r_start_time').val())) {
                $('#r_end_time').empty();
                
                for(var i = 0; i < r_startTime.length; i++) {
                    if($('#r_start_time').val() == r_startTime[i]) {
                        for(; i < r_endTime.length; i++) {
                            $('#r_end_time').append('<option value="' + r_endTime[i] + '">' + r_endTime[i] + '</option>');
                        }
                    }
                }
            }
            
            inputStartTime = $('#r_start_time').val();
            inputEndTime = null;
            isTimeUsable = false;
        });
        
        $('#r_end_time').one('click', function() {
            inputEndTime = $('#r_end_time').val();
            
            $('#r_room').empty();
            inputRoom = null;
            inputRoomName = null;
            
            isRoomUsable = false;
        }).on('change paste input', function() {
            inputEndTime = $('#r_end_time').val();
            
            $('#r_room').empty();
            inputRoom = null;
            inputRoomName = null;
            
            isRoomUsable = false;
        });
        
        $('#r_end_time').on('change paste input', function() {
            if(!isEmpty(inputStartTime) && !isEmpty(inputEndTime))
                isTimeUsable = true;
        });
        
        
        
        
        
        /********** 3. 예약할 회의실 **********/
        $('#r_end_time').on('click change paste input', function() {
            $.ajax({
                url: "mrcheckrooms.mr",
                dataType: 'json',
                data: {inputDate:inputDate, inputStartTime:inputStartTime, inputEndTime:inputEndTime},
                success: function(data) {
                    console.log(data);
                    
                    $select = $('#r_room');
                    $select.find('option').remove();
                    
                    for(var i in data) {
                        var $option = $('<option>');
                        $option.val(data[i].meet_no);
                        $option.text(data[i].meet_name);
                        
                        $select.append($option);
                    }
                },
                error: function(data) {
                    console.log(data);
                }
            });
        });
        
        $('#r_room').on('click change paste input', function() {
            inputRoom = $('#r_room').val();
            inputRoomName = $('#r_room option:selected').text();
            
            if(!isEmpty(inputRoom))
                isRoomUsable = true;
        });
        
        
        
        
        
        /********** 4. 예약목적 **********/
        $('#r_content').on('change keyup paste input', function() {
            inputContent = $('#r_content').val();
        });
        
        $('#r_content').change(function() {
            if(!isEmpty(inputContent) && inputContent.trim() != "")
                isContentUsable = true;
            else
                isContentUsable = false;
        });
        
        
        
        
        
        /********** 입력 정보 메세지 출력 **********/
        function lastCheck() {
            console.log(inputDate);
            console.log(isDateUsable);
            
            console.log(inputStartTime);
            console.log(inputEndTime);
            console.log(isTimeUsable);
            
            console.log(inputRoom);
            console.log(inputRoomName);
            console.log(isRoomUsable);
            
            console.log(inputContent);
            console.log(isContentUsable);
            
            $('#chkMsg').next().find('button').remove();
            var submitBtn = '<button type="submit" class="btn btn-primary">신청</button>';
            var dismissBtn1 = '<button type="button" class="btn btn-outline-primary" data-dismiss="modal">취소</button>';
            var dismissBtn2 = '<button type="button" class="btn btn-outline-primary" data-dismiss="modal">확인</button>';
            
            if(isDateUsable && isTimeUsable && isRoomUsable && isContentUsable) {
                $('#chkMsg').next().append(submitBtn).append(dismissBtn1);
                
                var chkMsg = '다음 입력 정보로 예약을 신청하시겠습니까?<br><br>';
                chkMsg = chkMsg + '<div class="input-group">\
                                      <div class="input-group-append">\
                                          <button class="btn btn-square btn-primary btn-xs">예약날짜</button>\
                                      </div>\
                                      <input type="text" class="form-control form-control-sm" value="' + inputDate + '" readonly>\
                                  </div><br>\
                                  <div class="input-group">\
                                      <div class="input-group-append">\
                                          <button class="btn btn-square btn-primary btn-xs">시작시간</button>\
                                      </div>\
                                      <input type="text" class="form-control form-control-sm" value="' + inputStartTime + '" readonly>\
                                  </div><br>\
                                  <div class="input-group">\
                                      <div class="input-group-append">\
                                          <button class="btn btn-square btn-primary btn-xs">종료시간</button>\
                                      </div>\
                                      <input type="text" class="form-control form-control-sm" value="' + inputEndTime + '" readonly>\
                                  </div><br>\
                                  <div class="input-group">\
                                      <div class="input-group-append">\
                                          <button class="btn btn-square btn-primary btn-xs">&nbsp;회&nbsp;의&nbsp;실&nbsp;</button>\
                                      </div>\
                                      <input type="text" class="form-control form-control-sm" value="' + inputRoomName + '" readonly>\
                                  </div><br>\
                                  <div class="input-group">\
                                      <div class="input-group-append">\
                                          <button class="btn btn-square btn-primary btn-xs">예약목적</button>\
                                      </div>\
                                      <input type="text" class="form-control form-control-sm" value="' + inputContent + '" readonly>\
                                  </div><br>';
                
                $('#chkMsg').html(chkMsg);
            } else {
                $('#chkMsg').next().append(dismissBtn2);
                
                var chkMsg = '미입력된 정보가 있습니다. 다음 필수 입력 정보를 다시 확인해주세요.<br><br>';
                
                if(!isDateUsable)
                    chkMsg = chkMsg + '<div class="input-group">\
                                           <div class="input-group-append">\
                                               <button class="btn btn-square btn-outline-primary btn-xs">예약날짜</button>\
                                           </div>\
                                           <input type="text" class="form-control form-control-sm" value="" readonly>\
                                       </div><br>';
                else
                    chkMsg = chkMsg + '<div class="input-group">\
                                           <div class="input-group-append">\
                                               <button class="btn btn-square btn-primary btn-xs">예약날짜</button>\
                                           </div>\
                                           <input type="text" class="form-control form-control-sm" value="' + inputDate + '" readonly>\
                                       </div><br>';
                
                if(isEmpty(inputStartTime))
                    chkMsg = chkMsg + '<div class="input-group">\
                                           <div class="input-group-append">\
                                               <button class="btn btn-square btn-outline-primary btn-xs">시작시간</button>\
                                           </div>\
                                           <input type="text" class="form-control form-control-sm" value="" readonly>\
                                       </div><br>';
                else
                    chkMsg = chkMsg + '<div class="input-group">\
                                           <div class="input-group-append">\
                                               <button class="btn btn-square btn-primary btn-xs">시작시간</button>\
                                           </div>\
                                           <input type="text" class="form-control form-control-sm" value="' + inputStartTime + '" readonly>\
                                       </div><br>';
                
                if(isEmpty(inputEndTime))
                    chkMsg = chkMsg + '<div class="input-group">\
                                           <div class="input-group-append">\
                                               <button class="btn btn-square btn-outline-primary btn-xs">종료시간</button>\
                                           </div>\
                                           <input type="text" class="form-control form-control-sm" value="" readonly>\
                                       </div><br>';
                else
                    chkMsg = chkMsg + '<div class="input-group">\
                                           <div class="input-group-append">\
                                               <button class="btn btn-square btn-primary btn-xs">종료시간</button>\
                                           </div>\
                                           <input type="text" class="form-control form-control-sm" value="' + inputEndTime + '" readonly>\
                                       </div><br>';
                
                if(!isRoomUsable)
                    chkMsg = chkMsg + '<div class="input-group">\
                                           <div class="input-group-append">\
                                               <button class="btn btn-square btn-outline-primary btn-xs">&nbsp;회&nbsp;의&nbsp;실&nbsp;</button>\
                                           </div>\
                                           <input type="text" class="form-control form-control-sm" value="" readonly>\
                                       </div><br>';
                else
                    chkMsg = chkMsg + '<div class="input-group">\
                                           <div class="input-group-append">\
                                               <button class="btn btn-square btn-primary btn-xs">&nbsp;회&nbsp;의&nbsp;실&nbsp;</button>\
                                           </div>\
                                           <input type="text" class="form-control form-control-sm" value="' + inputRoomName + '" readonly>\
                                       </div><br>';
                
                if(!isContentUsable)
                    chkMsg = chkMsg + '<div class="input-group">\
                                           <div class="input-group-append">\
                                               <button class="btn btn-square btn-outline-primary btn-xs">예약목적</button>\
                                           </div>\
                                           <input type="text" class="form-control form-control-sm" value="" readonly>\
                                       </div><br>';
                else
                    chkMsg = chkMsg + '<div class="input-group">\
                                           <div class="input-group-append">\
                                               <button class="btn btn-square btn-primary btn-xs">예약목적</button>\
                                           </div>\
                                           <input type="text" class="form-control form-control-sm" value="' + inputContent + '" readonly>\
                                       </div><br>';
                
                $('#chkMsg').html(chkMsg);
            }
        }
        
        
        
        
        
        /********** 입력 정보 최종 확인 **********/
        function insertValidate() {
            if(isDateUsable && isTimeUsable && isRoomUsable && isContentUsable)
                return true;
            else
                return false;
        }
    </script>
</body>

</html>