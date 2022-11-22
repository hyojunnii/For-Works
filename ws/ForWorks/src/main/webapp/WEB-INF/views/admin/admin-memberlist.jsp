<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>ForWorks Admin</title>

    <link rel="stylesheet" href="${root}/resources/css/address/email.css" />
    <link rel="stylesheet" href="${root}/resources/css/address/style.css" />
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

      .pagination span,
      .pagination button {
        margin: 0 5px;
      }

      #member-table tbody > tr:hover {
        background-color: #eeeeee;
      }
    </style>
  </head>
  <body>
    <div id="app">
      <%@ include file="/WEB-INF/views/admin/admin-sidebar.jsp" %>

      <div id="main" class="pt-0">
        <%@ include file="/WEB-INF/views/admin/admin-header.jsp" %>
        <div class="page-heading">
          <div class="page-title">
            <div class="row">
              <div class="col-12 col-md-6 order-md-1 order-last">
                <h3>구성원 설정</h3>
                <p class="text-subtitle text-muted p-1">조직 구성원을 관리해보세요</p>
              </div>
              <div class="col-12 col-md-6 order-md-2 order-first p-4 pb-2">
                <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
                  <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${root}/foradmin/member/1">구성원 설정</a></li>
                    <li class="breadcrumb-item active" aria-current="page">구성원 조회</li>
                  </ol>
                </nav>
              </div>
            </div>
          </div>
          <section class="section">
            <div class="card" style="min-height: 700px">
              <div class="card-header m-0 p-4 pt-3">
                <div class="mt-4">
                  <h5>구성원 조회</h5>
                </div>
                <div class="d-flex align-items-center justify-content-between">
                  <!-- search bar  -->
                  <div class="email-fixed-search flex-grow-1 mt-2">
                    <div class="form-group position-relative mb-0 has-icon-left">
                      <input
                        value="${addressParam.keyword}"
                        name="keyword"
                        type="text"
                        class="form-control"
                        onkeypress="if(event.keyCode == 13){searchKeyword();}"
                        placeholder="이름 검색"
                        style="max-width: 600px; width: 60%"
                      />
                      <div class="form-control-icon">
                        <svg class="bi" width="1.5em" height="1.5em" fill="currentColor">
                          <use xlink:href="${root}/resources/vendors/bootstrap-icons/bootstrap-icons.svg#search" />
                        </svg>
                      </div>
                    </div>
                  </div>
                  <!-- pagination and page count -->
                  <div class="d-flex align-items-center">
                    <c:choose>
                      <c:when test="${(pv.currentPage eq pv.maxPage) or (pv.listCount lt 10)}">
                        <span class="d-none d-sm-block" style="margin: 0 10px"
                          >${pv.currentPage*pv.boardLimit - (pv.boardLimit-1)}-${pv.listCount} of ${pv.listCount}</span
                        >
                      </c:when>
                      <c:otherwise>
                        <span class="d-none d-sm-block" style="margin: 0 10px"
                          >${pv.currentPage*pv.boardLimit - (pv.boardLimit-1)}-${pv.currentPage * pv.boardLimit} of ${pv.listCount}</span
                        >
                      </c:otherwise>
                    </c:choose>
                    <c:if test="${pv.currentPage ne 1}">
                      <c:choose>
                        <c:when test="${not empty addressParam.keyword and not empty addressParam.sort}">
                          <a
                            href="${root}/foradmin/member/${(pv.currentPage) - 1}?keyword=${addressParam.keyword}&sort=${addressParam.sort}&order=${addressParam.order}"
                            class="btn btn-sm btn-outline-primary btn-icon email-pagination-prev d-none d-sm-block"
                            style="margin-right: 5px"
                            >&lt;</a
                          >
                        </c:when>
                        <c:when test="${not empty addressParam.keyword}">
                          <a
                            href="${root}/foradmin/member/${(pv.currentPage) - 1}?keyword=${addressParam.keyword}"
                            class="btn btn-sm btn-outline-primary btn-icon email-pagination-prev d-none d-sm-block"
                            style="margin-right: 5px"
                            >&lt;</a
                          >
                        </c:when>
                        <c:when test="${not empty addressParam.sort}">
                          <a
                            href="${root}/foradmin/member/${(pv.currentPage) - 1}?sort=${addressParam.sort}&order=${addressParam.order}"
                            class="btn btn-sm btn-outline-primary btn-icon email-pagination-prev d-none d-sm-block"
                            style="margin-right: 5px"
                            >&lt;</a
                          >
                        </c:when>
                        <c:otherwise>
                          <a
                            href="${root}/foradmin/member/${(pv.currentPage) - 1}"
                            class="btn btn-sm btn-outline-primary btn-icon email-pagination-prev d-none d-sm-block"
                            style="margin-right: 5px"
                            >&lt;</a
                          >
                        </c:otherwise>
                      </c:choose>
                    </c:if>
                    <c:if test="${pv.currentPage ne pv.maxPage}">
                      <c:choose>
                        <c:when test="${not empty addressParam.keyword and not empty addressParam.sort}">
                          <a
                            href="${root}/foradmin/member/${(pv.currentPage) + 1}?keyword=${addressParam.keyword}&sort=${addressParam.sort}&order=${addressParam.order}"
                            class="btn btn-sm btn-outline-primary btn-icon email-pagination-next d-none d-sm-block"
                            style="margin-right: 5px"
                            >&gt;</a
                          >
                        </c:when>
                        <c:when test="${not empty addressParam.keyword}">
                          <a
                            href="${root}/foradmin/member/${(pv.currentPage) + 1}?keyword=${addressParam.keyword}"
                            class="btn btn-sm btn-outline-primary btn-icon email-pagination-next d-none d-sm-block"
                            style="margin-right: 5px"
                            >&gt;</a
                          >
                        </c:when>
                        <c:when test="${not empty addressParam.sort}">
                          <a
                            href="${root}/foradmin/member/${(pv.currentPage) + 1}?sort=${addressParam.sort}&order=${addressParam.order}"
                            class="btn btn-sm btn-outline-primary btn-icon email-pagination-next d-none d-sm-block"
                            style="margin-right: 5px"
                            >&gt;</a
                          >
                        </c:when>
                        <c:otherwise>
                          <a
                            href="${root}/foradmin/member/${(pv.currentPage) + 1}"
                            class="btn btn-sm btn-outline-primary btn-icon email-pagination-next d-none d-sm-block"
                            style="margin-right: 5px"
                            >&gt;</a
                          >
                        </c:otherwise>
                      </c:choose>
                    </c:if>
                  </div>
                </div>
              </div>
              <div class="card-body" style="padding-left: 20px">
                <div>
                  <table class="table" id="member-table" style="text-align: center">
                    <thead>
                      <tr>
                      	<th></th>
                        <th>
                          <c:choose>
                            <c:when test="${addressParam.sort eq 'name' and addressParam.order eq 'desc'}">
                              <c:choose>
                                <c:when test="${not empty addressParam.keyword}">
                                  <a href="${root}/foradmin/member/1?keyword=${addressParam.keyword}&sort=name&order=asc">이름</a>
                                  <svg id="orderUpIcon" class="mb-1" width="0.8em" height="0.8em">
                                    <use xlink:href="${root}/resources/vendors/bootstrap-icons/bootstrap-icons.svg#arrow-up"></use>
                                  </svg>
                                </c:when>
                                <c:otherwise>
                                  <a href="${root}/foradmin/member/1?sort=name&order=asc">이름</a>
                                  <svg id="orderUpIcon" class="mb-1" width="0.8em" height="0.8em">
                                    <use xlink:href="${root}/resources/vendors/bootstrap-icons/bootstrap-icons.svg#arrow-up"></use>
                                  </svg>
                                </c:otherwise>
                              </c:choose>
                            </c:when>
                            <c:otherwise>
                              <c:choose>
                                <c:when test="${not empty addressParam.keyword}">
                                  <a href="${root}/foradmin/member/1?keyword=${addressParam.keyword}&sort=name&order=desc">이름</a>
                                  <svg id="orderDownIcon" class="mb-1" width="0.8em" height="0.8em">
                                    <use xlink:href="${root}/resources/vendors/bootstrap-icons/bootstrap-icons.svg#arrow-down"></use>
                                  </svg>
                                </c:when>
                                <c:otherwise>
                                  <a href="${root}/foradmin/member/1?sort=name&order=desc">이름</a>
                                  <svg id="orderDownIcon" class="mb-1" width="0.8em" height="0.8em">
                                    <use xlink:href="${root}/resources/vendors/bootstrap-icons/bootstrap-icons.svg#arrow-down"></use>
                                  </svg>
                                </c:otherwise>
                              </c:choose>
                            </c:otherwise>
                          </c:choose>
                        </th>
                        <th>생년월일</th>
                        <th>부서</th>
                        <th>직급</th>
                        <th>관리 레벨</th>
                        <th>
                          <c:choose>
                            <c:when test="${addressParam.sort eq 'status' and addressParam.order eq 'asc'}">
                              <c:choose>
                                <c:when test="${not empty addressParam.keyword}">
                                  <a href="${root}/foradmin/member/1?keyword=${addressParam.keyword}&sort=status&order=desc">계정 상태</a>
                                  <svg id="orderUpIcon" class="mb-1" width="0.8em" height="0.8em">
                                    <use xlink:href="${root}/resources/vendors/bootstrap-icons/bootstrap-icons.svg#arrow-up"></use>
                                  </svg>
                                </c:when>
                                <c:otherwise>
                                  <a href="${root}/foradmin/member/1?sort=status&order=desc">계정 상태</a>
                                  <svg id="orderUpIcon" class="mb-1" width="0.8em" height="0.8em">
                                    <use xlink:href="${root}/resources/vendors/bootstrap-icons/bootstrap-icons.svg#arrow-up"></use>
                                  </svg>
                                </c:otherwise>
                              </c:choose>
                            </c:when>
                            <c:otherwise>
                              <c:choose>
                                <c:when test="${not empty addressParam.keyword}">
                                  <a href="${root}/foradmin/member/1?keyword=${addressParam.keyword}&sort=status&order=asc">계정 상태</a>
                                  <svg id="orderDownIcon" class="mb-1" width="0.8em" height="0.8em">
                                    <use xlink:href="${root}/resources/vendors/bootstrap-icons/bootstrap-icons.svg#arrow-down"></use>
                                  </svg>
                                </c:when>
                                <c:otherwise>
                                  <a href="${root}/foradmin/member/1?sort=status&order=asc">계정 상태</a>
                                  <svg id="orderDownIcon" class="mb-1" width="0.8em" height="0.8em">
                                    <use xlink:href="${root}/resources/vendors/bootstrap-icons/bootstrap-icons.svg#arrow-down"></use>
                                  </svg>
                                </c:otherwise>
                              </c:choose>
                            </c:otherwise>
                          </c:choose>
                        </th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach items="${memberList}" var="l">
                        <tr id="emp${l.empNo}" style="height: 50px">
                          <td></td>
                          <td style="display: none">${l.empNo}</td>
                          <td>${l.empName}</td>
                          <td>${l.empRegno}</td>
                          <td>${l.deptName}</td>
                          <td>${l.posName}</td>
                          <c:choose>
                          	<c:when test="${l.opLevel ne 1}">
                          		<td>${l.opName}</td>
                          	</c:when>
                          	<c:otherwise>
	                          	<td></td>
                          	</c:otherwise>
                          </c:choose>
                          <c:choose>
                          	<c:when test="${l.empStatus ne 'Y'}">
                          		<td style="color: red;">일시정지</td>
                          	</c:when>
                          	<c:otherwise>
	                          	<td>사용중</td>
                          	</c:otherwise>
                          </c:choose>
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
    </div>
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>

    <!-- 구성원 정보수정 모달 -->
    <div class="modal fade" tabindex="1" id="modalMemberEdit">
      <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content rounded-4 shadow">
          <div class="modal-header p-5 pb-4 border-bottom-0">
            <h2 class="fw-bold mb-0 fs-3">구성원 정보</h2>
            <div class="dropdown-center" style="margin-left: 115px;">
			  <button class="btn btn-sm btn-primary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
			    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-edit"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"></path><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"></path></svg>
			    상태변경
			  </button>
			  <ul class="dropdown-menu" style="min-width: 70px; font-size: 0.9rem; border:0.5px solid #eee;">
			    <li id="pauseBtn"><a class="dropdown-item" data-bs-target="#memberPauseModal" data-bs-toggle="modal">일시정지</a></li>
			    <li id="pausedBtn"><a class="dropdown-item" onclick="memberUnpause();">일시정지 해제</a></li>
			    <li><a class="dropdown-item" data-bs-target="#memberQuitModal" data-bs-toggle="modal">구성원 삭제</a></li>
			  </ul>
			</div>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>

          <div class="modal-body p-5 pt-0">
            <form action="${root}/foradmin/memberEdit" method="post">
              <input name="empNo" type="hidden" class="form-control rounded-4" id="emp_no" />
              <div class="form-floating mb-3">
                <input name="empName" type="text" class="form-control rounded-4" id="emp_name" required/>
                <label for="emp_name">성명</label>
              </div>
              <div class="form-floating mb-3">
                <select name="deptNo" class="form-control rounded-4" id="emp_dept" required>
                  <c:forEach items="${deptList}" var="dl">
	                  <option value="${dl.deptNo}">${dl.deptName}</option>
                  </c:forEach>
                </select>
                <label for="emp_dept">직무</label>
              </div>
              <div class="form-floating mb-3">
                <select name="posNo" class="form-control rounded-4" id="emp_pos" required>
                  <c:forEach items="${posList}" var="pl">
	                  <option value="${pl.posNo}">${pl.posName}</option>
                  </c:forEach>
                </select>
                <label for="emp_pos">직급</label>
              </div>
              <div class="form-floating mb-3">
                <input name="empMoney" type="number" class="form-control rounded-4" id="emp_money" required/>
                <label for="emp_money">연봉</label>
              </div>
              <div class="form-floating mb-3">
                <input name="empExphone" type="text" class="form-control rounded-4" id="emp_exphone" />
                <label for="emp_exphone">내선번호</label>
              </div>
              <div class="form-floating mb-2">
                <input name="empJdate" type="text" class="form-control rounded-4" id="emp_jdate" required/>
                <label for="emp_jdate">입사일</label>
              </div>
              <div class="checkbox p-1 mb-2">
                <input type="checkbox" id="checkbox1" class="form-check-input" required>
                <label for="checkbox1">정보를 변경하겠습니다.</label>
              </div>
              <button class="w-100 mb-2 btn btn-lg rounded-4 btn-outline-primary" type="submit">변경하기</button>
            </form>
          </div>
        </div>
      </div>
    </div>
    
    <!-- 구성원 일시정지 모달 -->
    <div class="modal fade" tabindex="-1" role="dialog" id="memberPauseModal">
	  <div class="modal-dialog modal-dialog-centered" role="document" style="width: 450px;">
	    <div class="modal-content rounded-3 shadow">
	      <div class="modal-body p-4 text-center">
	        <h5 class="mb-3 mt-1">일시정지 하시겠습니까?</h5>
	        <p class="mb-2">'<span id="pauseMember"></span>'</p>
	        <p class="mb-2">일시정지된 구성원은 FORWORKS 서비스를 <br> 더 이상 이용할 수 없습니다.</p>
	        <p class="mb-2">구성원의 계정과 데이터는 삭제되지 않으며, <br> 관리자 직위가 해제됩니다.</p>
	        <p class="mb-2">[일시정지 해제]를 통해 정지를 해제할 수 있습니다.</p>
	      </div>
	      <div class="modal-footer flex-nowrap p-0">
	        <button type="button" class="btn btn-lg btn-link fs-6 text-decoration-none col-6 p-2 m-0 rounded-0 text-muted" data-bs-dismiss="modal">취소</button>
	        <button type="button" onclick="memberPause();" class="btn btn-lg btn-link fs-6 text-decoration-none col-6 p-2 m-0 rounded-0 border-end"><strong>확인</strong></button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<!-- 구성원 삭제 모달 -->
    <div class="modal fade" tabindex="-1" role="dialog" id="memberQuitModal">
	  <div class="modal-dialog modal-dialog-centered" role="document">
	    <div class="modal-content rounded-3 shadow">
	      <div class="modal-body p-4 text-center">
	        <h5 class="mb-3 mt-1">구성원을 삭제하시겠습니까?</h5>
	        <p class="mb-2">'<span id="quitMember"></span>'</p>
	        <p class="mb-0">삭제된 구성원은 FORWORKS 서비스를 <br> 더 이상 이용할 수 없으며 다시 되돌릴 수 없습니다.</p>
	      </div>
	      <div class="modal-footer flex-nowrap p-0">
	        <button type="button" class="btn btn-lg btn-link fs-6 text-decoration-none col-6 m-0 rounded-0" data-bs-dismiss="modal">취소</button>
	        <button type="button" onclick="memberDelete();" class="btn btn-lg btn-link fs-6 text-decoration-none col-6 m-0 rounded-0 border-end"><strong>확인</strong></button>
	      </div>
	    </div>
	  </div>
	</div>
  </body>
  <script>
  	//검색
    function searchKeyword() {
      const keyword = document.querySelector("input[name=keyword]").value;
      location.href = "${root}/foradmin/member/1?keyword=" + keyword;
    }

  	//상세 모달
    $("#member-table tbody tr").click(function () {
      const td = $(this).children();
      const empNo = td.eq(1).text();

      $.ajax({
        url: "${root}/foradmin/memberInfo",
        type: "POST",
        data: {
          empNo: empNo,
        },
        success: function (data) {
          document.getElementById("emp_no").value = td.eq(1).text();
          document.getElementById("emp_name").value = td.eq(2).text();

          $("#emp_pos").val(data.posNo).prop("selected", true);
          $("#emp_dept").val(data.deptNo).prop("selected", true);

          document.getElementById("emp_money").value = data.empMoney;
          document.getElementById("emp_exphone").value = data.empExphone;
          document.getElementById("emp_jdate").value = data.empJdate;
          
          console.log(data.empStatus);
          
          if(data.empStatus == "N") {
        	  document.getElementById("pauseBtn").style.display = "none";
        	  document.getElementById("pausedBtn").style.display = "block";
          } else {
        	  document.getElementById("pausedBtn").style.display = "none";
        	  document.getElementById("pauseBtn").style.display = "block";
          }

          $("#modalMemberEdit").modal("show");
        },
        error: function () {
          console.log("통신실패");
        },
      });
    });
    
    $("#memberPauseModal").on('show.bs.modal', function(e) {
  		const name = document.getElementById("emp_name").value;
  		document.getElementById("pauseMember").innerHTML = name;
  	})
  	
  	$("#memberQuitModal").on('show.bs.modal', function(e) {
  		const name = document.getElementById("emp_name").value;
  		document.getElementById("quitMember").innerHTML = name;
  	})
  	
  	//구성원 일시정지
  	function memberPause() {
  		const no = document.getElementById("emp_no").value;
    	
  		$.ajax({
	        url: "${root}/foradmin/memberStatus",
	        type: "POST",
	        data: {
	          empNo: no,
	          empStatus: "N",
	          empRdate: null
	        },
	        success: function (data) {
	           if (data == 1) {
		         toastContent.innerText = "일시정지 되었습니다.";
			     $("#emp"+no).find("td:eq(7)").html("<span style='color:red;'>일시정지</span>");
			     $("#emp"+no).find("td:eq(6)").html("");
	           }
	           $("#memberPauseModal").modal("hide");
	        },
	        error: function () {
	          console.log("통신실패");
	        },
	     });
    }
    
    //구성원 일시정지 해제
    function memberUnpause() {
		const no = document.getElementById("emp_no").value;
    	
  		$.ajax({
	        url: "${root}/foradmin/memberStatus",
	        type: "POST",
	        data: {
	          empNo: no,
	          empStatus: "Y",
	          empRdate: null
	        },
	        success: function (data) {
	           if (data == 1) {
		         toastContent.innerText = "일시정지를 해제하였습니다.";
			     $("#emp"+no).find("td:eq(7)").html("<span style='color:#607080;'>사용중</span>");
			     $("#modalMemberEdit").modal("hide");
	           }
	        },
	        error: function () {
	          console.log("통신실패");
	        },
	     });
    }
    
    function memberDelete() {
		const no = document.getElementById("emp_no").value;
    	
  		$.ajax({
	        url: "${root}/foradmin/memberStatus",
	        type: "POST",
	        data: {
	          empNo: no,
	          empStatus: "N",
	          empRdate: "Y"
	        },
	        success: function (data) {
	           if (data == 1) {
		         toastContent.innerText = "구성원을 삭제하였습니다.";
			     $("#emp"+no).remove();
			     $("#memberQuitModal").modal("hide");
	           }
	        },
	        error: function () {
	          console.log("통신실패");
	        },
	     });
    }
  </script>
</html>
