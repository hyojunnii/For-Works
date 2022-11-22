<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="alertMsg" value="${sessionScope.alertMsg }"/>
<c:remove var="alertMsg" scope="session"/>
<c:if test="${not empty alertMsg }">
	<script>
		alert('${alertMsg}');
	</script>
</c:if> 
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
			<div class="csearch" >
			
				<form action="${root}/community/list/1" method="get" onsubmit="return check()">
                    <!-- <input type="search" class="form-control ds-input" id="" placeholder="Search docs..." style="width: auto; display: inline; " > -->
					<div class="input-group w-70" >
						<select class="form-select" aria-label="Default select example" name="condition">
							<option value="nu" selected>선택</option>
							<option value="title">제목</option>
							<option value="writer">작성자</option>
						</select>
						<input type="text" class="form-control" placeholder="검색어를 입력해주세요" aria-label="Input group example" aria-describedby="basic-addon1" name="keyword">
						<span class="input-group-text" id="basic-addon1">
							<button class="mybtn">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
							<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"></path>
							</svg>
							</button>
						</span>

						<span class="input-group-text" id="basic-addon1">
							<a href="${root}/community/list/1">
							<button type="button" class="mybtn">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-counterclockwise" viewBox="0 0 16 16">
									<path fill-rule="evenodd" d="M8 3a5 5 0 1 1-4.546 2.914.5.5 0 0 0-.908-.417A6 6 0 1 0 8 2v1z"></path>
									<path d="M8 4.466V.534a.25.25 0 0 0-.41-.192L5.23 2.308a.25.25 0 0 0 0 .384l2.36 1.966A.25.25 0 0 0 8 4.466z"></path>
								</svg>
							</button>
							</a>
						</span>

					</div>
				</form>
			</div>
			
			<ul class="nav nav-tabs" >
				<li class="nav-item"><a class="nav-link active"data-toggle="tab" href="#all">전체</a></li>
				<c:if test="${loginMember ne null}">
					<li class="nav-item" ><a style="display: block;" class="nav-link" data-toggle="tab"href="#my" >${loginMember.deptName}</a></li>
				</c:if>	
			</ul>
			<div class="tab-content">
				<div class="tab-pane fade show active" id="all">
					
					<div id="notice" style="text-align: left;width: 100%;">
						<div id="list" style="overflow: auto; width: 100%;">

							<table class="table" id="table-main">
								<thead class="table-light">
									<tr id="center">
										<th scope="col">#</th>
										<th scope="col" colspan="5">제목</th>
										<th scope="col">작성자</th>
										<th scope="col">조회수</th>
										<th scope="col">공개범위</th>
										<th scope="col">작성일</th>
									</tr>
								</thead>

								
								<c:forEach items="${cmuList }" var="cmu">
									<tbody id="tbd">
										<tr id="center">
											
											<th scope="row">${cmu.cmuNo}</th>
											<td colspan="5">${cmu.cmuTitle}</td>

											<td>${cmu.empNo}</td>
											<td>${cmu.cmuCnt}</td>
											<td>${cmu.cmuRead}</td>
											<td>${cmu.cmuModifiyDate}</td>
										</tr>
									</tbody>
								</c:forEach>
								<td  colspan="10" style="border:none; cursor: default; background: white;">
            
									<ul class="pagination justify-content-center">
										
										<c:if test="${pv.startPage ne 1 }">	
											<li><a href="${root}/community/list/1" class="page-link b disabled">처음</a></li>
											<li class="page-item"><a href="${root}/community/list/${pv.startPage -1 }" class="page-link">이전</a></li>
										</c:if>
					
										
					
										<c:forEach begin="${pv.startPage }" end="${pv.endPage }" var="i">
											<li class="page-item " aria-current="page">
												<a class="page-link b" href="${root}/community/list/${i}">${i}</a>
											</li>
										</c:forEach>
					
										<c:if test="${pv.endPage ne pv.maxPage }">
											<li><a class="page-link b" href="${root}/community/list/${pv.endPage +1 }">다음</a></li>
											<li><a href="${root}/community/list/${pv.maxPage }" class="page-link b">끝</a></li>
										</c:if>
									</ul>
								
								</td>

							</table>
						</div>
						<!-- 생성권한이 있는 사람만 -->
						<c:if test = "${not empty loginMember}">
							<div style="text-align: right;">
								<a href="${root}/community/write"><button class="myBtn"
										style="margin-right: 5%;">게시글 작성</button></a>
							</div>
						</c:if>
					</div>
				</div>


				<!-- my탭 클릭시 보여지는 화면 -->
				<div class="tab-pane fade" id="my" >
					<%@include file="/WEB-INF/views/community/myList.jsp" %>
				</div>
		</div>
	</div>
</div>
</div>


<!-- 커뮤니티 검색엔진 select체크여부확인 -->
<script>
	var x;
	$("select[name=condition]").change(function(){
		x= $(this).val();
		console.log(x);
	}); 
    function check(){
        if (x== "nu" || x ==null) {
            alert('대상을 선택해주세요!');
            return false;
        }
    }
</script>


<script>
	$(function() {
		$('#table-main>tbody>#center').click(function(){
			//글번호 가져오기
			const num = $(this).children().eq(0).text();
			location.href = '${root}/community/detail/' + num;
		});
	})
</script>

<script>
	
	$(function() {
		$('#table-main>tbody>#center2').click(function(){
			const num = $(this).children().eq(0).val();
			// console.log(":::"+num);
			location.href = '${root}/community/detail/' + num;
		});
	})
</script>