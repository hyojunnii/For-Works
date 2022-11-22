<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<title>프로젝트 생성</title>
<style>
    /*날짜 css*/
    input[type="date"] { position: relative; padding-right:20px; 
        background: url(img/calendar.svg) no-repeat right 5px center / 10px auto;
        border:1px solid #6F5CFA;

    }
    input[type="date"] ::-webkit-clear-button,
    input[type="date"] ::-webkit-inner-spin-button { display: none;}
    input[type="date"] ::-webkit-calendar-picker-indicator {

        position:absolute;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        background: transparent;
        color: transparent;
        cursor: pointer;
    }

    input[type="date"]::before {
        content: attr(data-placeholder);
        width: 100%;
    }
    input[type="date"]:valid::before {
        display: none;
    }
    input[type="date"]::before {
        color:gray
        font: size 14px;
        padding: left 16px;

    }
    /*버튼 css 클릭 시 색상 변경*/
    button{
        width: 202px;
        height: 58px;
        background-color: #FFFFFF;
        color: #000000;
        border-radius: 25px;

    }
    .active{
        color: #FFFFFF;
        background-color: #6F5CFA;
    }
</style>
</head>
<body>
   <div id="wrap">
    <div id="content">
        <h1>프로젝트 등록</h1>
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
    /*클릭이벤트*/
   <script>
    function button_click() {
        event_target_classList.toggle("active");
    }
   </script>
</body>
</html>