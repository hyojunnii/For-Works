<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ForWorks</title>

<link rel="stylesheet" href="${root}/resources/css/address/email.css">
    
<link rel="stylesheet" href="${root}/resources/css/address/address-style.css">
<script src="https://kit.fontawesome.com/3a92c85ff9.js" crossorigin="anonymous"></script>
<style>
    .star {
      visibility: hidden;
      cursor: pointer;
    }
    .star:before {
      content: "\f005";
      font-family: FontAwesome;
      color: #ccc;
      position: absolute;
      visibility: visible;
    }
    .star:checked:before {
      content: "\f005";
      color: #ffc107;
      font-family: FontAwesome;
      position: absolute;
    }
  </style>
</head>
<body>
	<div id="app">

	<%@ include file="/WEB-INF/views/common/sidebar.jsp" %>

	<div id="main">
           <%@ include file="/WEB-INF/views/common/header.jsp" %>

               <div class="page-title">
                   <div class="row">
                       <div class="col-12 col-md-6 order-md-1 order-last">
                           <h3>주소록</h3>
                       </div>
                   </div>
               </div>
            
 
               <div class="address-navbar">
                   <div class="search-bar">
                        <div class="search-input-field">    
                            <img alt="" src="${root}/resources/img/member-imgs/free-icon-search-7233469.png">
                            <input value="${addressParam.keyword}" name="keyword" type="text" class="pt-2" onkeypress="if(event.keyCode == 13){searchKeyword();}" placeholder="이름 또는 연락처 검색">
                        </div>
                    </div>
                    <div class="status-outer">
                        <div class="status-content">
                            <span style="color:inherit;">상태</span>
                            <select name="statNo" id="emp_stat" class="form-select form-select-sm">
                                <option value="1">알수없음</option>
                                <option value="2">자리</option>
                                <option value="3">자리비움</option>
                                <option value="4">식사</option>
                                <option value="5">응답불가</option>
                            </select>
                        </div>
                        <button class="nav-btn btn btn-sm btn-outline-secondary" type="button" onclick="statEdit();">등록</button>
                    </div>
                </div>

               <section class="section address-field">
                    <div class="card left-field mb-0" style="min-width: 90px">
                        <div class="card-body">
                            <div class="page-field">
                            	<a href="${root}/address/1">
	                                <i class="fa-solid fa-city fa-lg mb-2"></i>
	                                <span class="mb-3">조직</span>
                            	</a>
                            </div>
                            <div class="page-field">
                            	<a href="${root}/address/important/1">
                                	<i class="fa-solid fa-star fa-lg mb-2"></i>
                                	<span class="mb-3">중요</span>
                                </a>
                            </div>
                            <div class="page-field">
                            	<a href="${root}/address/dept/1">
	                                <i class="fa-solid fa-briefcase fa-lg mb-2"></i>
	                                <span class="mb-3">부서</span>
                                </a>
                            </div>
                            <div class="page-field">
                            	<a href="${root}/address/external/1">
	                               	<i class="fa-solid fa-right-to-bracket fa-lg mb-2"></i>
	                                <span class="mb-3">외부</span>
                               </a>
                            </div>
                        </div>
                    </div>
                    <div class="card right-field" style="overflow:auto;">
                    	<div class="card-header m-0 p-4 pt-3">
                        	<div class="d-flex align-items-center justify-content-between">
                        		<div class="mt-4">
                        			<c:choose>
                        				<c:when test="${addressParam.nav eq 'important'}">
                        					<h5>중요 주소록</h5>
                        				</c:when>
                        				<c:when test="${addressParam.nav eq 'dept'}">
                        					<div class="d-flex">
                        					<h5>부서별 주소록</h5>
                        					<div class="btn-group" style="padding-left: 15px;">
					                            <div class="dropdown">
					                              <a type="button" class="dropdown-toggle text-muted" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
					                                ${deptName}
					                                <svg id="dropDownIcon" class="mb-1" width="0.8em" height="0.8em">
							                            <use xlink:href="${root}/resources/vendors/bootstrap-icons/bootstrap-icons.svg#caret-down-fill"></use>
							                        </svg>
					                              </a>
					                              <div class="dropdown-menu" data-popper-placement="top-start" style="position: absolute; inset: auto auto 0px 0px; margin: 0px; transform: translate3d(0px, -32.7273px, 0px);">
					                                <c:forEach items="${deptList}" var="dl">
					                                	<a class="dropdown-item" href="${root}/address/dept/${dl.deptNo}/1">${dl.deptName}</a>
					                                </c:forEach>
					                              </div>
					                            </div>
					                          </div>
					                         </div>
                        				</c:when>
                        				<c:otherwise>
                        					<h5>전체 주소록</h5>
                        				</c:otherwise>
                        			</c:choose>
                        		</div>
                        		<!-- pagination and page count -->
                        		<div class="d-flex align-items-center">
                        			<c:choose>
	                        			<c:when test="${(pv.currentPage eq pv.maxPage) or (pv.listCount lt 10)}">
					                        <span class="d-none d-sm-block" style="margin: 0 10px">${pv.currentPage*pv.boardLimit - (pv.boardLimit-1)}-${pv.listCount} of ${pv.listCount}</span>
	                        			</c:when>
	                        			<c:otherwise>
					                        <span class="d-none d-sm-block" style="margin: 0 10px">${pv.currentPage*pv.boardLimit - (pv.boardLimit-1)}-${pv.currentPage * pv.boardLimit} of ${pv.listCount}</span>
	                        			</c:otherwise>
                        			</c:choose>
		                        	<c:if test="${pv.currentPage ne 1}">
		                        		<c:choose>
		                        			<c:when test="${not empty addressParam.keyword and not empty addressParam.sort}">
					                        	<a href="${root}/address/${addressParam.nav}/${(pv.currentPage) - 1}?keyword=${addressParam.keyword}&sort=${addressParam.sort}&order=${addressParam.order}" class="btn btn-sm btn-outline-primary btn-icon email-pagination-prev d-none d-sm-block" style="margin-right: 5px">&lt;</a>
		                        			</c:when>
		                        			<c:when test="${not empty addressParam.keyword}">
					                        	<a href="${root}/address/${addressParam.nav}/${(pv.currentPage) - 1}?keyword=${addressParam.keyword}" class="btn btn-sm btn-outline-primary btn-icon email-pagination-prev d-none d-sm-block" style="margin-right: 5px">&lt;</a>
		                        			</c:when>
		                        			<c:when test="${not empty addressParam.sort}">
					                        	<a href="${root}/address/${addressParam.nav}/${(pv.currentPage) - 1}?sort=${addressParam.sort}&order=${addressParam.order}" class="btn btn-sm btn-outline-primary btn-icon email-pagination-prev d-none d-sm-block" style="margin-right: 5px">&lt;</a>
		                        			</c:when>
		                        			<c:otherwise>
					                        	<a href="${root}/address/${addressParam.nav}/${(pv.currentPage) - 1}" class="btn btn-sm btn-outline-primary btn-icon email-pagination-prev d-none d-sm-block" style="margin-right: 5px">&lt;</a>
		                        			</c:otherwise>
		                        		</c:choose>
		                        	</c:if>
		                        	<c:if test="${pv.currentPage ne pv.maxPage}">
		                        		<c:choose>
		                        			<c:when test="${not empty addressParam.keyword and not empty addressParam.sort}">
					                        	<a href="${root}/address/${addressParam.nav}/${(pv.currentPage) + 1}?keyword=${addressParam.keyword}&sort=${addressParam.sort}&order=${addressParam.order}" class="btn btn-sm btn-outline-primary btn-icon email-pagination-next d-none d-sm-block" style="margin-right: 5px">&gt;</a>
		                        			</c:when>
			                        		<c:when test="${not empty addressParam.keyword}">
					                        	<a href="${root}/address/${addressParam.nav}/${(pv.currentPage) + 1}?keyword=${addressParam.keyword}" class="btn btn-sm btn-outline-primary btn-icon email-pagination-next d-none d-sm-block"style="margin-right: 5px">&gt;</a>
		                        			</c:when>
		                        			<c:when test="${not empty addressParam.sort}">
					                        	<a href="${root}/address/${addressParam.nav}/${(pv.currentPage) + 1}?sort=${addressParam.sort}&order=${addressParam.order}" class="btn btn-sm btn-outline-primary btn-icon email-pagination-next d-none d-sm-block"style="margin-right: 5px">&gt;</a>
		                        			</c:when>
		                        			<c:otherwise>
					                        	<a href="${root}/address/${addressParam.nav}/${(pv.currentPage) + 1}" class="btn btn-sm btn-outline-primary btn-icon email-pagination-next d-none d-sm-block"style="margin-right: 5px">&gt;</a>
		                        			</c:otherwise>
		                        		</c:choose>
		                        	</c:if>
			                    </div>
		                    </div>
                    	</div>
                        <div class="card-body" style="padding-left: 20px">
		                    <div>
                              <table class="table" id="table1" style="text-align: center">
                                <thead>
                                  <tr>
                                    <th></th>
                                    <th></th>
                                    <th>
                                    	<c:choose>
                                    		<c:when test="${addressParam.order eq 'desc'}">
                                    			<c:choose>
                                    				<c:when test="${not empty addressParam.keyword}">
								                        <a href="${root}/address/${addressParam.nav}/1?keyword=${addressParam.keyword}&sort=name&order=asc">이름</a>
				                                    	<svg id="orderUpIcon" class="mb-1" width="0.8em" height="0.8em">
								                            <use xlink:href="${root}/resources/vendors/bootstrap-icons/bootstrap-icons.svg#arrow-up"></use>
								                        </svg>
                                    				</c:when>
                                    				<c:otherwise>
                                    					<a href="${root}/address/${addressParam.nav}/1?sort=name&order=asc">이름</a>
				                                    	<svg id="orderUpIcon" class="mb-1" width="0.8em" height="0.8em">
								                            <use xlink:href="${root}/resources/vendors/bootstrap-icons/bootstrap-icons.svg#arrow-up"></use>
								                        </svg>
                                    				</c:otherwise>
                                    			</c:choose>
                                    		</c:when>
                                    		<c:otherwise>
                                    			<c:choose>
                                    				<c:when test="${not empty addressParam.keyword}">
				                                    	<a href="${root}/address/${addressParam.nav}/1?keyword=${addressParam.keyword}&sort=name&order=desc">이름</a>
				                                    	<svg id="orderDownIcon" class="mb-1" width="0.8em" height="0.8em">
								                            <use xlink:href="${root}/resources/vendors/bootstrap-icons/bootstrap-icons.svg#arrow-down"></use>
								                        </svg>
                                    				</c:when>
                                    				<c:otherwise>
                                    					<a href="${root}/address/${addressParam.nav}/1?sort=name&order=desc">이름</a>
				                                    	<svg id="orderDownIcon" class="mb-1" width="0.8em" height="0.8em">
								                            <use xlink:href="${root}/resources/vendors/bootstrap-icons/bootstrap-icons.svg#arrow-down"></use>
								                        </svg>
                                    				</c:otherwise>
                                    			</c:choose>
                                    		</c:otherwise>
                                    	</c:choose>
                                    </th>
                                    <th>부서</th>
                                    <th>직급</th>
                                    <th>전화번호</th>
                                    <th>이메일</th>
                                    <th>내선번호</th>
                                  </tr>
                                </thead>
                                <tbody>
                                  	<c:forEach items="${addressList}" var="l">
	                                  <tr>
	                                    <td>
	                                    	<c:choose>
		                                    	<c:when test="${not empty l.bmEmpNo}">
		                                      	  <input name="favorite" type="checkbox" class="star" value="${l.empNo}" checked />
		                                    	</c:when>
		                                    	<c:otherwise>
			                                      <input name="favorite" type="checkbox" class="star" value="${l.empNo}"/>
		                                    	</c:otherwise>
	                                    	</c:choose>
	                                    </td>
	                                    <td>
	                                      <div class="avatar">
	                                      	<c:choose>
	                                      		<c:when test="${not empty l.empProfile}">
	                                       	 		<img style="width: 38px; height: 38px; object-fit: cover" src="${root}/resources/upload/profile/${l.empProfile}" alt="img" />
	                                      		</c:when>
	                                      		<c:otherwise>
	                                       	 		<img style="width: 38px; height: 38px" src="${root}/resources/img/member-imgs/user.png" alt="img" />
	                                      		</c:otherwise>
	                                      	</c:choose>
	                                      	<c:choose>
	                                      		<c:when test="${l.statNo eq 2}">
			                                        <span id="status${l.empNo}" class="avatar-status bg-success"></span>
	                                      		</c:when>
	                                      		<c:when test="${l.statNo eq 5}">
			                                        <span id="status${l.empNo}" class="avatar-status bg-danger"></span>
	                                      		</c:when>
	                                      		<c:when test="${l.statNo eq 3 or l.statNo eq 4}">
			                                        <span id="status${l.empNo}" class="avatar-status bg-warning"></span>
	                                      		</c:when>
	                                      		<c:otherwise>
			                                        <span id="status${l.empNo}" class="avatar-status bg-secondary"></span>
	                                      		</c:otherwise>
	                                      	</c:choose>
	                                      </div>
	                                    </td>
	                                    <td>${l.empName}</td>
	                                    <td>${l.deptName}</td>
	                                    <td>${l.posName}</td>
	                                    <td>${l.empPhone}</td>
	                                    <td>${l.empEmail}</td>
	                                    <td>${l.empExphone}</td>
	                                  </tr>
                                  	</c:forEach>
                                </tbody>
                              </table>
                              </div>
                          </div>
                        </div>
               </section>
            </div>
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
     </div>
