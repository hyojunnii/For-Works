<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="root" value="${pageContext.request.contextPath}" />

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

<link rel="preconnect" href="https://fonts.gstatic.com" />
<link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet" />
<link rel="stylesheet" href="${root}/resources/css/common/bootstrap.css" />

<link rel="stylesheet" href="${root}/resources/vendors/perfect-scrollbar/perfect-scrollbar.css" />
<link rel="stylesheet" href="${root}resources/vendors/bootstrap-icons/bootstrap-icons.css" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css" />
<link rel="stylesheet" href="${root}/resources/css/common/app.css" />
<link rel="stylesheet" href="${root}/resources/css/common.css" />

<style>
  @import url("https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&family=Passion+One:wght@400;700&display=swap");

  body {
    background-color: #f0f0f0;
  }

  .gray {
    color: #4d4d4d;
  }

  .logo h3 {
    font-family: "Passion One", sans-serif;
    color: #7d6cff;
    font-size: 1.65rem;
  }

  .logo h6 {
    padding-left: 8px;
    font-size: 16px;
    padding-top: 7px;
    color: #333333;
  }
  
  .pl-15 {
  	padding-left: 15px;
  }
</style>

<div id="sidebar" class="active">
  <div class="sidebar-wrapper active">
    <div class="sidebar-header pb-0" style="padding-left: 25px">
      <div class="d-flex justify-content-between">
        <div class="logo">
          <a href="${root}/foradmin/main" class="d-flex">
            <h3>FOR-WORKS</h3>
            <h6>Admin</h6>
          </a>
        </div>
        <div class="toggler">
          <a href="#" class="sidebar-hide d-xl-none d-block gray"><i class="bi bi-x bi-middle"></i></a>
        </div>
      </div>
    </div>
    <div class="sidebar-menu">
      <ul class="menu" style="margin-top: 0; padding-left: 20px">
        <li class="sidebar-item has-sub">
          <a href="#" class="sidebar-link">
            <i class="bi bi-person-lines-fill"></i>
            <span>구성원 설정</span>
          </a>
          <ul class="submenu active pl-15">
            <li class="submenu-item">
              <a href="${root}/foradmin/member/1">구성원 조회</a>
            </li>
            <li class="submenu-item">
              <a href="${root}/foradmin/approval">구성원 승인</a>
            </li>
          </ul>
        </li>
        <li class="sidebar-item has-sub">
          <a href="#" class="sidebar-link">
            <i class="bi bi-bookmark-check-fill"></i>
            <span>권한 설정</span>
          </a>
          <ul class="submenu active pl-15">
            <li class="submenu-item">
              <a href="${root}/foradmin/oper/2">관리자 지정</a>
            </li>
          </ul>
        </li>
      </ul>
    </div>
  </div>
</div>
