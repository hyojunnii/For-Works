<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<title>Home</title>
</head>
<style>
    #wrap{
        background-color: white;
        width: 90vw;
        height: 90vh;
        font-size: 20px;
    }
    table{
        width: 100%;
        border: 1px solid black;
        text-align: left;
		border-collapse : collapse;
    }
    #title{
        text-align: center;
        font-size: larger;
        font-weight: bolder;
    }
    .back-color{
        background-color: #EEF1FF;
    }
	th,td{
		border-bottom: 1px solid #444444;
		padding-bottom: 10px;
		padding-top: 10px;
	}


</style>
<body>

<div id="app">

	<div id="main">
           
		   <div id="wrap">
			<div id="title">급여명세서</div>
			<div>${result.salMonth}</div>
			<div id="center">
				
					<table>
						<tr>
							<th>성명</th>
							<td>${result.empName}</td>
						</tr>
						<tr>
							<th>지급일</th>
							<td>${result.payDate}</td>
						</tr>
					</table>
					<br>
					<table>
						<tr>
							<th colspan="2">임금지급내역</th>
							<th colspan="2">공제내역</th>
						</tr>
						<tr>
							<th>임금항목</th>
							<th>지급금액(원)</th>
							<th>공제항목</th>
							<th>공제금액(원)</th>
						</tr>

						<tr>
							<th>기본급</th>
							<td>${result1[0].empMoney}</td>
							<th>소득세</th>
							<td>${result.tax1}</td>
						</tr>

						<tr>
							<th>수당</th>
							<td>${result.amount}</td>
							<th>국민연금</th>
							<td>${result.tax2}</td>
						</tr>

						<tr>
							<th>상여금</th>
							<td>${result.bonusSum}</td>
							<th>건강보험</th>
							<td>${result.tax3}</td>
						</tr>

						<tr>
							<td></td>
							<td></td>
							<th>고용보험</th>
							<td>${result.tax4}</td>
						</tr>

						<tr>
							<th>지급액 계</th>
							<td>${result.sum}</td>
							<th>공제액 계</th>
							<td>${result.sumxtax}</td>
						</tr>

						<tr>
							<th>실지급액</th>
							<td></td>
							<td colspan="3">
								${result.sum - result.sumxtax}(원)
							</td>
							<td></td>
						</tr>
					</table>
					<br>
					<span>수당내역</span>
					<table>
						<tr>
							<td>수당명</td>
							<td>시간(분)</td>
							<td>지급액(원)</td>
						</tr>
						<c:if test="${result1 ne null}">
							<c:forEach items="${result1}" var="x">
							<tr>
								<td>${x.cate}</td>
								<td></td>
								<td>${x.amount}</td>
							</tr>
							</c:forEach>
							<tr>
								<td>초과수당</td>
								<td>${result1[0].addOverTime}</td>
								<td>${result1[0].addCalc}</td>
							</tr>
						</c:if>
						
					</table>
					<span>상여금내역</span>
					<table>
						<tr>
							<td>상여명</td>
							<td>상여내역</td>
							<td>지급액(원)</td>
						</tr>
						<c:if test="${result2 ne null}">
							<c:forEach items="${result2}" var="x">
							<tr>
								<td>${x.title}</td>
								<td>${x.content}</td>
								<td>${x.payment}</td>
							</tr>
							</c:forEach>
						</c:if>
					</table>
				
			</div>
		</div>
		<button onclick="return window.print();">프린트</button>
          
           
	</div>

</div>

<script>
	
</script>


<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>


</html>
