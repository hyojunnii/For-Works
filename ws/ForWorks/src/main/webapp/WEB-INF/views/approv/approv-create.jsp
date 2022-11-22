<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문서 작성</title>

<style>

    main{
        background-color: #EEF1FF;
        padding-left: 40px;
        padding-right: 100px;
        padding-top: 45px;
        display: flex;
    }

    #main-wrap{
       width: 875px;
       font-family: 'Inter', sans-serif;
       display: flex;
       flex-direction: column;
    }

    #main-header{
        font-weight: 800;
        font-size: 30px;
        color: #6F5CFA;
        margin-bottom: 15px;
    }

    .approv-main{
        display: flex;
        flex-direction: column;
        width: 100%;
        
    }

    .approv-create-div{
        width: 800px;
        height: 500px;
        margin-bottom: 35px;
        background-color: white;
        border-radius: 20px;
        padding: 20px;
        border: 1px solid #7D6CFF;
    }

    .btn-area{
        display: flex;
        margin-bottom: 35px;
        justify-content: space-between;
        width: 800px;
    }

    .approv-btn-area{
        display: flex;
    }

    .approv-btn{
        border: none;
        background-color: #7D6CFF;
        width: 180px;
        height: 60px;
        color: white;
        border-radius: 20px;
        font-size: 26px;
        font-weight: 800;
    }

    .approv-btn-margin{
        margin-right: 10px;
    }

    .title-area{
        display: flex;
        width: 800px;
        justify-content: space-between;
    }

    .approv-area{
        margin-bottom: 35px;
        background-color: white;
        border-radius: 20px;
        padding: 20px;
        border: 1px solid #7D6CFF;
    }

    .title-label{
        font-weight: 800;
        font-size: 26px;
        color: #6F5CFA;
        margin-right: 15px;
        height: 60px;
        display: flex;
        align-items: center;
    }

    .title-input{
        font-weight: 800;
        font-size: 26px;
        color: black;
        height: 60px;
        width: 86%;
    }

    .file-area{
        display: flex;
        width: 800px;
        justify-content: space-between;
    }

    .file-label{
        font-weight: 800;
        font-size: 26px;
        color: #6F5CFA;
        margin-right: 15px;
        height: 60px;
        display: flex;
        align-items: center;
    }

    .file-input{
        font-weight: 800;
        font-size: 15px;
        color: black;
        height: 150px;
        width: 79%;
    }

    #add-member{
        display: flex;
        flex-direction: column;
    }

    .member-label{
        font-weight: 800;
        font-size: 23px;
        color: #6F5CFA;
        margin-right: 15px;
        height: 60px;
        display: flex;
        align-items: center;
    }

    .member-input{
        font-weight: 800;
        font-size: 23px;
        color: black;
        height: 60px;
        width: 340px;
        margin-bottom: 4px;
    }

    .member-input-area{
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    .member-btn{
       border: none;
       background-color: transparent;
       width: 60px;
       height: 60px;
       
    }

    .member-btn>svg{
        fill: #7D6CFF;
        width: 60px;
        height: 60px;
        background-color: white;
    }

    .approv-member-area{
        display: flex;
        margin-bottom: 15px;
    }

    .margin-top{
        height: 150px;
    }

    .member-area-horizon{
        display: flex;
        flex-direction: column;
    }

    .div-bar{
        width: 100%;
        height: 1px;
        border: 0.5px solid #B7ADFC;
        margin-top: 10px;
        margin-bottom: 25px;
    }

    .form-btn{
        width: 80px;
        height: 60px;
        color: white;
    }

    

</style>
    
        <%@ include file="/WEB-INF/views/common/sidebar.jsp" %>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"; type="text/javascript"></script>
		<%@ include file="/WEB-INF/views/common/header.jsp" %>
		<link rel="stylesheet" href="${root}/resources/css/approv/common.css">

        <script src="https://code.jquery.com/jquery-3.4.1.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
        <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
    
</head>
<body>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <div id="wrap">



        <form action="" method="post" enctype="multipart/form-data">
        <main>
            
            <div id="main-wrap">

                <div id="main-header">문서 작성</div>

                    <div class="approv-main">

                        <div class="title-area" id="form-area">
                        
                            <input list="formList" class="approv-area title-input" placeholder="양식 선택" name="docForm" id="formNum">
                               	<datalist id="formList">
                               		<c:forEach var="x" items="${formList}">
                               			<option value="${x.formNo}" label="${x.formName}"></option>
                               		</c:forEach>
                           		</datalist>
                            </input>

                            <button type="button" class="approv-btn form-btn" onclick="formCall(1);">선택</button>

                        </div>
                        <div class="title-area">

                            <div class="title-label approv-area"><div>제목</div></div>

                            <input type="text" class="approv-area title-input" name="adocName" placeholder="제목을 입력해주세요">
                        </div>

                        <div class="approv-create-div">
                            <textarea id="summernote" name="adocContent"> </textarea>

                        </div>

                        <div class="file-area">

                            <div class="file-label approv-area"><div>첨부파일</div></div>

                            <input type="file" class="approv-area file-input" name="docFile">
                        </div>


                        <div class="btn-area">
                        	<button type="button" class="approv-btn" onclick="location.href='${root}/approv/create/noelec';" style="font-size: 20px;">비전자문서 작성</button>
                            <button type="button" class="approv-btn" onclick="location.href='${root}/approv/main';">뒤로가기</button>
                            <button class="approv-btn">작성하기</button>
                        </div>
                    
                    </div>
                    
            </div>
            
            <div id="add-member">
                        <div class="margin-top"></div>
                        <div class="approv-member-area">

                            <div class="member-label approv-area"><div>결재자 추가</div></div>

                            <div class="member-input-area">

                                <div class="member-area-horizon" id="approv-member">
                                	<div class="approv-member">
                                    
                                    </div>
                                </div>

                                <button type="button" class="member-btn" id="btn-add-approv" onclick="approvAdd()">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus-square" viewBox="0 0 16 16">
                                        <path d="M14 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h12zM2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/>
                                        <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"/>
                                    </svg>
                                </button>

                            </div>

                        </div>

                        <div class="div-bar"></div>

                        <div class="approv-member-area">

                            <div class="member-label approv-area"><div>협조자 추가</div></div>

                            <div class="member-input-area">

                                <div class="member-area-horizon" id="coop-member">
                                	<div class="coop-member">
                                    
                                    </div>
                                </div>

                                <button type="button" class="member-btn" id="btn-add-coop" onclick="coopAdd()">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus-square" viewBox="0 0 16 16">
                                        <path d="M14 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h12zM2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/>
                                        <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"/>
                                    </svg>
                                </button>

                            </div>

                        </div>

                        <div class="div-bar"></div>

                        <div class="approv-member-area">

                            <div class="member-label approv-area"><div>참조자 추가</div></div>

                            <div class="member-input-area">

                                <div class="member-area-horizon" id="refer-member">
									<div class="refer-member">
                                    
									</div>
                                </div>

                                <button type="button" class="member-btn" id="btn-add-refer" onclick="referAdd()">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus-square" viewBox="0 0 16 16">
                                        <path d="M14 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h12zM2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/>
                                        <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"/>
                                    </svg>
                                </button>

                            </div>

                        </div>
                    </div>
        </main>        
        </form>


    </div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>

<script>
	
	$(document).ready(function() {
		$('#summernote').summernote({
			  height: 420,                 // 에디터 높이
			  minHeight: 420,             // 최소 높이
			  maxHeight: 420,             // 최대 높이
			  focus: false,                  // 에디터 로딩후 포커스를 맞출지 여부
			  lang: "ko-KR",					// 한글 설정
			  placeholder: '최대 2048자까지 쓸 수 있습니다',	//placeholder 설정
			  toolbar: [
		          ['style', ['style']],
		          ['font', ['bold', 'underline', 'clear']],
		          ['color', ['color']],
		          ['para', ['ul', 'ol', 'paragraph']],
		          ['table', ['table']],
		          ['insert', ['link', 'picture', 'video']],
		        ]
	          
		});
	});

</script>

<script>

    function approvAdd() {
		const count = document.getElementsByClassName('approv-member').length
		
		const obj = document.getElementById("approv-member");
		const newDiv = document.createElement("div");
        newDiv.setAttribute("id", "approv-member"+count);
        newDiv.setAttribute("class", "approv-member");
		newDiv.innerHTML = '<input list="memberList" class="approv-area member-input" name="approvMember"><datalist id="memberList"><c:forEach var="x" items="${MemberList}"><option value="${x.empNo}" label="${x.deptName} ${x.posName} ${x.empName}" ></option></c:forEach></datalist>\n<button type="button" class="member-btn" id="btn-min-approv" onclick="divMin(\'approv-member'+count+'\')"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-dash-square" viewBox="0 0 16 16"><path d="M14 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h12zM2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/><path d="M4 8a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7A.5.5 0 0 1 4 8z"/></svg></button>';
		obj.appendChild(newDiv);
	}

    function coopAdd() {
		const count = document.getElementsByClassName('coop-member').length
		
		const obj = document.getElementById("coop-member");
		const newDiv = document.createElement("div");
        newDiv.setAttribute("id", "coop-member"+count);
        newDiv.setAttribute("class", "coop-member");
		newDiv.innerHTML = '<input list="memberList" class="approv-area member-input" name="coopMember"><datalist id="memberList"><c:forEach var="x" items="${MemberList}"><option value="${x.empNo}" label="${x.deptName} ${x.posName} ${x.empName}" ></option></c:forEach></datalist>\n<button type="button" class="member-btn" id="btn-min-coop" onclick="divMin(\'coop-member'+count+'\')"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-dash-square" viewBox="0 0 16 16"><path d="M14 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h12zM2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/><path d="M4 8a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7A.5.5 0 0 1 4 8z"/></svg></button>';
		obj.appendChild(newDiv);
	}
	
	function referAdd() {
		const count = document.getElementsByClassName('refer-member').length
		
		const obj = document.getElementById("refer-member");
		const newDiv = document.createElement("div");
        newDiv.setAttribute("id", "refer-member"+count);
        newDiv.setAttribute("class", "refer-member");
		newDiv.innerHTML = '<input list="memberList" class="approv-area member-input" name="referMember"><datalist id="memberList"><c:forEach var="x" items="${MemberList}"><option value="${x.empNo}" label="${x.deptName} ${x.posName} ${x.empName}" ></option></c:forEach></datalist>\n<button type="button" class="member-btn" id="btn-min-refer" onclick="divMin(\'refer-member'+count+'\')"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-dash-square" viewBox="0 0 16 16"><path d="M14 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h12zM2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/><path d="M4 8a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7A.5.5 0 0 1 4 8z"/></svg></button>';
		obj.appendChild(newDiv);
	}


    
	
</script>

<script>
  
    function divMin(x) {
		const delDiv = document.getElementById(x);

        delDiv.remove();
	}

</script>

<script>
		
	function formCall(){
		
		const no = document.querySelector("#formNum").value;
		
		$.ajax({
			url : "${root}/approv/form/callContent",
			type : "get",
			data : {formNo : no},
			success : function (val) {
				$('#summernote').summernote('code', val);
				$('#summernote').summernote({
					  height: 420,                 // 에디터 높이
					  minHeight: 420,             // 최소 높이
					  maxHeight: 420,             // 최대 높이
					  focus: false,                  // 에디터 로딩후 포커스를 맞출지 여부
					  lang: "ko-KR",					// 한글 설정
					  placeholder: '최대 2048자까지 쓸 수 있습니다',	//placeholder 설정
					  toolbar: [
				          ['style', ['style']],
				          ['font', ['bold', 'underline', 'clear']],
				          ['color', ['color']],
				          ['para', ['ul', 'ol', 'paragraph']],
				          ['table', ['table']],
				          ['insert', ['link', 'picture', 'video']],
				        ]
			          
				});
				
			},
			error : function () {
				alert("불러오기 실패");
			}
		});
		
		
	}
</script>


</html>



