<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/common/toastify.jsp" %>

<header style="width: 100%">
  <nav class="navbar navbar-expand navbar-light navbar-top pt-4" style="padding-left: 0; padding-right: 0">
    <div class="container-fluid" style="padding-left: 0">
      <a href="#" class="burger-btn d-block gray">
        <i class="bi bi-justify fs-3"></i>
      </a>

      <button
        class="navbar-toggler"
        type="button"
        data-bs-toggle="collapse"
        data-bs-target="#navbarSupportedContent"
        aria-controls="navbarSupportedContent"
        aria-expanded="false"
        aria-label="Toggle navigation"
      >
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav ms-auto mb-lg-0">
        </ul>
        <div class="dropdown pt-3">
          <a href="#" data-bs-toggle="dropdown" aria-expanded="false">
            <div class="user-menu d-flex">
              <div class="user-name text-end me-2" style="padding-top: 5px; padding-right: 8px">
              	<c:choose>
              		<c:when test="${not empty chiefAdmin}">
	                	<h6 class="mb-0 text-gray-600">최고 관리자</h6>
	                	<p class="mb-0 text-sm text-gray-600">4조 주식회사</p>
              		</c:when>
              		<c:otherwise>
		                <h6 class="mb-0 text-gray-600">${loginMember.empName}</h6>
		                <p class="mb-0 text-sm text-gray-600">${loginMember.deptName} ${loginMember.posName}</p>
              		</c:otherwise>	
              	</c:choose>
              </div>
              <div class="user-img d-flex align-items-center">
                <div class="avatar">
                  <c:choose>
                   <c:when test="${not empty loginMember.empProfile}">
                       <img style="border-radius: 30%; width: 45px; height: 45px; object-fit: cover" src="${root}/resources/upload/profile/${loginMember.empProfile}" alt="이미지" />
                   </c:when>
                   <c:otherwise>
		               <img src="${root}/resources/img/member-imgs/user.png" alt="profile" />
                   </c:otherwise>
                  </c:choose>
                </div>
              </div>
            </div>
          </a>
          <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdownMenuButton" style="min-width: 11rem">
            <c:if test="${empty chiefAdmin }">
	            <li>
	              <h6 class="dropdown-header">Hello ${loginMember.empName}!</h6>
	            </li>
	            <li>
	              <a class="dropdown-item" href="${root}"><i class="icon-mid bi bi-wallet me-2"></i> 관리메뉴 나가기</a>
	            </li>
	            <li>
	              <hr class="dropdown-divider" />
	            </li>
            </c:if>
            <li>
              <a class="dropdown-item" href="${root}/logout"><i class="icon-mid bi bi-box-arrow-left me-2"></i> 로그아웃</a>
            </li>
          </ul>
        </div>
      </div>
    </div>
  </nav>
</header>