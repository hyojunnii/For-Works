<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="reset.css"> // reset.css 적용
        <link rel="stylesheet" href="style.css">
        
        <title>TODO-VanilaJS</title>
    </head>
    <style>
        html {
	height: 100%;
}

body {
    display: flex;
    flex-wrap: nowrap;
    justify-content: center;
    background-color: #ECDDFF;
    min-height: 100%;
}

.todo-wrapper {
    justify-content: center;
    margin-top: 3rem;
    min-width: 600px;
}

.todo-title {
    padding: 2rem;
    text-align: center;
    color: #6F5CFA;
    font-size: 5rem;
}

.todo-box {
    background-color: white;
    border: 1px solid #ddd;
}

.todo-input-box {
    display: flex;
    flex-wrap: nowrap;
    flex-direction: row;
    height: 3rem;
    border-bottom: 1px solid #ddd;
    justify-content: flex-start;
    align-items: center;
}

button {
    background-color: transparent;
    border: 0;
}

.complete-all-btn {
    color: gray;
    min-width: none;
    min-height: none;
    width: 1.5rem;
    height: 1.5rem;
    margin: 0.5rem 0.5rem;
    border-radius: 50px;
    cursor: pointer;
    font-size: 1.2rem;
    
}

.complete-all-btn.checked {
    color: green
}

.todo-input {
    width: 80%;
    text-align: center;
    border: 0;
    outline: none;
    font-size: 1.3rem;
}

.todo-item {
    position: relative;
    display: flex;
    flex-wrap: nowrap;
    flex-direction: row;
    justify-content: space-between;
    align-items: center;
    height: 3rem;
    border-bottom: 1px solid #ddd;
}

.todo-item:hover .delBtn {
    opacity: 1;
}

.checkbox {
    min-width: none;
    min-height: none;
    width: 1.5rem;
    height: 1.5rem;
    margin: 0.5rem 0.5rem;
    border-radius: 50px;
    border: 1px solid lightgray;
    cursor: pointer;
    text-align: center;
}

.todo-item.checked .checkbox{
    border: 2px solid darkgray;
    color: green;
}

.todo {
    font-size: 1.3rem;
    padding: 0 1rem;
    width: 80%;
}

.todo-item.checked .todo{
 font-style: italic;
 text-decoration: line-through;
 color: lightgray;
}

.delBtn {
    opacity: 1;
    width: 3rem;
    height: 3rem;
    font-size: 1.5rem;
    font-weight: lighter;
    cursor: pointer;
}

.todo-bottom {
    height: 3rem;
    display: flex;
    flex-wrap: nowrap;
    flex-direction: row;
    justify-content: space-between;
    align-items: center;
    padding: 0 1rem;
}

.button-group{
    flex-direction: row;
    flex-wrap: nowrap;
}

.button-group button {
    border: 1px solid #eee;
    padding: 0.2rem 0.5rem;
    margin: 0 0.5rem;
    border-radius: 8px;
    cursor: pointer;
}

.button-group button.selected {
    border: 2px solid #6F5CFA;
    padding: 0.2rem 0.5rem;
    margin: 0 0.5rem;
    border-radius: 8px;
}

.clear-completed-btn:hover {
    font-style: italic;
    text-decoration: underline;
    cursor: pointer;
}

.edit-input {
    position: absolute;
    left: 0;
    top: 0;
    width: 590px;
    height: 2.8rem;
    margin: 0;
}

p.info {
    margin-top: 1.5rem;
    text-align: center;
    color: #ccc;
}
    </style>
    <body>
        <div id="app">
            <%@ include file="/WEB-INF/views/common/sidebar.jsp" %>
        
            <div id="main">
                <%@ include file="/WEB-INF/views/common/header.jsp" %>
                
                   
                                    <h3>할일</h3>
        <div class="todo-wrapper">
            <div class="todo-title">todos</div>
            <div class="todo-box">
    
                <div class="todo-input-box">
                    <button class="complete-all-btn">✔</button>
                    <input type="text" class="todo-input" placeholder="해야 할 일을 입력해주세요.">
                </div>
                
                <ul class="todo-list">
                   {!-- <li class="todo-item checked">
                        <div class="checkbox">✔</div>
                        <div class="todo">첫번째 할 일</div>
                        <button class="delBtn">x</button>
                    </li>
                    <li class="todo-item">
                        <div class="checkbox"></div>
                        <div class="todo">두번째 할 일</div>
                        <button class="delBtn">x</button>
                    </li>
                    <li class="todo-item">
                        <div class="checkbox"></div>
                        <div class="todo">세번째 할 일</div>
                        <button class="delBtn">x</button>
                    </li> --!}
                </ul>
                <div class="todo-bottom">
                    <div class="left-items">3 items left</div>
                    <div class="button-group">
                        <button class="show-all-btn selected" data-type="all">All</button>
                        <button class="show-active-btn" data-type="active">Active</button>
                        <button class="show-completed-btn" data-type="completed">Completed</button>
                    </div>
                    <button class="clear-completed-btn">Clear Completed</button>
                </div>
            </div>
            <p class='info'>더블클릭 시 수정 가능!</p>
           
        </div>
        <script src="todo.js" ></script>
    </body>
<script>
	
	$().ready(function() {
		console.log("test:");
		$('#ex1').addClass("active");
	});
	
</script>
</html>
