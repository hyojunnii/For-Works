<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<title>프로젝트 생성</title>

   
</head>
<body>
   <div id="wrap">
    <div id="content">
     <%@ include file="/WEB-INF/views/project/newPrj.jsp" %>
        <h1>프로젝트 목록</h1>
        <form>
            <input type="text" name="title" placeholder="프로젝트명을 입력하세요.">
            <input type="text" name="con" placeholder="내용 입력">
        </form>
        <h2>참여 팀</h2>
        <div class="button">기획팀</div>
        <div class="button">개발팀</div>
        <div class="button">영업팀</div>
        <div class="button">회계팀</div>
        <div class="button">총무팀</div>
        <div class="button">마케팅팀</div>
        <div class="button">서비스팀</div>
        <div class="button">생산팀</div>
        <input type="date" data-placeholder="시작일">
        <input type="date" data-placeholder="종료일">
    </div>
   </div>

</body>
</html>