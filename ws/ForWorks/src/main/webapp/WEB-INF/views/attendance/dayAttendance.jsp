<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<title>일일근태</title>
</head>

<style>
	
	.multi-card {
		display: flex;
	    flex-wrap: wrap;
		justify-content: space-around;
    }
    
    #clock {
    	text-align: center;
		font-size: 1.5rem;
    	font-weight:700;
		color: #6f42c1;
		margin: 7px 15px;
    }

	.work-progress {
		display: flex;
	    flex-wrap: wrap;
		justify-content: flex-end;
	}

	.pg-part {
		width: 200px;
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
						<h3>일일근태 등록</h3>
					</div>
				</div>
			</div>
			<section class="section">
				<div class="multi-card">

					<div class="card">
						<div class="card-body flex-col">
							<div class="mt-2 mb-2">
								<span> ${team.name} </span>
							</div>
							<div class="mt-2 mb-2">
								<span>정규 출근 :&ensp;</span>
								<span> ${team.inTime} </span>
							</div>
							<div class="mt-2 mb-2">
								<span>정규 퇴근 :&ensp;</span>
								<span> ${team.outTime} </span>
							</div>
						</div>
					</div>
					
					<div class="card">
						<div class="card-body">
							<div id="clock">clock</div>
							<div class="multi-card">
								<div class="align-center">
									<div class="mt-3 mb-2">
										<span>출근&ensp;</span>
										<span> ${workTime.inTime} </span>
									</div>
									<button class="btn btn-primary btn-sm" id="goWorkBtn">출근등록</button>
								</div>
								<div class="align-center">
									<div class="mt-3 mb-2">
										<span>퇴근&ensp;</span>
										<span> ${workTime.outTime} </span>
									</div>
									<button class="btn btn-primary btn-sm" id="outWorkBtn">퇴근등록</button>
								</div>
							</div>
						</div>
					</div>
					<div class="card">
						<div class="card-body flex-col">
							<div class="work-progress">
								<div class="text-part">
									<span>이번 달 근무&ensp;</span>
									<span> ${workTime.monthWorkStr} </span>
								</div>
								<div class="progress progress-primary pg-part mt-1 mb-2">
									<div class="progress-bar month-progress" role="progressbar" style="width:0%" aria-valuenow="0"
										aria-valuemin="0" aria-valuemax="100"></div>
								</div>
							</div>
							<div class="work-progress">
								<div class="text-part">
									<span>이번 주 근무&ensp;</span>
									<span> ${workTime.weekWorkStr} </span>
								</div>
								<div class="progress progress-primary pg-part mt-1 mb-2">
									<div class="progress-bar week-progress" role="progressbar" style="width: 0%" aria-valuenow="0"
										aria-valuemin="0" aria-valuemax="100"></div>
								</div>
							</div>
							<div class="work-progress">
								<div class="text-part">
									<span>오늘 근무&ensp;</span>
									<span> ${workTime.dayWorkStr} </span>
								</div>
								<div class="progress progress-primary pg-part mt-1 mb-2">
									<div class="progress-bar day-progress" role="progressbar" style="width: 0%" aria-valuenow="0"
										aria-valuemin="0" aria-valuemax="100"></div>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="card">
					<div class="card-body">
						<div class="flex-row-side">
							<div class>
								<span class="text-part">근무일자</span>
								<input type="date" id="workDate" min="${loginMember.empJdate}" max="${today}">
								<button class="btn btn-primary btn-sm" id="workDateBtn">검색</button>
							</div>
							<!-- <div>
								<button class="btn btn-outline-primary btn-sm">개인</button>
								<button class="btn btn-outline-primary btn-sm">전체</button>
							</div> -->
						</div>
						<div class="table-responsive mt-5">
							<table class="table table-bordered mb-0">
								<thead>
									<tr>
										<!-- <th>사원이름</th> -->
										<th>출근시간</th>
										<th>퇴근시간</th>
										<th>근무시간</th>
										<th>지각시간</th>
										<th>조퇴시간</th>
										<th>초과시간</th>
										<th>비고</th>
									</tr>
								</thead>
								<tbody id="dayWorkInfoValue">
									<tr>
										<%-- <td>${work.empName}</td> --%>
										<td>${work.inTime}</td>
										<td>${work.outTime}</td>
										<td>${work.workTime}</td>
										<td>${work.lateTime}</td>
										<td>${work.earlyoutTime}</td>
										<td>${work.overTime}</td>
										<td>${work.statusName}</td>		
									</tr>
								</tbody>
							</table>
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
		$('#att-day').addClass("active");
		$('#att-part').css("display", "block");
		document.getElementById('workDate').value = new Date().toISOString().substring(0, 10);;
		
		if("${workTime.inTime}" != "미등록") {
			$("#goWorkBtn").attr("disabled", true);
		}
		
		if("${workTime.outTime}" != "미등록") {
			$("#outWorkBtn").attr("disabled", true);
		}
		
		document.getElementsByClassName("month-progress")[0].style.width="${proBar.monthBar}%";
		document.getElementsByClassName("week-progress")[0].style.width="${proBar.weekBar}%";
		document.getElementsByClassName("day-progress")[0].style.width="${proBar.dayBar}%";
		
	});
	
