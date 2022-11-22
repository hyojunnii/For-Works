<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>서명 수정</title>

<style>

    main{
        background-color: #EEF1FF;
        padding-left: 40px;
        padding-right: 100px;
        padding-top: 45px;
        display: flex;
        height: 100vh;
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
        align-items: center;
        
    }

    .file-area{
        display: flex;
        width: 800px;
        justify-content: space-between;
    }

    .file-label{
        font-weight: 800;
        font-size: 20px;
        color: #6F5CFA;
        margin-right: 15px;
        height: 60px;
        display: flex;
        align-items: center;
    }

    .approv-area{
        margin-bottom: 35px;
        background-color: white;
        border-radius: 20px;
        padding: 20px;
        border: 1px solid #7D6CFF;
    }

    .file-input{
        font-weight: 800;
        font-size: 15px;
        color: black;
        height: 150px;
        width: 79%;
    }

    .btn-area{
        display: flex;
        margin-bottom: 35px;
        justify-content: space-between;
        width: 800px;
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

    .sample-img{
        margin-bottom: 35px;
        border-radius: 20px;
        padding: 20px;
        border: 1px solid #7D6CFF;
        background-image: none; /* ajax로 선택한 파일 받기*/
        width: 100px;
        height: 100px;
        background-color: white;
    }

</style>
    

        <%@ include file="/WEB-INF/views/common/sidebar.jsp" %>
        
		<%@ include file="/WEB-INF/views/common/header.jsp" %>
		<link rel="stylesheet" href="${root}/resources/css/approv/common.css">

        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
        <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
    
</head>
<body>
<form action="" method="post"  enctype="multipart/form-data">
    <div id="wrap">



        <main>
            
            <div id="main-wrap">

                <div id="main-header">서명 수정</div>

                <div class="approv-main">

                    <div class="file-area">

                        <div class="file-label approv-area"><div>저장할 서명</div></div>

                        <input type="file" class="approv-area file-input" name="signFile">
                    </div>

                    <img class="sample-img" src="${root}/resources/upload/sign/${docSignVo.signEdit}"></img>


                    <div class="btn-area">
                        <button type="button" class="approv-btn" onclick="location.href='${root}/approv/main'">뒤로가기</button>
                        <button class="approv-btn">저장하기</button>
                    </div>
                
                </div>
            </div>


            

        </main>        

    </div>
</form>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>

	<script>
    	
	    const signFile = document.querySelector('input[name="signFile"]');
	    signFile.onchange = function () {
	        const imgTag = document.querySelector('.sample-img');
	        if(signFile.files.length>0){
	            const fr = new FileReader();
	
	            fr.readAsDataURL(signFile.files[0]);
	
	            fr.onload = function(data){
	                imgTag.src = data.target.result;
	            }
	        }else{
	            imgTag.src = "";
	        }
	    }
	
    </script>

</html>
