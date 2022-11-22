<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>양식 수정</title>

<style>

    main{
        background-color: #EEF1FF;
        padding-left: 40px;
        padding-right: 100px;
        padding-top: 45px;
    }

    #main-wrap{
       width: 100%;
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
        align-items: center;
    }

    .approv-detail-div{
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

    .approv-title-wrap{
        display: flex;
        width: 800px;
    }

    .select-form-wrap{
        margin-right: 80px;
    }

    .approv-area{
        margin-bottom: 35px;
        background-color: white;
        border-radius: 20px;
        padding: 20px;
        border: 1px solid #7D6CFF;
    }

    .form-title-label{
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

    

</style>
        <%@ include file="/WEB-INF/views/common/sidebar.jsp" %>
        
        <%@ include file="/WEB-INF/views/common/header.jsp" %>

		<link rel="stylesheet" href="${root}/resources/css/approv/common.css">
        <script src="https://code.jquery.com/jquery-3.4.1.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
        <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

</head>
<body>

    <div id="wrap">


        <main>
            
            <div id="main-wrap">

                <div id="main-header">양식 수정</div>

                <div class="approv-main">
				<form action="" method="post">
					<div class="approv-title-wrap">
					
                        <div class="form-title-label approv-area"><div>제목</div></div>

						<input type="text" class="approv-area title-input" placeholder="양식의 이름을 입력해주세요" name="formName" value="${docForm.formName}">
					
                    </div>

                    <div class="approv-detail-div">
                        <textarea id="summernote" name="formContent"> </textarea>
                    </div>

                    <div class="btn-area">
                        <button type="button" class="approv-btn" onclick="location.href='${root}/approv/form/main/1';">목록보기</button>
                        <div class="approv-btn-area">
                            <button class="approv-btn">
                                <span class="approv-btn-text">수정</span>
                            </button>
                        </div>
                    </div>
                </form>
                </div>
            </div>

        </main>        
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
		
		$('#summernote').summernote('code', '${docForm.formContent}');
	});
	
</script>
</html>