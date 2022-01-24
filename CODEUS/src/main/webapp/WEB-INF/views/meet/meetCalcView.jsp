<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>회의실 예약 - 예약 캘린더 </title>
    <link href="${contextPath}/resources/assets/vendor/fullcalendar/css/fullcalendar.min.css" rel="stylesheet">
    <link href="${contextPath}/resources/assets/css/style.css" rel="stylesheet">
    
    <style type="text/css">
        
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
                            <h4>회의실 예약 캘린더</h4>
                        </div>
                    </div>
                    <div class="col-sm-6 p-md-0 justify-content-sm-end mt-2 mt-sm-0 d-flex">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item">회의실 예약</li>
                            <li class="breadcrumb-item active"><a href="mrcalview.mr">예약 캘린더</a></li>
                        </ol>
                    </div>
                </div>
                <!-- row -->


                <div class="row">
                    <div class="col-lg-12">
                        <div class="card">
                            <div class="card-body">
                                <div id="calendar" class="app-fullcalendar"></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-12">
                        <div class="d-flex justify-content-end">
                            <span class="badge badge-success">예약 완료</span>
                            <span class="badge badge-secondary">사용 완료</span>
                            <span class="badge badge-warning">예약 취소</span>
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



    <script src="${contextPath}/resources/assets/vendor/jqueryui/js/jquery-ui.min.js"></script>
    <script src="${contextPath}/resources/assets/vendor/moment/moment.min.js"></script>

    <script src="${contextPath}/resources/assets/vendor/fullcalendar/js/fullcalendar.min.js"></script>
    <script src="${contextPath}/resources/assets/js/plugins-init/fullcalendar-init.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@3.10.0/dist/locale/ko.js"></script>
    
    <script>
        $('#calendar').fullCalendar('destroy');
        var uId = '${ loginUser.mId }';
        
        $('#calendar').fullCalendar({
            locale: 'ko',
            lang: 'ko',
            header: {
                left: 'prev,next today',
                center: 'title',
                right: 'month,list'
            },
            themeSystem: 'bootstrap4',
            height: 'parent',
            timeFormat: 'HH:mm',
            handleWindowResize: false,
            displayEventEnd: true,
            eventLimit: true,
            events: function(start, end, timezone, callback) {
                $.ajax({
                    url: 'mrcal.mr',
                    dataType: 'json',
                    success: function(data) {
                        console.log(data);
                        
                        var events = [];
                        
                        $.each(data, function(index, item) {
                            if(data.length > 0) {
                                events.push({
                                    title: item.meet_name + ' / ' + item.mName,
                                    start: item.rev_start_time,
                                    end: item.rev_end_time,
                                    id: item.rev_no,
                                    color: item.rev_status == 0 ? '#71d540' : (item.rev_status == 1 ? '#6e32b3' : '#ffad33'),
                                    url: item.mId != uId ? ('mrdetail.mr?rNo=' + item.rev_no + '&page1=1') : ('mrupdateview.mr?rNo=' + item.rev_no + '&page2=1')
                                });
                            }
                        });
                        
                        callback(events);
                    },
                    error: function(data) {
                        console.log(data);
                    }
                });
            },
            eventRender: function(event, element) {
                element.css('font-size', '0.9em');
                element.css('padding', '1px');
                element.css('font-weight', 'lighter');
            }
        });
        
        $('#calendar').fullCalendar('render');
    </script>

</body>

</html>