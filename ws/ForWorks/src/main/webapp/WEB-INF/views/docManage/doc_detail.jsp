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
        width: 70vw;
        height: 70vh;
        font-size: 20px;
        border-radius: 18px;
		box-shadow:  0 3px 6px rgba(0,0,0,0.16), 0 3px 6px rgba(0,0,0,0.23);
		margin-top: 10px;
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
                           <h3>[일반]${vo.title}</h3>
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
                        <table class="type08">
                            <thead>
                            <tr>
                              <th scope="cols" colspan="2">${vo.title}</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <th scope="row">보존기간</th>
                                <td>${vo.contEnrollDate} ~ ${vo.contEndDate}</td>
                            </tr>
                            <tr>
                                <th scope="row">작성자</th>
                                <td>${mem.empName}</td>
                            </tr>
                            <tr>
                                <th scope="row">부서</th>
                                <td>${mem.deptName}</td>
                            </tr>
                            <tr>
                                <th scope="row">첨부파일</th>
                                <td>
                                <c:if test="${fv ne null}">       	
                                    <a download href="${root}/resources/doc-file/upload/${fv.uploadName}">${fv.originName}</a>
                                </c:if>
                                <c:if test="${fv eq null}">       	
                                    *첨부파일없음
                                </c:if>
                                </td>
                            </tr>
                            <tr>
                              <th scope="row">내용</th>
                              <td><div>${vo.content}</div></td>
                            </tr>
                            </tbody>
                          </table>

                                <c:if test="${fv ne null}">       	
                                    <c:if test="${fv.ext eq '.jpg' || fv.ext eq '.png' }">
                                   	<img style="width: 100px; height:100px;"src="${root}/resources/doc-file/upload/${fv.uploadName}"/>
                                    	
                                    </c:if>
                                </c:if>
                            


				            <div id="center">
				                
				            </div>
				            
				            <div id="back-btn"><button class="btn btn-primary btn-sm"  onclick="window.history.back()">목록</button></div>
				                
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
