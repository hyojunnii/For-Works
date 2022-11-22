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
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
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
    
    #external tbody tr:hover {
    	background-color: #eeeeee;
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
	                        	<div class="d-flex mt-3">
                        			<div class="mt-1">
	                        			<h5>외부 주소록</h5>
	                        		</div>
	                        			<a data-bs-toggle="modal" data-bs-target="#modalExInsert" class="icon rounded-pill p-3 pt-0 pb-0">
	                        				<svg id="orderUpIcon" class="" width="1.3em" height="1.3em">
					                            <use xlink:href="${root}/resources/vendors/bootstrap-icons/bootstrap-icons.svg#person-plus-fill"></use>
					                        </svg>
					                    </a>
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
					                        	<a href="${root}/address/external/${(pv.currentPage) - 1}?keyword=${addressParam.keyword}&sort=${addressParam.sort}&order=${addressParam.order}" class="btn btn-sm btn-outline-primary btn-icon email-pagination-prev d-none d-sm-block" style="margin-right: 5px">&lt;</a>
		                        			</c:when>
		                        			<c:when test="${not empty addressParam.keyword}">
					                        	<a href="${root}/address/external/${(pv.currentPage) - 1}?keyword=${addressParam.keyword}" class="btn btn-sm btn-outline-primary btn-icon email-pagination-prev d-none d-sm-block" style="margin-right: 5px">&lt;</a>
		                        			</c:when>
		                        			<c:when test="${not empty addressParam.sort}">
					                        	<a href="${root}/address/external/${(pv.currentPage) - 1}?sort=${addressParam.sort}&order=${addressParam.order}" class="btn btn-sm btn-outline-primary btn-icon email-pagination-prev d-none d-sm-block" style="margin-right: 5px">&lt;</a>
		                        			</c:when>
		                        			<c:otherwise>
					                        	<a href="${root}/address/external/${(pv.currentPage) - 1}" class="btn btn-sm btn-outline-primary btn-icon email-pagination-prev d-none d-sm-block" style="margin-right: 5px">&lt;</a>
		                        			</c:otherwise>
		                        		</c:choose>
		                        	</c:if>
		                        	<c:if test="${pv.currentPage ne pv.maxPage}">
		                        		<c:choose>
		                        			<c:when test="${not empty addressParam.keyword and not empty addressParam.sort}">
					                        	<a href="${root}/address/external/${(pv.currentPage) + 1}?keyword=${addressParam.keyword}&sort=${addressParam.sort}&order=${addressParam.order}" class="btn btn-sm btn-outline-primary btn-icon email-pagination-next d-none d-sm-block" style="margin-right: 5px">&gt;</a>
		                        			</c:when>
			                        		<c:when test="${not empty addressParam.keyword}">
					                        	<a href="${root}/address/external/${(pv.currentPage) + 1}?keyword=${addressParam.keyword}" class="btn btn-sm btn-outline-primary btn-icon email-pagination-next d-none d-sm-block"style="margin-right: 5px">&gt;</a>
		                        			</c:when>
		                        			<c:when test="${not empty addressParam.sort}">
					                        	<a href="${root}/address/external/${(pv.currentPage) + 1}?sort=${addressParam.sort}&order=${addressParam.order}" class="btn btn-sm btn-outline-primary btn-icon email-pagination-next d-none d-sm-block"style="margin-right: 5px">&gt;</a>
		                        			</c:when>
		                        			<c:otherwise>
					                        	<a href="${root}/address/external/${(pv.currentPage) + 1}" class="btn btn-sm btn-outline-primary btn-icon email-pagination-next d-none d-sm-block"style="margin-right: 5px">&gt;</a>
		                        			</c:otherwise>
		                        		</c:choose>
		                        	</c:if>
			                    </div>
                    	</div>
                    	</div>
                        <div class="card-body" style="padding-left: 20px">
		                    <div>
                              <table class="table" id="external" style="text-align: center">
                                <thead>
                                  <tr>
                                    <th></th>
                                    <th>
                                    	<c:choose>
                                    		<c:when test="${addressParam.order eq 'desc'}">
						                        <c:choose>
                                    				<c:when test="${not empty addressParam.keyword}">
								                        <a href="${root}/address/external/1?keyword=${addressParam.keyword}&sort=name&order=asc">이름</a>
				                                    	<svg id="orderUpIcon" class="mb-1" width="0.8em" height="0.8em">
								                            <use xlink:href="${root}/resources/vendors/bootstrap-icons/bootstrap-icons.svg#arrow-up"></use>
								                        </svg>
                                    				</c:when>
                                    				<c:otherwise>
                                    					<a href="${root}/address/external/1?sort=name&order=asc">이름</a>
				                                    	<svg id="orderUpIcon" class="mb-1" width="0.8em" height="0.8em">
								                            <use xlink:href="${root}/resources/vendors/bootstrap-icons/bootstrap-icons.svg#arrow-up"></use>
								                        </svg>
                                    				</c:otherwise>
                                    			</c:choose>
                                    		</c:when>
                                    		<c:otherwise>
						                        <c:choose>
                                    				<c:when test="${not empty addressParam.keyword}">
				                                    	<a href="${root}/address/external/1?keyword=${addressParam.keyword}&sort=name&order=desc">이름</a>
				                                    	<svg id="orderDownIcon" class="mb-1" width="0.8em" height="0.8em">
								                            <use xlink:href="${root}/resources/vendors/bootstrap-icons/bootstrap-icons.svg#arrow-down"></use>
								                        </svg>
                                    				</c:when>
                                    				<c:otherwise>
                                    					<a href="${root}/address/external/1?sort=name&order=desc">이름</a>
				                                    	<svg id="orderDownIcon" class="mb-1" width="0.8em" height="0.8em">
								                            <use xlink:href="${root}/resources/vendors/bootstrap-icons/bootstrap-icons.svg#arrow-down"></use>
								                        </svg>
                                    				</c:otherwise>
                                    			</c:choose>
                                    		</c:otherwise>
                                    	</c:choose>
                                    </th>
                                    <th>회사명</th>
                                    <th>부서/직급</th>
                                    <th>전화번호</th>
                                    <th>이메일</th>
                                    <th>비고</th>
                                  </tr>
                                </thead>
                                <tbody>
                                  	<c:forEach items="${addressList}" var="l">
	                                  <tr id="ex${l.addNo}" onclick="EditModalPopup(this)">
	                                  	<td></td>
	                                    <td style="display:none">${l.addNo}</td>
	                                    <td>${l.addName}</td>
	                                    <td>${l.addCompany}</td>
	                                    <td>${l.addJob}</td>
	                                    <td>${l.addPhone}</td>
	                                    <td>${l.addEmail}</td>
	                                    <td>${l.addNote}</td>
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
		
	<!-- 주소록 추가 모달 -->
    <div class="modal fade" tabindex="-1" id="modalExInsert" role="dialog">
	 <div class="modal-dialog modal-dialog-centered" role="document">
	   <div class="modal-content rounded-4 shadow">
	     <div class="modal-header p-5 pb-4 border-bottom-0">
	       <!-- <h1 class="modal-title fs-5" >Modal title</h1> -->
	        <h1 class="fw-bold mb-0 fs-2">외부 주소록 추가</h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	
	      <div class="modal-body p-5 pt-0">
	        <form action="${root}/address/external/insert" method="post">
	          <div class="form-floating mb-3">
	            <input name="addName" type="text" class="form-control rounded-4" required>
	            <label for="add_name">* 이름(닉네임)</label>
	          </div>
	          <div class="form-floating mb-3">
	          	<input name="addCompany" type="text" class="form-control rounded-4" >
	            <label for="add_company">회사명</label>
	          </div>
	          <div class="form-floating mb-3">
	            <input name="addJob" type="text" class="form-control rounded-4" >
	            <label for="add_job">부서/직급</label>
	          </div>
	          <div class="form-floating mb-3">
	            <input name="addPhone" type="text" class="form-control rounded-4">
	            <label for="add_phone">전화번호</label>
	          </div>
	          <div class="form-floating mb-3">
	            <input name="addEmail" type="text" class="form-control rounded-4" >
	            <label for="add_email">이메일</label>
	          </div>
	          <div class="form-floating mb-3">
	          	<input name="addNote" type="text" class="form-control rounded-4" maxlength="20">
	            <label for="add_Note">비고 (최대 20글자)</label>
	          </div>
	          <button class="w-100 mb-2 btn btn-lg rounded-4 btn-secondary" type="submit">추가하기</button>
	        </form>
	      </div>
	    </div>
	  </div>
	</div>
	
	<!-- 주소록 수정/삭제 모달 -->
    <div class="modal fade" tabindex="-1" id="modalExUpdate" role="dialog">
	 <div class="modal-dialog modal-dialog-centered" role="document">
	   <div class="modal-content rounded-4 shadow">
	     <div class="modal-header p-5 pb-4 border-bottom-0">
	       <!-- <h1 class="modal-title fs-5" >Modal title</h1> -->
	        <h1 class="fw-bold mb-0 fs-2">주소록 상세보기</h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	
	      <div class="modal-body p-5 pt-0">
	        <form action="${root}/address/external/edit" method="post">
	          <input name="addNo" type="hidden" id="add_no"/>
	          <div class="form-floating mb-3">
	            <input name="addName" type="text" class="form-control rounded-4" id="add_name" required>
	            <label for="add_name">* 이름(닉네임)</label>
	          </div>
	          <div class="form-floating mb-3">
	          	<input name="addCompany" type="text" class="form-control rounded-4" id="add_company" >
	            <label for="add_company">회사명</label>
	          </div>
	          <div class="form-floating mb-3">
	            <input name="addJob" type="text" class="form-control rounded-4" id="add_job" >
	            <label for="add_job">부서/직급</label>
	          </div>
	          <div class="form-floating mb-3">
	            <input name="addPhone" type="text" class="form-control rounded-4" id="add_phone">
	            <label for="add_phone">전화번호</label>
	          </div>
	          <div class="form-floating mb-3">
	            <input name="addEmail" type="text" class="form-control rounded-4" id="add_email" >
	            <label for="add_email">이메일</label>
	          </div>
	          <div class="form-floating mb-3">
	          	<input name="addNote" type="text" class="form-control rounded-4" id="add_note" maxlength="20">
	            <label for="add_note">비고 (최대 20글자)</label>
	          </div>
	          <div class="d-flex" style="justify-content: flex-end;">
		          <button class="w-80 mb-2 btn btn-lg rounded-4 btn-secondary" type="submit" style="margin-right: 10px;">수정하기</button>
		          <button class="w-20 mb-2 btn btn-lg rounded-4 btn-danger" type="button" onclick="ExDelete();">삭제</button>
	          </div>
	        </form>
	      </div>
	    </div>
	  </div>
	</div>
