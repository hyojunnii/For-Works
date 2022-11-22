<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<title>휴가신청확인</title>
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
	
	input[type="checkbox"] {
		width: 100%;
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
						<h3>휴가 신청 확인</h3>
					</div>
				</div>
			</div>
			<section class="section">
				<div class="card">
					<div class="card-body">
						<div class="flex-row-side">
							<div class>
								<input type="month" value="${month}">
								<button class="btn btn-primary btn-sm" onclick="monthBtn();">검색</button>
							</div>
							<div>
								<button class="btn btn-outline-primary btn-sm" onclick="okBtn();">휴가 승인</button>
								<button class="btn btn-outline-primary btn-sm" onclick="noBtn();">휴가 거절</button>
							</div>
						</div>
						<div class="table-responsive mt-5">
							<table class="table table-bordered mb-0">
								<thead>
									<tr>
										<th>선택</th>
										<th>신청인</th>
										<th>신청 날짜</th>
										<th>시작일</th>
										<th>종료일</th>
										<th>총 일수</th>
                                        <th>종류</th>
										<th>처리 상태</th>
									</tr>
								</thead>
								<tbody id = "offListTable">
									<c:forEach items="${OffList}" var="off">
										<tr>
											<td>
												<c:if test="${off.status eq '대기중'}">
													<input type="checkbox" name="OffNo" value="${off.no}">
												</c:if>
											</td>
											<td>${off.empName}</td>
											<td>${off.writeDate}</td>
											<td>${off.startDay}</td>
											<td>${off.endDay}</td>
											<td>${off.period}</td>
	                                        <td>${off.typeName}</td>
											<td>${off.status}</td>
										</tr>
									</c:forEach>	
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
	function okBtn(){
		var len = $("input[name=OffNo]:checked").length;
		var checkArr = [];
		if(len > 0) {			
			$("input[name=OffNo]:checked").each(function(e){
				checkArr.push($(this).val());
			});
		}
		location.href = "${root}/off/accept?no=" + checkArr;
	};
	
	function noBtn(){
		var len = $("input[name=OffNo]:checked").length;
		var checkArr = [];
		if(len > 0) {			
			$("input[name=OffNo]:checked").each(function(e){
				checkArr.push($(this).val());
			});
		}
		location.href = "${root}/off/reject?no=" + checkArr;
	};
	
	
	function monthBtn(){
		var month = $("input[type=month]").val();
		$.ajax({
			url: '${root}/off/deptOffList',
			type: 'POST',
			data: {'month' : month},
			success : function(res){
				$("#offListTable").empty();
				$.each(res, function(i,item){
					let tr = $("<tr></tr>");
					if(item.status == "대기중"){						
						$("<td><input type='checkbox' name='OffNo' value="+item.no+"></td>").appendTo(tr);
					} else {
						$("<td></td>").appendTo(tr);
					}
					$("<td></td>").html(item.empName).appendTo(tr);
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
	
	$().ready(function() {
		$('#att-offCon').addClass("active");
		$('#att-part').css("display", "block");
	});
	
</script>
<link rel="stylesheet" href="${root}/resources/css/attendance.css">
</html>