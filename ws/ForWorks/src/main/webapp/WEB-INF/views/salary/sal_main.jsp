<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html>
<head>
	<title>Home</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.2.0/css/fontawesome.min.css" integrity="sha384-z4tVnCr80ZcL0iufVdGQSUzNvJsKjEtqYZjiQrrYKlpGow+btDHDfQWkFjoaz/Zr" crossorigin="anonymous">
    <script src="https://kit.fontawesome.com/99800bc262.js" crossorigin="anonymous"></script>
</head>
<style>
    #wrap{
        width: 70vw;
        height: 60vh;
        display: grid;
        grid-template-columns: 100fr;
        grid-template-rows: 25fr 25fr 25fr 25fr;
        justify-content: center;
        align-content: center;
        background-color: white;
        border-radius: 18px;
        box-shadow:  0 3px 6px rgba(0,0,0,0.16), 0 3px 6px rgba(0,0,0,0.23);
       
    }
    #wrap>div{
        box-sizing: border-box;
        text-align: center;
        font-size: 30px;
        display: flex;
        align-items: center;
        background-color: white;
        border-radius: 18px;
        cursor: pointer;
        color : black;
    }
    #wrap>div:hover{
        background-color: #f0f8ff;
        transition: 0.5s;
        color: #25396f;
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
                           <h3>급여관리자</h3>
                           <p class="text-subtitle text-muted"> <br></p>
                       </div>
                       <div class="col-12 col-md-6 order-md-2 order-first">
                           <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
                               <ol class="breadcrumb">
                                   <li class="breadcrumb-item"><a href="index.html"></a></li>
                                   <li class="breadcrumb-item active" aria-current="page"></li>
                               </ol>
                           </nav>
                       </div>
                   </div>
               </div>
               <section class="section">
                   <div id="wrap">

                        <div onclick="location.href='${root}/salary/write'"> <ul> <i class="fa-regular fa-pen-to-square"></i>급여대장 등록</ul></div>
				        
				        <div onclick="location.href='${root}/salary/list'"><ul> <i class="bi bi-list-ol"></i>급여대장 목록</ul></div>
				        
				        <div onclick="location.href='${root}/bonus/list'"><ul><i class="bi bi-award"></i></i>상여관리</ul></div>
				        
				        <div onclick="location.href='${root}/bonus/benefit'"><ul><i class="bi bi-cash-coin"></i>수당관리</ul></div>
				        
				    </div>
               </section>
           </div>
           
       </div>

</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
<script>
	
	$().ready(function() {
		$('#salary-main').addClass("active");
		$('#salary-part').css("display", "block");
	});
	
</script>
</html>
