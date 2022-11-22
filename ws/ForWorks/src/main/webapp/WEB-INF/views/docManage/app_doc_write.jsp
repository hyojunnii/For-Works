<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   

<html>
<head>
	<title>Home</title> 
    <script src="${root }/resources/summernote/summernote-lite.js"></script>
    <script src="${root }/resources/summernote/lang/summernote-ko-KR.js"></script>
    <link rel="stylesheet" href="${root}/resources/summernote/summernote-lite.css">
</head>
<style>
 	body{
        background-color: #EEF1FF;
    }
    #wrap{
        background-color: white;
        width: 70vw;
        height: 80vh;
        font-size: 20px;
    }
    
    #title{
        text-align: center;
        font-size: larger;
        font-weight: bolder;
    }
    
</style>
<body>

<div id="app">

	<%@ include file="/WEB-INF/views/common/sidebar.jsp" %>

	<div id="main">
           <%@ include file="/WEB-INF/views/common/header.jsp" %>

           <div class="page-heading">
               <div class="page-title">
                   <div class="row">
                       <div class="col-12 col-md-6 order-md-1 order-last">
                           <h3>결재 문서 등록</h3>
                           <p class="text-subtitle text-muted"></p>
                       </div>
                       <div class="col-12 col-md-6 order-md-2 order-first">
                           <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
                               <ol class="breadcrumb">
                                   <li class="breadcrumb-item"><a href="index.html">Dashboard</a></li>
                                   <li class="breadcrumb-item active" aria-current="page">Layout Default</li>
                               </ol>
                           </nav>
                       </div>
                   </div>
               </div>
               <section class="section">
                <div id="wrap">

                    <%@ include file="/WEB-INF/views/docManage/app_doc_write_content.jsp" %>
                </div>
               </section>
           </div>
           
       </div>

</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
<!--summernote-->
<script>
    $(document).ready(function() {
        //여기 아래 부분
        $('#summernote').summernote({
            height: 300,                 // 에디터 높이
            minHeight: null,             // 최소 높이
            maxHeight: null,             // 최대 높이
            focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
            lang: "ko-KR",					// 한글 설정
            placeholder: '최대 2048자까지 쓸 수 있습니다'	//placeholder 설정
            
        });
    });
</script>

<script>
	
	$().ready(function() {
		$('#doc-write').addClass("active");
		$('#doc-part').css("display", "block");
	});
	
</script>
</html>
