<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>ForWorks</title>
    <script src="https://kit.fontawesome.com/3a92c85ff9.js" crossorigin="anonymous"></script>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
      crossorigin="anonymous"
    />
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
      crossorigin="anonymous"
    ></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
	    <link rel="stylesheet" href="${root}/resources/css/member/join-style.css" />
  </head>
  <body>
  	<%@ include file="/WEB-INF/views/common/toastify.jsp" %>
  
    <div class="container">
      <div class="signup">
        <form action="" class="signup-form" method="post" onsubmit="return check();">
          <h1 class="title"><a href="/ForWorks/login">FOR-WORKS</a></h1>
          <h3 class="sub-title">회원가입</h3>
          <div class="input-field id-field">
            <label>* 아이디</label>
            <input name="empId" type="text" placeholder="아이디를 입력해주세요" required />
            <button type="button" id="id-dup-check" class="input-btn" onclick="checkDup();">중복확인</button>
          	<input type="hidden" value="o" id="isDup" />
          </div>
          <div class="input-field">
            <label>* 비밀번호</label>
            <input name="empPwd" type="password" placeholder="비밀번호를 입력해주세요" required />
          </div>
          <div class="input-field">
            <label>* 비밀번호 확인</label>
            <input name="empPwd2" type="password" placeholder="비밀번호를 한 번 더 입력해주세요" required />
          </div>
          <div class="input-field">
            <label>* 성명</label>
            <input name="empName" type="text" placeholder="성함을 입력해주세요" maxlength="6" required />
          </div>
          <div class="input-field usernum-field">
            <label>* 주민번호</label>
            <input name="empRegno1" type="text" size="6" placeholder="주민번호 앞자리" maxlength="6" required />
            <span>-</span>
            <input name="empRegno2" type="password" size="7" placeholder="주민번호 뒷자리" maxlength="7" required />
          </div>
          <div class="input-field">
            <label>* 휴대전화</label>
            <input name="empPhone" type="text" placeholder="'-' 를 제외한 휴대전화 번호를 입력해주세요" required maxlength="11" />
          </div>
          <div class="input-field">
            <label>* 이메일</label>
            <input name="empEmail" type="text" placeholder="'@' 을 포함한 이메일 주소 전체를 입력해주세요" required />
          </div>
          <div class="input-field address-field">
            <label>* 주소</label>
            <div>
              <input name="empPcode" type="text" id="sample6_postcode" placeholder="우편번호" required />
              <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" /><br />
              <input name="empAddr1" type="text" id="sample6_address" placeholder="주소" required /><br />
              <input name="empAddr2" type="text" id="sample6_detailAddress" placeholder="상세주소" required /><br />
              <input name="empAddr3" type="text" id="sample6_extraAddress" placeholder="참고항목" />
            </div>
          </div>
          <div class="input-field">
            <label>내선번호</label>
            <input name="empExphone" type="text" placeholder="(선택) 내선번호 또는 사내연락처를 입력해주세요" />
          </div>

          <input type="submit" value="가입 신청" class="btn solid" />
        </form>
      </div>
    </div>

    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
    	//다음 주소api
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
		//유효성 체크
		const isDup = document.querySelector("#isDup");
		const pwd = document.querySelector("input[name=empPwd]");
		const pwd2 = document.querySelector("input[name=empPwd2]");
		const regno1 = document.querySelector("input[name=empRegno1]");
		const regno2 = document.querySelector("input[name=empRegno2]");
		const email = document.querySelector("input[name=empEmail]");
		
		function check() {
		 if(isDup.value == 'o') {
			 toastContent.innerText = "아이디 중복확인을 진행해주세요.";
			 return false;
		 }
		 
		 if(pwd.value.length == 0 || pwd.value != pwd2.value) {
			 toastContent.innerText = "비밀번호가 일치하지 않습니다.";
			 return false;
		 }
		 
		 if(regno1.value.length != 6 && regno2.value.length != 7) {
			 toastContent.innerText = "주민번호를 확인해주세요.";
		 	 return false;
		 }
		 
		  if(email.value.indexOf('@') == -1) {
			 toastContent.innerText = "이메일 주소를 확인해주세요.";
			 return false;
		 }
		};
	</script>
	
	<script>
		//아이디 중복체크
		function checkDup() {
		  const isDup = document.querySelector("#isDup");
		  const userId = document.querySelector("input[name=empId]").value;
		  
		  if(userId != "") {
		   $.ajax({
		     url: "${root}/idCheck",
		     type: "POST",
		     data: {empId : userId},
		     success: function (data) {
		       if (data == 0) {
		         isDup.value = "x";
		         toastContent.innerText = "사용 가능한 아이디입니다.";
		       } else {
		         isDup.value = "o";
		         toastContent.innerText = "사용 불가한 아이디입니다.";
		       }
		     },
		     error: function () {
		    	 toastContent.innerText = "중복검사에 실패하였습니다. 관리자에게 문의하세요.";
		     },
		   });
		  } else {
			toastContent.innerText = "아이디를 입력해주세요.";
		  }
		}
	</script>
  </body>
</html>