<script>
	function EditModalPopup(clicked_tr) {
		var row_td = clicked_tr.getElementsByTagName("td");
		
		document.getElementById("add_no").value = row_td[1].innerHTML;   
		document.getElementById("add_name").value = row_td[2].innerHTML;   
		document.getElementById("add_company").value = row_td[3].innerHTML;
		document.getElementById("add_job").value = row_td[4].innerHTML;   
		document.getElementById("add_phone").value = row_td[5].innerHTML;   
		document.getElementById("add_email").value = row_td[6].innerHTML;
		document.getElementById("add_note").value = row_td[7].innerHTML;
		
		$('#modalExUpdate').modal('show');
	}
	
	function ExDelete() {
		swal({
		  title: "삭제하시겠습니까?",
		  text: "삭제하면 다시 되돌릴 수 없습니다.",
		  buttons: true,
		  dangerMode: true,
		})
		.then((willDelete) => {
		  if (willDelete) {
			const addNo = document.getElementById("add_no").value;
			  
			$.ajax({
	          url: "${root}/address/external/delete",
	          type: "post",
	          data: {
	            addNo: addNo
	          },
	          success: function (data) {
	            if (data == 1) {
            	swal("삭제하였습니다.", {
      		      icon: "success",
      		    });
            	$('#modalExUpdate').modal('hide');
            	$('#ex'+ addNo).remove();
	            }
	          },
	          error: function (e) {
	        	swal("접속 실패", {
	  		      icon: "warning",
	  		    });
	          },
	        });
		  } else {
		    swal("다시 승인을 진행해주세요.");
		  }
		});
	}
</script>
<script>
	function statEdit() {
	   const statNo = document.querySelector("select[name=statNo]").value;
	   $.ajax({
	     url: "${root}/address/status",
	     type: "POST",
	     data: {statNo : statNo},
	     success: function (data) {
	       if (data == 1) {
	         toastContent.innerText = "상태를 변경하였습니다.";
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
		location.href = "${root}/address/external/1?keyword=" + keyword;
	}
	
	$().ready(function() {
		$('#address').addClass("active");
	});
</script>
</body>
</html>