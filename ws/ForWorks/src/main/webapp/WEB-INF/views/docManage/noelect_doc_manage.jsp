<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<title>Home</title>
</head>
<style>
 	#wrap{
        width: 60vw;
        height: 60vh;
    }
    #center{
        width: 60vw;
        height: 60vh;
        display: grid;
        grid-template-columns: 1fr 5fr 3fr 3fr 2fr;
        grid-template-rows: repeat(11,50px);
        text-align: center;
        background-color: white;
        border-radius: 18px;
        box-shadow:  0 3px 6px rgba(0,0,0,0.16), 0 3px 6px rgba(0,0,0,0.23);
    }
    .div-top{
        font-size: larger;
        color: black;
        font-weight: bolder;
        border-bottom: 1px solid #7D6CFF;
        padding-top: 10px;
    }
    #page-area{
        width: 30%;
        margin: 0 auto;
        display: flex;
        justify-content: space-around;
    }
    #search-area{
        margin: 0 auto;
        display: flex;
        justify-content: space-around;
    }
    #check-cate{
        display: inline-block;
        height: 30px;
        font-size: large;
        color: black;
        font-weight: bolder;
    }
    #check-btn{
        position: relative;
        float: right;
        height: 30px;
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
                           <h3>서면결재문서 등록 관리</h3>
                           <p class="text-subtitle text-muted">서면결재문서를 관리할 수 있습니다. </p>
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
				        <div id="check-cate">
                            <a href="${root}/docmanage/manage/1">일반문서 |</a>
                            <a href="${root}/appmanage/manage/1">결재문서</a>
				        </div>
				        <div id="check-btn">
				            <button class="btn btn-primary btn-sm" onclick="location.href='${root}/appmanage/nowrite'">+ 서면결재문서등록</button>
				        </div>
				        <div id="center">
				            <div class="div-top">글번호</div>
                            <div class="div-top">제목</div>
                            <div class="div-top">등록일</div>
				            <div class="div-top">보존마감일</div>
                            <div class="div-top">게시상태</div>
				        
                        <c:forEach items="${voList}" var="x">
                            <div>${x.adocNo}</div>
                            <div><a href="${root}/appmanage/noelctCont/${x.adocNo}">${x.adocName}</a></div>
                            <div>${x.contEnrollDate}</div>
                            <div>${x.contEndDate}</div>
                            <div>${x.contStatus}</div>
                        </c:forEach>
				      
				        
				        </div>
				        
				        <div id="page-area">
				            <c:if test="${pv.startPage ne 1 }">
								<a href="${root}/appmanage/noelectman/${pv.startPage - 1}" class="btn btn-primary btn-sm">이전</a>	
							</c:if>
							
							<c:forEach begin="${pv.startPage}" end="${pv.endPage}" var="i">
								<a href="${root}/appmanage/noelectman/${i}" class="btn btn-primary btn-sm">${i}</a>
							</c:forEach>
							
							<c:if test="${pv.endPage ne pv.maxPage}">
								<a href="${root}/appmanage/manage/${pv.endPage + 1}" class="btn btn-primary btn-sm">다음</a>	
							</c:if>
				        </div>
				
				        
					</div>
               </section>
           </div>
           
       </div>

</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
<script>
	
	$().ready(function() {
		$('#doc-manage').addClass("active");
		$('#doc-part').css("display", "block");
	});
	
</script>
</html>
