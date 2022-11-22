<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<title>월 근태 현황</title>
     <!-- fullcalendar CDN -->
    <link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css' rel='stylesheet' />
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js'></script>
    <!-- fullcalendar 언어 CDN -->
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/locales-all.min.js'></script>
</head>

<style>
	
	.multi-card {
		display: flex;
	    flex-wrap: wrap;
		justify-content: space-around;
    }

  .fc-header-toolbar {
    padding-top: 1em;
    padding-left: 1em;
    padding-right: 1em;
  }

  .first-card {
    width: 80%;
  }

  .second-card {
    height: 250px;
  }

</style>

<body>
<div id="app">

	<%@ include file="/WEB-INF/views/common/sidebar.jsp" %>

	<div id="main">
		<%@ include file="/WEB-INF/views/common/header.jsp" %>

		<div class="page-heading">
			<div class="page-title">
				<div class="row">
					<div class="col-12 col-md-6 order-md-1 order-last mb-3">
						<p class="text-subtitle">근태관리</p>
						<h3>월 근태 현황</h3>
					</div>
				</div>
			</div>
			<section class="section">
				<div class="multi-card">
					<div class="card first-card">
						<div class="card-body">
                <div id='calendar-container'>
                    <div id='AttendanceCal'></div>
                </div>
						</div>
					</div>
					<div class="card second-card">
						<div class="card-body flex-col">
							<div id="month">${monthCnt.month}</div>
                  <div class="text-part">
                      <span>출근 횟수 : &ensp;</span>
                      <span id="workCount"> ${monthCnt.workCount} </span>
                  </div>
                  <div class="text-part">
                      <span>지각 횟수 : &ensp;</span>
                      <span id="lateCount"> ${monthCnt.lateCount} </span>
                  </div>
                  <div class="text-part">
                      <span>조퇴 횟수 : &ensp;</span>
                      <span id="earlyoutCount"> ${monthCnt.earlyoutCount} </span>
                  </div>
                  <div class="text-part">
                      <span>휴가 사용 : &ensp;</span>
                      <span id="offCount"> ${monthCnt.offCount} </span>
                  </div>
						</div>
					</div>
				</div>

			</section>
		</div>
		
    </div>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</div>
</body>
<script>
	
	$().ready(function() {
		$('#att-month').addClass("active");
		$('#att-part').css("display", "block");
	});
	
</script>
<script>

   $(function(){
     var calendarEl = $('#AttendanceCal')[0];
     var calendar = new FullCalendar.Calendar(calendarEl, {
       height: '700px',
       expandRows: true,
       headerToolbar: {
         left: 'today',
         center: 'title',
         right: 'prev,next'
       },
       initialView: 'dayGridMonth',
       navLinks: false,
       editable: false,
       selectable: false,
       nowIndicator: true,
       dayMaxEvents: true,
       eventBorderColor: 'none',
       locale: 'ko',
       events: function(info, successCallback, failureCallback) {
    	   var month = info.start;
		   var monthStr = month.toISOString();
		  
		   $.ajax({
			   url: '${root}/att/month',
			   type: 'POST',
			   data: {'month' : monthStr},
			   success: function(res) {
				   var events = [];
		  			
		  			$.each(res, function(index, data){
		  				if(data.statusName == "휴가"){
		  					events.push({
			  					title : data.statusName,
			  					start : data.inDate,
			  					end : data.outDate
			  				});
		  				}else {
		  					events.push({
			  					title : data.statusName,
			  					start : data.inDate
			  				});
		  					events.push({
			  					title : "출근",
			  					start : data.inDate + "T" + data.inTime
			  				});
			  				events.push({
			  					title : "퇴근",
			  					start : data.inDate + "T" + data.outTime
			  				});
		  				}
		  			});
		  			successCallback(events);
		   		}
	   		});
		   
		    $.ajax({
		    	url: '${root}/att/monthCnt',
		    	type: 'POST',
		    	data: {'month' : monthStr},
		    	success: function(vo) {
		    		document.getElementById("month").innerHTML = vo.month;
					document.getElementById("workCount").innerHTML = vo.workCount;
					document.getElementById("lateCount").innerHTML = vo.lateCount;
					document.getElementById("earlyoutCount").innerHTML = vo.earlyoutCount;
					document.getElementById("offCount").innerHTML = vo.offCount;
		    	},
		    	error: function(e) {
		    		console.log(e);
		    	}
		    });
	   },
       eventDidMount: function(info){
    	   if(info.event.title == '정상 근무') {
    		   info.el.style.backgroundColor = 'green';
    		   info.el.style.border = 'green';
    	   } else if (info.event.title == '휴가' || info.event.title == '반차') {
    		   info.el.style.backgroundColor = 'orange';
    		   info.el.style.border = 'orange';
    	   } else if(info.event.title == '조퇴' ) {
    		   info.el.style.backgroundColor = 'skyblue';
    		   info.el.style.border = 'skyblue';
    	   } else if(info.event.title == '야근') {
    		   info.el.style.backgroundColor = 'gray';
    		   info.el.style.border = 'gray';
    	   } else {
    		   info.el.style.backgroundColor = 'white';
    		   info.el.style.border = 'white';
    	   }
       }
     });

     calendar.render();
   });		
   
</script>

<link rel="stylesheet" href="${root}/resources/css/attendance.css">
</html>