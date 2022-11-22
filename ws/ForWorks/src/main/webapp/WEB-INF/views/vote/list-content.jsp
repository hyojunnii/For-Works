<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
tr:hover{
    cursor: pointer;
    background-color: rgba(128, 128, 128, 0.425);
}
tr>th:hover{
    cursor: default; 
}
.b{
    color:black;
}
</style>
<link rel="stylesheet" href="${root}/resources/css/sjy.css"/>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<!-- 검색박스 -->


<div class="container" style="margin: 3% 5%;">
	<div class="row">
		<div class="col">
			
			<ul class="nav nav-tabs">
				<li class="nav-item"><a class="nav-link active"
					data-toggle="tab" href="#all">전체</a></li>
	
				<li class="nav-item"><a class="nav-link" data-toggle="tab"
					href="#ing">진행</a></li>
				<li class="nav-item"><a class="nav-link" data-toggle="tab"
					href="#end">마감</a></li>
			</ul>
			<div class="tab-content">
				<div class="tab-pane fade show active" id="all">
					<!--  투표 현황(전체) -->
					<div id="notice" style="text-align: left;width: 100%;">
						<div id="list" style="overflow: auto; width: 100%;">
							
							<table class="table" id="table-main">
								<thead class="table-light">
									<tr id="center">
										<th scope="col">#</th>
										<th scope="col" colspan="5">제목</th>
										<th scope="col">진행자</th>
										<th scope="col">상태</th>
										<th scope="col">시작일</th>
										<th scope="col">종료일</th>
									</tr>
								</thead>

								<c:if test="${empty vtList}">
									<thead style="pointer-events: none;">
										<tr id="center">
											<th scope="col" colspan="60">현재 생성된 투표가 없습니다.</th>
									</thead>
								</c:if>	
								<c:forEach items="${vtList }" var="vt">
									
									<tbody id="tbd">
										<tr id="center">
											<input type="hidden" value="${vt.vtNo}">
											<th scope="row">${vt.rownum}</th>
											<td colspan="5">${vt.vtTitle}</td>
											<input type="hidden" value="${vt.num}">
											<td >${vt.empNo}</td>
											
											<c:choose>
												<c:when test="${vt.vtStatus eq 'I'}">
													<td>진행중</td>
												</c:when>
												<c:when test="${vt.vtStatus eq 'E'}">
													<td>마감</td>
												</c:when>
											</c:choose>
											
											<td>${vt.vtCreate}</td>
											<td>${vt.vtEnd}</td>
										</tr>
									</tbody>
								</c:forEach>
								<td  colspan="10" style="border:none; cursor: default; background: white;">
            
									<ul class="pagination justify-content-center">
										
										<c:if test="${pv.startPage ne 1 }">	
											<li><a href="${root}/vote/list/1" class="page-link b disabled">처음</a></li>
											<li class="page-item"><a href="${root}/vote/list/${pv.startPage -1 }" class="page-link">이전</a></li>
										</c:if>
					
										
					
										<c:forEach begin="${pv.startPage }" end="${pv.endPage }" var="i">
											<li class="page-item " aria-current="page">
												<a class="page-link b" href="${root}/vote/list/${i}">${i}</a>
											</li>
										</c:forEach>
					
										<c:if test="${pv.endPage ne pv.maxPage }">
											<li><a class="page-link b" href="${root}/vote/list/${pv.endPage +1 }">다음</a></li>
											<li><a href="${root}/vote/list/${pv.maxPage }" class="page-link b">끝</a></li>
										</c:if>
									</ul>
								
								</td>

							</table>
						</div>
						<!-- 생성권한이 있는 사람만 -->
						<c:if test="${loginMember.opLevel eq 3}">
							<div style="text-align: right;">
								<a href="${root }/vote/create"><button class="myBtn"
										style="margin-right: 5%;">투표생성</button></a>
							</div>
						</c:if>
					</div>
				</div>


				<div class="tab-pane fade" id="ing">
					<%@include file="/WEB-INF/views/vote/list-ing.jsp" %>
					
				</div>
				<div class="tab-pane fade" id="end">
					<%@include file="/WEB-INF/views/vote/list-end.jsp" %>
					
				</div>
			</div>
		</div>
	</div>
</div>




<script>
	$(function() {
		$('#table-main>tbody>#center').click(function() {
			//행 클릭 되었을때, 동작할 내용
			console.log("${loginMember.empNo}");
			// console.log($(this).children().eq(0).val());
			// console.log($(this).children().eq(3).val());

			//로그인 회원번호
			const loginNo = "${loginMember.empNo}";

			//글 작성자 번호
			const vtw = $(this).children().eq(3).val();

			//글번호 가져오기
			const num = $(this).children().eq(0).val();

			//로그인한 회원의 정보중 이름을 가져와서 현재 선택한글의 작성자와 같은지 판별
			if (loginNo == vtw) {
				//작성자인경우
				location.href = '${root}/vote/detailCreator/' + num;
			}else{
				//아닌경우
				location.href = '${root}/vote/detailUser/' + num;
			}
			

		});
	})
</script>