</body>
<script>

	$(document).ready(function(){
		$("input[name=favorite]:checkbox").on("click", function() {
			const bmEmpNo = $(this).val();
			if($(this).prop('checked')) {
				$.ajax({
			     url: "${root}/address/favorite/insert",
			     type: "POST",
			     data: {bmEmpNo : bmEmpNo}
			   });
			} else {
				$.ajax({
			     url: "${root}/address/favorite/delete",
			     type: "POST",
			     data: {bmEmpNo : bmEmpNo}
			   });
			}
		})
	});
	
	function statEdit() {
	   const statNo = document.querySelector("select[name=statNo]").value;
	   const statSpan = document.querySelector("#status${loginMember.empNo}");
	   
	   $.ajax({
	     url: "${root}/address/status",
	     type: "POST",
	     data: {statNo : statNo},
	     success: function (data) {
	       if (data == 1) {
	         toastContent.innerText = "상태를 변경하였습니다.";
	         var status = "bg-secondary";
	         if(statNo == 2) {
	        	 status = "bg-success";
	         } else if(statNo == 3 || statNo == 4) {
	        	 status = "bg-warning";
	         } else if(statNo == 5) {
	        	 status = "bg-danger";
	         }
	         statSpan.className = 'avatar-status';
	         statSpan.classList.add(status);a
	       } else {
	         toastContent.innerText = "변경 실패";
	       }
	     },
	     error: function () {
	       console.log("통신실패");
	     },
	   });
	}
	
	function searchKeyword() {
		const keyword = document.querySelector("input[name=keyword]").value;
		location.href = "${root}/address/${addressParam.nav}/1?keyword=" + keyword;
	}
	
	$().ready(function() {
		$('#address').addClass("active");
	});
	
</script>
</body>
</html>