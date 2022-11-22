<%@ page language="java" contentType="text/html;charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>업무 생성</title>
<style>
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
</style>
</head>
<body>
   <div id="wrap">
    <div id="content">
        <h1>업무 등록</h1>
        <form>
            <input type="text" name="title" placeholder="업무명을 입력하세요.">
            <input type="text" name="con" placeholder="내용 입력">
        </form>
        <input type="date" data-placeholder="시작일">
        <input type="date" data-placeholder="시작일">
    </div>
   </div>
</body>
</html>