<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
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

								<!-- 조건 :: 로그인한 회원의 부서정보값이랑 같은 정보만 가져오기 -->
								<c:forEach items="${cmudpList }" var="cmdp">
									
									<!-- <div>${cmdp.rownum}</div> -->
									<c:set var="k" value="${k+1}"/>
									<tbody id="tbd2">
										<tr id="center2">
											<input type="hidden"  value="${cmdp.cmuNo}">
											<th scope="row">${cmdp.rownum}</th>
											<td colspan="5">${cmdp.cmuTitle}</td>

											<td>${cmdp.empNo}</td>
											<td>${cmdp.cmuCnt}</td>
											<td>${cmdp.cmuRead}</td>
											<td>${cmdp.cmuModifiyDate}</td>
										</tr>
									</tbody>
									
								</c:forEach>
								<td  colspan="10" style="border:none; cursor: default; background: white;">
            
									<ul class="pagination justify-content-center">
										
										<c:if test="${pvdp.startPage ne 1 }">	
											<li><a href="${root}/community/list/1" class="page-link b disabled">처음</a></li>
											<li class="page-item"><a href="${root}/community/list/${pvdp.startPage -1 }" class="page-link">이전</a></li>
										</c:if>
					
										
					
										<c:forEach begin="${pvdp.startPage }" end="${pvdp.endPage }" var="j">
											<li class="page-item " aria-current="page">
												<a class="page-link b" href="${root}/community/list/${j}/">${j}</a>
											</li>
										</c:forEach>
					
										<c:if test="${pvdp.endPage ne pvdp.maxPage }">
											<li><a class="page-link b" href="${root}/community/list/${pvdp.endPage +1 }">다음</a></li>
											<li><a href="${root}/community/list/${pvdp.maxPage }" class="page-link b">끝</a></li>
										</c:if>
									</ul>
								
								</td>

							</table>
						</div>
						<!-- 생성권한이 있는 사람만 -->
						<div style="text-align: right;">
							<a href="${root}/community/write"><button class="myBtn"
									style="margin-right: 5%;">게시글 작성</button></a>
						</div>							

				</div>