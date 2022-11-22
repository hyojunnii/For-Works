<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
  <head>
    <title>ForWorks Admin</title>
    <style>
      #sidebarMenu div {
        border-right: 1px solid #ccc;
        min-height: 600px;
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
                <h3>권한 설정</h3>
                <p class="text-subtitle text-muted">그룹 관리자를 지정해보세요</p>
              </div>
              <div class="col-12 col-md-6 order-md-2 order-first p-4 pb-2">
                <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
                  <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${root}/foradmin/oper/2">관리자 설정</a></li>
                    <li class="breadcrumb-item active" aria-current="page">권한 설정</li>
                  </ol>
                </nav>
              </div>
            </div>
          </div>
          <section class="section">
            <div class="card">
              <div class="card-header pb-2">
                <h4 class="card-title">관리자 설정</h4>
              </div>
              <div class="card-body row">
                <nav id="sidebarMenu" class="col-md-3 col-lg-2 d-md-block sidebar collapse p-0">
                  <div class="position-sticky sidebar-sticky">
                    <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 pt-2 mt-3 mb-4">
                      <strong>관리자 목록</strong>
                    </h6>
                    <ul class="nav flex-column mb-2" style="font-size: 15px">
                      <c:forEach items="${operList}" var="ol">
                        <c:if test="${ol.opLevel ne 1}">
                          <li class="nav-item">
                            <a class="nav-link" href="${root}/foradmin/oper/${ol.opLevel}"> ${ol.opName} </a>
                          </li>
                        </c:if>
                      </c:forEach>
                    </ul>
                  </div>
                </nav>
                <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                  <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h4>${opPage}</h4>
                    <div class="btn-toolbar mb-2 mb-md-0">
                      <button data-bs-toggle="modal" data-bs-target="#OperEditModal" type="button" class="btn btn-sm btn-outline-secondary">
                        관리자 추가
                      </button>
                    </div>
                  </div>
                  <div class="my-3 p-3 rounded shadow-sm">
                    <c:forEach items="${opMemberList}" var="om">
                      <div class="d-flex pt-3">
                        <div class="pb-3 mb-0 small lh-sm border-bottom w-100">
                          <div class="d-flex justify-content-between">
                            <strong class="text-gray-dark">${om.empName}</strong>
                            <a href="${root}/foradmin/operremove/${pageLevel}/${om.empNo}" style="color: red">삭제</a>
                          </div>
                          <span class="d-block pt-1">${om.deptName} ${om.posName}</span>
                        </div>
                      </div>
                    </c:forEach>

                    <small class="d-block text-end mt-3">
                      <a href="#">All suggestions</a>
                    </small>
                  </div>
                </main>
              </div>
            </div>
          </section>
        </div>
      </div>
    </div>
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>

    <!-- 관리자 추가 모달 -->
    <div
      class="modal fade"
      id="OperEditModal"
      tabindex="-1"
      aria-labelledby="exampleModalScrollableTitle"
      style="padding-right: 16px"
      aria-modal="true"
      role="dialog"
    >
      <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered" role="document">
        <div class="modal-content">
          <div class="modal-header d-flex" style="flex-direction: column">
            <div class="d-flex" style="justify-content: space-between; width: 100%">
              <h5 class="modal-title" id="exampleModalScrollableTitle" style="font-size: 1.2rem">${opPage} 지정</h5>
              <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  width="24"
                  height="24"
                  viewBox="0 0 24 24"
                  fill="none"
                  stroke="currentColor"
                  stroke-width="2"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  class="feather feather-x"
                >
                  <line x1="18" y1="6" x2="6" y2="18"></line>
                  <line x1="6" y1="6" x2="18" y2="18"></line>
                </svg>
              </button>
            </div>
            <form style="width: 100%" class="p-3 mb-0 pb-0">
              <div>
                <div class="row g-3 align-items-center">
                  <div class="col-auto">
                    <label for="inputPassword6" class="col-form-label h4">직무</label>
                  </div>
                  <div class="col-auto" style="width: 35%">
                    <select name="deptNo" class="form-select" id="basicSelect" required>
                      <c:forEach items="${deptList}" var="dl">
                        <option value="${dl.deptNo}">${dl.deptName}</option>
                      </c:forEach>
                    </select>
                  </div>
                  <div class="col-auto">
                    <label for="inputPassword6" class="col-form-label h4">직급</label>
                  </div>
                  <div class="col-auto" style="width: 35%">
                    <select name="posNo" class="form-select" id="basicSelect" required>
                      <c:forEach items="${posList}" var="pl">
                        <option value="${pl.posNo}">${pl.posName}</option>
                      </c:forEach>
                    </select>
                  </div>
                </div>
              </div>
              <!-- search bar  -->
              <div class="email-fixed-search m-1 mt-3 d-flex" style="width: 100%">
                <div class="form-group position-relative mb-0 has-icon-left" style="width: 68%">
                  <input name="keyword" value="${addressParam.keyword}" name="keyword" type="text" class="form-control" placeholder="이름 검색" />
                  <div class="form-control-icon">
                    <svg class="bi" width="1.5em" height="1.5em">
                      <use xlink:href="${root}/resources/vendors/bootstrap-icons/bootstrap-icons.svg#search" />
                    </svg>
                  </div>
                </div>
                <button type="button" onclick="memberSearch();" class="btn btn-primary" style="width: 18%; margin-left: 3%">검색</button>
              </div>
            </form>
          </div>
          <div id="search-content" class="modal-body pt-0">
          </div>
        </div>
      </div>
    </div>
	
  </body>
  <script>
    function memberSearch() {
      const searchDiv = document.getElementById("search-content");
      while(searchDiv.hasChildNodes()) {
    	  searchDiv.removeChild(searchDiv.firstChild);
      }
    	
      const deptNo = document.querySelector("select[name=deptNo]").value;
      const posNo = document.querySelector("select[name=posNo]").value;
      const keyword = document.querySelector("input[name=keyword]").value;

      $.ajax({
        url: "${root}/foradmin/opersearch",
        type: "POST",
        data: {
          deptNo: deptNo,
          posNo: posNo,
          keyword: keyword
        },
        success: function (data) {
          $(data).each(function () {
            $("#search-content").append(
              '<div class="p-3 mb-0 small lh-sm border-bottom w-100"><div class="d-flex justify-content-between"><strong class="text-gray-dark">' +
                this.empName +
                '</strong><a href="${root}/foradmin/operappend/${pageLevel}/' +
                this.empNo +
                '">지정</a></div><span class="d-block">' +
                this.deptName +
                " " +
                this.posName +
                "</span></div>"
            );
          });
        },
        error: function () {
          console.log("통신실패");
        },
      });
    }
  </script>
</html>
