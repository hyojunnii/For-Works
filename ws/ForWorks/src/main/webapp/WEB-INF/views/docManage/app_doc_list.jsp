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
        grid-template-columns: 1fr 4fr 4fr 4fr 4fr;
        grid-template-rows: repeat(11,5fr);
        text-align: center;
        background-color: white;
        border-radius: 18px;
        box-shadow:  0 3px 6px rgba(0,0,0,0.16), 0 3px 6px rgba(0,0,0,0.23);
    }
    .div-top{
        font-size: larger;
        color: black;
        font-weight: bolder;
        margin-top: 6px;
        border-bottom: 1px solid #7D6CFF;
        margin-bottom: 5px;
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
                           <h3>결재문서</h3>
                           <p class="text-subtitle text-muted"><br> </p>
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
                            <a href="${root}/docmanage/list/1">일반문서 |</a>
                            <a href="${root}/appmanage/noelect/1">서면결재문서</a>
				        </div>
				        <div id="check-btn">
				            <button class="btn btn-primary btn-sm" onclick="location.href='${root}/appmanage/write'">+ 결재문서작성</button>
				        </div>
				        <div id="center">
                
                        <div class="div-top">NO</div>
				        <div class="div-top">제목</div>
				        <div class="div-top">공개범위</div>
				        <div class="div-top">보존등록일</div>
                        <div class="div-top">보존마감일</div>
				        
                        <c:forEach items="${voList}" var="x">
                            <div>${x.adocNo}</div>
                            <div class="title"><a href="${root}/appmanage/adocDetail/${x.adocNo}">${x.adocName}</a></div>
                            <div>
                                <c:choose>
                                    <c:when test="${x.range eq 'OPEN,1경영지원부,2인사부,3총무부,4기획부,5재무부,6사업부,7영업부,8IT부,'}">전체공개</c:when>
                                    <c:otherwise>해당부서</c:otherwise>
                            	</c:choose>
                            </div>
                            <div>${x.contEnrollDate}</div>
                            <div>${x.contEndDate}</div>
                        </c:forEach>
				      
				        
				        </div>
				        
				        <div id="page-area">
				            <c:if test="${pv.startPage ne 1 }">
								<a href="${root}/appmanage/list/${pv.startPage - 1}" class="btn btn-primary btn-sm">이전</a>	
							</c:if>
							
							<c:forEach begin="${pv.startPage}" end="${pv.endPage}" var="i">
								<a href="${root}/appmanage/list/${i}" class="btn btn-primary btn-sm">${i}</a>
							</c:forEach>
							
							<c:if test="${pv.endPage ne pv.maxPage }">
								<a href="${root}/appmanage/list/${pv.endPage + 1}" class="btn btn-primary btn-sm">다음</a>	
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
		$('#doc-write').addClass("active");
		$('#doc-part').css("display", "block");
	});
	
</script>
</html>
