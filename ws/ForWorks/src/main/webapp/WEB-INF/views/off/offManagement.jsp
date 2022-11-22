<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<title>휴가관리</title>
	<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
</head>

<style>

    .first-card {
        width: 80%;
        margin: auto;
    }

	#demo {
		width: 230px;
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
						<p class="text-subtitle">휴가관리</p>
						<h3>휴가 사용 현황</h3>
					</div>
				</div>
			</div>
			<section class="section">
				<div class="card first-card">
                    <div class="card-body">
                        <div class="flex-row">
                            <div class="align-center mt-3 mb-2">
                                <div>${offCnt.totalOff}</div>
                                <div>총 연차</div>
                            </div>
                            <div class="align-center mt-3 mb-2">
                                <div>${offCnt.useOff}</div>
                                <div>사용 연차</div>
                            </div>
                            <div class="align-center mt-3 mb-2">
                                <div>${offCnt.leftOff}</div>
                                <div>잔여 연차</div>
                            </div>
                        </div>
                    </div>
                </div>

				<div class="card">
					<div class="card-body">
						<div class="flex-row-side">
							<div>
								<select id="ddlYears"></select>년도&ensp;
								<button class="btn btn-primary btn-sm" onclick="getOffInfo();">검색</button>
							</div>
							<div>
								<button class="btn btn-outline-primary btn-sm" data-bs-toggle="modal" data-bs-target="#offForm">휴가 신청</button>
							</div>
						</div>
						<div class="table-responsive mt-5">
							<table class="table table-bordered mb-0">
								<thead>
									<tr>
										<th>신청 날짜</th>
										<th>시작일</th>
										<th>종료일</th>
										<th>총 일수</th>
                                        <th>종류</th>
										<th>처리 상태</th>
									</tr>
								</thead>
								<tbody id="offListTable">
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</section>

			<div class="modal fade text-left" id="offForm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel33" aria-hidden="true" data-bs-backdrop="false">
				<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h4 class="modal-title" id="myModalLabel33">휴가 신청서 </h4>
						</div>
						<form action="#">
							<div class="modal-body">
								<div class="form-group">
									<label>사원 이름: </label>
									<span>${loginMember.empName}</span>
								</div>
								<div class="form-group">
									<label>기간: </label>
									<input type="text" id="off-day-range" name="off-day-range"/>
								</div>
								<div class="form-group">
									<label>휴가 종류</label><br>
									<c:forEach var="i" items="${offTypeList}">
										<label><input type="radio" name="type" value="${i.code}">${i.name}</label>
									</c:forEach>
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-light-secondary"
									data-bs-dismiss="modal">
									<i class="bx bx-x d-block d-sm-none"></i>
									<span class="d-none d-sm-block">취소하기</span>
								</button>
								<button type="button" class="btn btn-primary ml-1"
									data-bs-dismiss="modal" onclick="submitOffForm();">
									<i class="bx bx-check d-block d-sm-none"></i>
									<span class="d-none d-sm-block">신청하기</span>
								</button>
							</div>
						</form>
					</div>
				</div>
			</div>

		</div>
		
    </div>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</div>
</body>
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>

<script>

	$(function(){
		var ddlYears = document.getElementById("ddlYears");
		var currentYear = (new Date()).getFullYear();

		for (var i = ${joinDay}; i <= currentYear; i++) {
		    var option = document.createElement("OPTION");
		    option.innerHTML = i;
		    option.value = i;
		    ddlYears.appendChild(option);
		    
		    if(i == currentYear) {
		    	option.selected
		    }
		}
		$("#ddlYears").val(currentYear).attr("selected", "selected");
	});
	
	function getOffInfo(){
		var year = $("#ddlYears").val();
		$.ajax({
			url: '${root}/off/offInfo',
			type: 'POST',
			data: {'year' : year},
			success : function(res){
				$("#offListTable").empty();
				$.each(res, function(i,item){
					let tr = $("<tr></tr>");
					$("<td></td>").html(item.writeDate).appendTo(tr);
					$("<td></td>").html(item.startDay).appendTo(tr);
					$("<td></td>").html(item.endDay).appendTo(tr);
					$("<td></td>").html(item.period).appendTo(tr);
					$("<td></td>").html(item.typeName).appendTo(tr);
					$("<td></td>").html(item.status).appendTo(tr);					
					$("#offListTable").append(tr);
				});
			},
			error : function(e){
				console.log(e);
			}
		});
	}

</script>
<script>
	var startDay;
	var endDay;
	
	$().ready(function() {
		$('#att-off').addClass("active");
		$('#att-part').css("display", "block");

		$('#off-day-range').daterangepicker({
			"locale": {
				"format": "YYYY-MM-DD",
				"separator": " ~ ",
				"applyLabel": "확인",
				"cancelLabel": "취소",
				"fromLabel": "From",
				"toLabel": "To",
				"customRangeLabel": "Custom",
				"weekLabel": "W",
				"daysOfWeek": ["월", "화", "수", "목", "금", "토", "일"],
				"monthNames": ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
				"firstDay": 1
			},
			"drops": "down"
		}, function (start, end, label) {
			startDay = start.format('YYYY-MM-DD');
			endDay = end.format('YYYY-MM-DD');
		});
	});
	
	function submitOffForm(){

		var radioVal = $('input[name="type"]:checked').val();
		
		if(startDay != null && endDay != null) {
			if(radioVal != null) {
				$.ajax({
					url: '${root}/off/submitOff',
					method: 'POST',
					data : {
						"start" : startDay,
						"end" : endDay,
						"type" : radioVal
					},
					success : function(res) {
						if(res == "success") {						
							toastContent.innerText = "휴가 작성이 완료되었습니다.";
						} else {
							toastContent.innerText = "에러 발생. 나중에 다시 시도해주세요";
						}
					},
					error : function(){
						toastContent.innerText = "에러 발생. 나중에 다시 시도해주세요";
					}
				});
			} else {
				toastContent.innerText = "휴가 종류를 선택해주세요";
			}			
		} else {			
			toastContent.innerText = "날짜를 다시 확인해주세요";
		}
	}
	
</script>
<link rel="stylesheet" href="${root}/resources/css/attendance.css">
</html>