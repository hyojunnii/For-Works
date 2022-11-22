<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<html>
  <head>
    <title>ForWorks</title>
    <style>
      .input-size {
        max-width: 350px;
      }

      .img-edit-plus {
        top: -10px;
      }

      .info-flex {
        display: flex;
        flex-direction: column;
      }

      .info-span {
        padding-bottom: 25px;
      }

      .user-edit {
        margin-left: 20px;
      }

      #profile {
        position: absolute;
      }

      #profile-img {
        margin-left: 5px;
        bottom: 5px;
      }

      #profile-edit {
        position: relative;
        top: 22px;
        right: 25px;
        width: 30px;
        height: 30px;
        background-color: #ffffff;
        border: 1px solid #eeeeee;
        border-radius: 50%;
        padding-top: 5px;
        padding-left: 5px;
      }

      #profile-edit:hover {
        border: 1px solid #d3d3d3;
      }
    </style>
  </head>
  <body>
    <div id="app">
      <%@ include file="/WEB-INF/views/common/sidebar.jsp" %>

      <div id="main">
        <%@ include file="/WEB-INF/views/common/header.jsp" %>

        <div class="page-heading">
          <div class="page-title">
            <div class="row">
              <div class="col-12 col-md-6 order-md-1 order-last mt-2 mb-4">
                <h3>마이페이지</h3>
              </div>
            </div>
          </div>
          <div class="page-content">
            <section class="section d-flex">
              <%@ include file="/WEB-INF/views/member/mypage-sidebar.jsp" %>
              <div class="card" style="width: calc(100% - 300px); min-width: 500px; padding: 5px; overflow: auto">
                <div class="card-header mt-1">
                  <h4>내 정보 조회</h4>
                </div>
                <div class="card-body">
                  <div class="user-info row m-3 mb-4 mt-0">
                    <div class="row row-cols-1 row-cols-md-4">
                      <div class="col themed-grid-col">
                        <div id="profile">
                         <form id="profile-form" action="${root}/member/profileEdit" method="post" enctype="multipart/form-data">
                          <div id="profile-img" class="avatar avatar-xl img-edit">
                          	<c:choose>
                          		<c:when test="${not empty loginMember.empProfile}">
	                            	<img id="profile-thumb" style="border-radius: 40%; object-fit: cover; width: 80px; height: 80px" src="${root}/resources/upload/profile/${loginMember.empProfile}" alt="이미지" />
                          		</c:when>
                          		<c:otherwise>
	                            	<img id="profile-thumb" style="width: 80px; height: 80px" src="${root}/resources/img/member-imgs/user.png" alt="이미지" />
                          		</c:otherwise>
                          	</c:choose>
                          </div>
                          <button id="profile-edit" class="btn dropdown-toggle" data-bs-toggle="dropdown" data-bs-display="static" aria-expanded="false">
                            <i class="bi bi-camera-fill"></i>
                          </button>
                          <ul class="dropdown-menu" style="min-width: 50px; left: 65px; top: 79px; border: 1px solid #eee">
						    <li><label for="profile-input" class="dropdown-item">변경</label></li>
						    <c:if test="${not empty loginMember.empProfile}">
						    	<li><a class="dropdown-item" href="${root}/member/profileDelete">삭제</a></li>
						    </c:if>
						  </ul>
                          <input name="profile" type="file" id="profile-input" style="display: none" />
                         </form>
                        </div>
                      </div>
                      <div class="col themed-grid-col"><h5 class="mt-4">${loginMember.empName}</h5></div>
                      <div class="col themed-grid-col info-flex">
                        <h6 class="info-span">부서</h6>
                        <h6>직급</h6>
                      </div>
                      <div class="col themed-grid-col info-flex">
                        <span class="info-span">${loginMember.deptName}</span><span>${loginMember.posName}</span>
                      </div>
                    </div>
                    <div class="row row-cols-1 row-cols-md-4 gy-4 mt-0">
                      <div class="col themed-grid-col"><h6>아이디</h6></div>
                      <div class="col themed-grid-col">${loginMember.empId}</div>
                      <div class="col themed-grid-col"><h6>내선번호</h6></div>
                      <div class="col themed-grid-col">${loginMember.empExphone}</div>
                      <div class="col themed-grid-col"><h6>주민번호</h6></div>
                      <div class="col themed-grid-col">${loginMember.empRegno}</div>
                      <div class="col themed-grid-col"><h6>입사일</h6></div>
                      <div class="col themed-grid-col">${loginMember.empJdate}</div>
                    </div>
                  </div>
                  <div class="divider divider-left mb-3">
                    <div class="divider-text"><h6>연락처 변경</h6></div>
                  </div>
                  <div class="user-edit">
                    <form action="" method="post">
                      <div class="row mb-3">
                        <label for="inputEmail3" class="col-sm-2 col-form-label" style="width: 90px">이메일</label>
                        <div class="col-sm-10">
                          <input
                            name="empEmail"
                            value="${loginMember.empEmail}"
                            type="email"
                            class="form-control input-size"
                            id="inputEmail3"
                            placeholder="someone@example.com"
                            required
                          />
                        </div>
                      </div>
                      <div class="row mb-3">
                        <label for="inputPhone" class="col-sm-2 col-form-label" style="width: 90px">휴대전화</label>
                        <div class="col-sm-10">
                          <input
                            name="empPhone"
                            value="${loginMember.empPhone}"
                            type="text"
                            class="form-control input-size"
                            id="inputPhone"
                            placeholder="01012345678"
                            maxlength="11"
                            required
                          />
                        </div>
                      </div>
                      <div class="row mb-3">
                        <label for="inputPassword3" class="col-sm-2 col-form-label" style="width: 90px">주소</label>
                        <div class="col-sm-10">
                          <div class="d-flex input-size">
                            <input
                              name="empPcode"
                              value="${loginMember.empPcode}"
                              class="form-control"
                              type="text"
                              id="sample6_postcode"
                              placeholder="우편번호"
                              maxlength="5"
                              required
                            />
                            <input class="btn btn-outline-primary" type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" />
                          </div>
                          <input
                            name="empAddr1"
                            value="${loginMember.empAddr1}"
                            class="form-control input-size"
                            type="text"
                            id="sample6_address"
                            placeholder="주소"
                            required
                          />
                          <input
                            name="empAddr2"
                            value="${loginMember.empAddr2}"
                            class="form-control input-size"
                            type="text"
                            id="sample6_detailAddress"
                            placeholder="상세주소"
                            required
                          />
                          <div class="d-flex">
                            <input
                              name="empAddr3"
                              value="${loginMember.empAddr3}"
                              class="form-control input-size"
                              type="text"
                              id="sample6_extraAddress"
                              placeholder="참고항목"
                            />
                            <button type="submit" class="btn btn-primary me-1 mb-1" style="margin-left: 20px">변경하기</button>
                          </div>
                        </div>
                      </div>
                    </form>
                  </div>
                </div>
              </div>
            </section>
          </div>
        </div>
      </div>
    </div>
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
  </body>
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script type="text/javascript">
    function sample6_execDaumPostcode() {
      new daum.Postcode({
        oncomplete: function (data) {
          // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

          // 각 주소의 노출 규칙에 따라 주소를 조합한다.
          // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
          var addr = ""; // 주소 변수
          var extraAddr = ""; // 참고항목 변수

          //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
          if (data.userSelectedType === "R") {
            // 사용자가 도로명 주소를 선택했을 경우
            addr = data.roadAddress;
          } else {
            // 사용자가 지번 주소를 선택했을 경우(J)
            addr = data.jibunAddress;
          }

          // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
          if (data.userSelectedType === "R") {
            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
            if (data.bname !== "" && /[동|로|가]$/g.test(data.bname)) {
              extraAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if (data.buildingName !== "" && data.apartment === "Y") {
              extraAddr += extraAddr !== "" ? ", " + data.buildingName : data.buildingName;
            }
            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
            if (extraAddr !== "") {
              extraAddr = "(" + extraAddr + ")";
            }
            // 조합된 참고항목을 해당 필드에 넣는다.
            document.getElementById("sample6_extraAddress").value = extraAddr;
          } else {
            document.getElementById("sample6_extraAddress").value = "";
          }

          // 우편번호와 주소 정보를 해당 필드에 넣는다.
          document.getElementById("sample6_postcode").value = data.zonecode;
          document.getElementById("sample6_address").value = addr;
          // 커서를 상세주소 필드로 이동한다.
          document.getElementById("sample6_detailAddress").focus();
        },
      }).open();
    }
  </script>
  <script>
	  const fileInputTag = document.querySelector("input[name=profile]");
	
	  fileInputTag.onchange = function () {
	   	const form = document.getElementById("profile-form");
	   	form.submit();
	  };
	</script>
</html>