</script>
<script>
	var Target = document.getElementById("clock");
	function clock() {
	    var time = new Date();
	
	    var year = time.getFullYear();
	    var month = ('0' + (time.getMonth() + 1)).slice(-2);
	    var date = ('0' + time.getDate()).slice(-2);
	    var day = time.getDay();
	    var week = ['일', '월', '화', '수', '목', '금', '토'];

	    var dateString = year + '/' + month  + '/' + date;
	
	    var hours = ('0' + time.getHours()).slice(-2); 
	    var minutes = ('0' + time.getMinutes()).slice(-2);
	    var seconds = ('0' + time.getSeconds()).slice(-2); 

	    var timeString = hours + ':' + minutes  + ':' + seconds;
	
	    Target.innerText = dateString + ' (' +week[day] +') '+ timeString;
	}
	clock();
	setInterval(clock, 1000);
</script>
<script>
	$("button[id='goWorkBtn']").click(function(){
		location.href="${root}/att/goWork/"+${workTime.no};
	});
	
	$("button[id='outWorkBtn']").click(function(){
		location.href="${root}/att/outWork/"+${workTime.no};
	});
	
	$("button[id='workDateBtn']").click(function(){
		
		const date = document.querySelector("#workDate").value;
		
		$.ajax({
			url: "${root}/att/dayWorkInfo",
			type : "POST",
			data : {"date" : date},
			success : function(vo){
				if(vo.no != 0) {
					document.getElementById("dayWorkInfoValue").getElementsByTagName("td")[0].innerHTML = vo.inTime;
					document.getElementById("dayWorkInfoValue").getElementsByTagName("td")[1].innerHTML = vo.outTime;
					document.getElementById("dayWorkInfoValue").getElementsByTagName("td")[2].innerHTML = vo.workTime;
					document.getElementById("dayWorkInfoValue").getElementsByTagName("td")[3].innerHTML = vo.lateTime;
					document.getElementById("dayWorkInfoValue").getElementsByTagName("td")[4].innerHTML = vo.earlyoutTime;
					document.getElementById("dayWorkInfoValue").getElementsByTagName("td")[5].innerHTML = vo.overTime;
					document.getElementById("dayWorkInfoValue").getElementsByTagName("td")[6].innerHTML = vo.statusName;
				} else {
					for(i=0; i<7; i++) {
						document.getElementById("dayWorkInfoValue").getElementsByTagName("td")[i].innerHTML = " ";
					}
				}
			},
			error : function(e) {
				console.log(e);	
			}
		});
	});
</script>
<link rel="stylesheet" href="${root}/resources/css/attendance.css">
</html>