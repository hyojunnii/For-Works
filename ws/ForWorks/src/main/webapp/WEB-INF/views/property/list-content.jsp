<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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


<div class="container" style="margin: 3% ;">
	<div class="row">
		<div class="col">
			

			<div class="tab-content">
				<div class="tab-pane fade show active" id="all">
					<!--  투표 현황(전체) -->
					<div id="notice" style="text-align: left; ">
						<div id="list" style="overflow-x: hidden; width: 100%;">

							<table class="table" id="table-main">
								<thead class="table-light">
									<tr id="center">
										<th scope="col">#</th>
										<th scope="col" colspan="5">자산명</th>
										<th scope="col">분류</th>
										<th scope="col">취득일</th>
									</tr>
								</thead>

								<%int i=0; %>
								<c:forEach begin="1" step="1" end="10">
									<tbody>
										<tr id="center">

											<th scope="row">1</th>
											<td colspan="5">ㅁㅁㅁㅁㅁ</td>

											<td>회의실</td>
											<td>21-09-28</td>
										</tr>
									</tbody>
								</c:forEach>
								<td colspan="10"style="border: none; cursor: default; background: white;">
									<ul class="pagination justify-content-center">
										<li class="page-item disabled"><a class="page-link"><</a>
										</li>
										<li class="page-item active" aria-current="page"><a
											class="page-link b" href="#">1</a></li>
										<li class="page-item"><a class="page-link b" href="#">2</a></li>
										<li class="page-item"><a class="page-link b" href="#">3</a></li>
										<li class="page-item"><a class="page-link b" href="#">></a>
										</li>
									</ul>
								</td>

							</table>
						</div>
						<!-- 생성권한이 있는 사람만 -->
						<div style="text-align: right;">
							<a href="/forworks/property/create"><button class="myBtn"
									style="margin-right: 5%;">자산등록</button></a>
						</div>

					</div>
				</div>
				<div class="tab-pane fade" id="ing">
					<p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Aut culpa recusandae, magnam dicta laboriosam architecto fugit excepturi illo quo laudantium deserunt exercitationem cumque blanditiis sint, obcaecati libero. Delectus, vero sed?</p>
				</div>
				<div class="tab-pane fade" id="end">
					<p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Aut natus nisi nulla vero ex quaerat expedita amet nam sint odio ab assumenda, ullam suscipit consequatur architecto deleniti, repellendus minus minima.</p>
				</div>
			</div>
		</div>
	</div>
</div>




<script>
	$(function() {
		$('#table-main>tbody>tr').click(function() {
			//행 클릭 되었을때, 동작할 내용

			//글번호 가져오기
			const num = $(this).children().eq(0).text();

			//로그인한 회원의 정보중 이름을 가져와서 현재 선택한글의 작성자와 같은지 판별

			//해당 번호로 요청 보내기
			
			//작성자인경우
			location.href = '${root}/property/detail?num=' + num;

			//아닌경우
			//location.href = '${root}/survey/detailUser?num=' + num;
		});
	})
</script>
