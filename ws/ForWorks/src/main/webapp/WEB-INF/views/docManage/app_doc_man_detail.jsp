<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html>
<head>
	<title>Home</title>
</head>
<style>
 	body{
        background-color: #EEF1FF;
    }
    #wrap{
        background-color: white;
        width: 60vw;
        height: auto;
        font-size: 20px;
    }
    
    .center-top{
        font-size: small;
    }
    #center{
        display: grid;
        grid-template-columns: 4fr 8fr;
        grid-template-rows: 40px 40px 40px 50px 70px;
    }
    .center-top{
        display: block;
        box-sizing: border-box;
       
    }
    #back-btn{
        text-align: center;
        margin-top: 50px;
    }
    table.type08 {
    border-collapse: collapse;
    text-align: left;
    line-height: 1.5;
    border-left: 1px solid #ccc;
    margin: 10px 0px;
    width: 100%;
    }

    table.type08 thead th {
    padding: 10px;
    font-weight: bold;
    border-top: 1px solid #ccc;
    border-right: 1px solid #ccc;
    border-bottom: 2px solid #c00;
    background: #dcdcd1;
    text-align: center;
    }
    table.type08 tbody th {
    width: 150px;
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
    border-right: 1px solid #ccc;
    border-bottom: 1px solid #ccc;
    background: #ececec;
    }
    table.type08 td {
    width: 350px;
    padding: 10px;
    vertical-align: top;
    border-right: 1px solid #ccc;
    border-bottom: 1px solid #ccc;
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
                           <h3>결재문서관리등록</h3>
                           <p class="text-subtitle text-muted"> </p>
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
                    <form action="" method="post">
                        <label><input type="checkbox" name="contStatus" id="Y" value="Y"  <c:if test="${cont[0].contStatus eq 'Y'}">checked</c:if>>게시중</label>
                                <label><input type="checkbox" name="contStatus" id="N" value="N" <c:if test="${cont[0].contStatus eq 'N'}">checked</c:if>>비공개</label>
                        <table class="type08">
                            <thead>
                            <tr>
                              <th scope="cols" colspan="2">${adoc[0].adocName}</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <th scope="row">보존기간</th>
                                <td>${cont[0].contEnrollDate} ~ ${cont[0].contEndDate}</td>
                            </tr>
                            <tr>
                                <th scope="row">기안날짜</th>
                                <td>${adoc[0].draftDate}</td>
                            </tr>
                            <tr>
                                <th scope="row">기안자</th>
                                <td>${adoc[0].empName}</td>
                            </tr>
                            <tr>
                                <th scope="row">결재인</th>
                                <td>${adoc[0].approveMember}</td>
                            </tr>
                            <tr>
                                <th scope="row">첨부파일</th>
                                <td>
                                    <c:forEach items="adoc" var="x">
                               		    <a download href="${root}/resources/upload/doc/${adoc[0].changeFileName}">${adoc[0].fileName}</a>
                            	    </c:forEach>
                                    <c:if test="${x[0] eq null}">       	
                                        *첨부파일없음
                                    </c:if>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">결재문서보기</th>
                                <td><a href="${root}/appmanage/formtest/${adoc[0].adocNo}">결재확인</a></td>
                            </tr>
                           
                              <th scope="row">내용</th>
                              <td><div>${adoc[0].adocContent}</div></td>
                            </tr>
                            </tbody>
                          </table>
                    
             
                    
                    <button  class="btn btn-primary btn-sm" onclick="window.history.back()">목록</button><input type="submit" class="btn btn-primary btn-sm" style="float: right;" value="게시상태수정">
                </form>
                        
            </div>
               </section>
           </div>
           
       </div>

</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>


<script>
	
	$().ready(function() {
		console.log("test:");
		$('#ex1').addClass("active");
	});
	
</script>
</html>
