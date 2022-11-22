<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<html>
<head>
	<title>TODO리스트</title>
	<link href="stylesheet" href="https://unicons.iconscout.com/release/v4.0./css/line.css">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<style>
main *{
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body{
	/*전체*/
	overflow: hidden;
	background: #eef1ff;
	
}

.wrapper{
	margin: 135px auto;
	max-width: 405px;
	background: #fff;
	border-radius: 7px;
	padding: 28px 0;
}

.task-input{
	height: 52px;
	padding: 0 25px;
	position: relative;
}

.task-input img{
	position: absolute;
	top: 50%;
	transform: translate(17px, -50%);
}

.task-input input{
	height: 100%;
	width: 100%;
	outline: none;
	font-size: 18px;
	border-radius: 5px;
	border: 1px solid #999;
	padding: 0 20px 0 53px;
}

.task-input input::placeholder{
	color: #bfbfbf;
}

.controls, li{
	display: flex;
	align-items: center;
	justify-content: space-between;
}

.controls{
	display: flex;
	align-items: center;
	justify-content: space-between;
	padding: 18px 25px;
	border-bottom: 1px solid #ccc;
}

.filters span{
	cursor: pointer;
	margin: 0 8px;
	font-size: 17px;
}

.filters span:first-child{
	margin-left: 0;
}

.filters span.active{
	color:#6F5CFA;
}	

.controls .clear-btn{
	outline: none;
	border: none;
	color: #fff;
	cursor: pointer;
	font-size: 13px;
	border-radius: 4px;
	padding: 7px 13px;
	background: #6F5CFA;
}

.task-box{
	margin: 20px 25px;
}

.task-box .task{
	list-style: none;
	font-size: 17px;
	margin-bottom: 18px;
	padding-bottom: 16px;
	border-bottom: 1px solid #ccc;
}

.task-box .task:last-child{
	margin-bottom: 0;
	border-bottom: 0;
	padding-bottom: 0;

}

.task label{
	display: flex;
}

.task label p.checked{
	text-decoration: line-through;
}

.task label input{
	margin-top: 6px;
	margin-right: 12px;
}

.task .settings{
	cursor: pointer;
	position: relative;
}

.settings .task-menu{
	position: absolute;
	padding: 5px 0;
	right: -5px;
	bottom: -65px;
	z-index: 2;
	transform: scale(0);
	border-radius: 4px;
	background: #fff;
	transform-origin: top right;
	transition: trnasform 0.2s ease;
	box-shadow: 0 0 6px rgba(0,0,0,0.15);
}

.settings .task-menu.show{
	transform: scale(1);
}

.task-menu li{
	height: 25px;
	font-size: 16px;
	padding: 17px 15px;
	margin-bottom: 2px;
	justify-content: flex-start;
}

.task-menu li:last-child{
	margin-bottom: 0;
}

.task-menu li:hover{
	background: #f5f5f5;
}

.task-menu li i{
	padding-right: 8px;
}

</style>

<body>
<form action="/ForWorks/todo/newTodo">
<div id="app">
	<%@ include file="/WEB-INF/views/common/sidebar.jsp" %>

	<div id="main">
        <%@ include file="/WEB-INF/views/common/header.jsp" %>
        
           
                            <h3>TODO 리스트</h3>
                             <div id="todo"></div>
                           		<div class="wrapper">
                           			<div class="task-input">
										<input type="text" placeholder="새로운 일정을 추가하세요">                            			
                           			</div>
                           			<div class="controls">
                           			<div class="filters">
                           			<span id="all">ALL</span>
                           			<span id="pending">PENDING</span>
                           			<span id="completed">COMPLETED</span>
                           			</div>
                           			<button class="clear-btn">CLEAR ALL</button>
                           			</div>
                           			<ul class="task-box"></ul>
                           		</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %> 

<script>

const taskInput = document.querySelector(".task-input input"),
filters = document.querySelectorAll(".filters span"),
ClearAll = document.querySelector(".clear-btn"),
taskBox = document.querySelector(".task-box");

let editId;
let isEditedTask = false; 

let todos = JSON.parse(localStorage.getItem("todo-list"));

filters.forEach(btn => {
	btn.addEventListener("click", () => {
		console.log("filters " , filters)
		document.querySelector("span.active").classList.remove("");
		btn.classList.add("active");
		showTodo(btn.id);
	});
});

function showTodo(filter) {
	let li="";
	if(todos){
		todos.forEach((todo, id) => {
			let isCompleted = todo.status == "completed" ? "checked" : "";
			if(filter == todo.status || filter == "all") {
				li += 	'<li class="task">'
				+	'<label for="${id}">'
					+	'<input type="updateStatus(this)" type="checkbox" id="${id}" ${isCompleted}>'
						+'<p class="${isCompleted}">${todo.name}</p>'
					+'</label>'
					+'<div class="settings">'
						+'<i onclick="showMenu(this)" class="uil uil-ellipsis-h"></i>'
						+'<ul class="task-menu">'
							+'<li onclick="editTask(${id}, ${todo.name})"><i class="uil uil-pen"></i>수정하기</li>'
							+'<li onclick="deleteTask(${id})"><i class="uil uil-trash"></i>삭제하기</li>'
						+'</ul>'
				+'</div>'
					+'</li>';
			}
		
		});
	}
	
	taskBox.innerHTML = li || '<span>해야할 업무가 없습니다.</span>';
}
showTodo("all");

function showMenu(selectedTask) {
	let taskMenu = selectedTask.parentElement.lastElementChild;
	taskMenu.classList.add("show");
	document.addEventListener("click", e=> {
		if(e.target.tagName != "I" || e.target != selectedTask) {
			taskMenu.classList.add("show");
		}
	});
}
function editTask(taskId, taskName) {
	editId = taskId;
	taskInput.value = taskName;
}

function deleteTask(deleteId) {
	todos.splice(deleteId,1);
	localStorage.setItem("todo-list", JSON.stringify(todos));
	showTodo("all");
}

ClearAll.addEventListener("click", () => {
	todos.splice(0, todos.length);
	localStorage.setItem("todo-list", JSON.stringify(todos));
	showTodo("all");
})

function updateStatus(selectedTask){
	let taskName = selectedTask.parentElement.lastElementChild;
	if(selectedTask.checked){
		taskName.classList.add("checked");
		todos[selectedTask.id].status = "COMPLETED";
	} else {
		taskName.classList.remove("checked");
		todos[selectedTask.id].status = "PENDING";
	}
	localStorage.setItem("todo-list", JSON.stringify(todos));
}

taskInput.addEventListener("keyup", e=> {
	let userTask = taskInput.value.trim();
	if(e.key =="Enter" && userTask) {
		if(!isEditedTask) {
			if(!todos) {
				todos=[];
			}	
				let taskInfo = {name: userTask, status: "pending"};
				todos.push(taskInfo);	
		} else{
			todos[editId].name = userTask;
		}
		taskInput.value = ""; 
		localStorage.setItem("todo-list", JSON.stringify(todos));
		showTodo("all");		
	}	
});
</script>
</body>
</html>
