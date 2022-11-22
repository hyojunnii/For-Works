<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="root" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>ForWorks</title>
    <script src="https://kit.fontawesome.com/3a92c85ff9.js" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
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

    <link rel="preconnect" href="https://fonts.gstatic.com" />
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="${root}/resources/css/common/bootstrap.css" />

    <link rel="stylesheet" href="${root}/resources/vendors/perfect-scrollbar/perfect-scrollbar.css" />
    <!-- <link rel="stylesheet" href="resources/vendors/bootstrap-icons/bootstrap-icons.css"> -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css" />
    <link rel="stylesheet" href="${root}/resources/css/common/app.css" />
    <link rel="stylesheet" href="${root}/resources/css/common.css" />

    <link rel="stylesheet" href="${root}/resources/css/member/login-style.css" />
    <style>
      body {
        background-color: #fff;
      }

      .title,
      .sub-title {
        color: rgb(124, 124, 124);
      }

      .input-field {
        background-color: rgb(229, 229, 229);
      }

      .input-field i {
        color: rgb(99, 99, 99);
      }

      .input-field input {
        color: rgb(99, 99, 99);
      }

      .login-btn {
      	margin-top: 20px;
        background-color: rgb(134, 134, 134);
      }

      .login-btn:hover {
        background-color: #686868;
      }
    </style>
  </head>
  <body>
  
  <%@ include file="/WEB-INF/views/common/toastify.jsp" %>
  	
    <div class="container">
      <div class="form-container">
        <div class="signin">
          <form action="${root}/foradmin/login" class="signin-form" method="post">
            <h1 class="title">FOR-WORKS</h1>
            <h5 class="sub-title">관리자 로그인</h5>
            <div class="input-field">
              <i class="fas fa-user"></i>
              <input name="manId" type="text" placeholder="아이디" required />
            </div>
            <div class="input-field">
              <i class="fa-solid fa-shield-halved"></i>
              <input name="manPwd" type="password" placeholder="비밀번호" required />
            </div>
            <input type="submit" value="로그인" class="login-btn solid" />
          </form>
        </div>
      </div>
      <div class="panel-container">
        <div class="panel">
          <img src="${root}/resources/img/member-imgs/undraw_design_objectives_re_94pd.svg" class="image" alt="" />
        </div>
      </div>
    </div>
  </body>
</html>
