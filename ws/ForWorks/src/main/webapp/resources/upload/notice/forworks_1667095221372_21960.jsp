<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="root" value="${pageContext.request.contextPath}"/>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<!-- 제이쿼리 -->    
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

<!-- 부트스트랩 -->    
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<style>
        /* 공통 */
        html, body{
        padding: 0px;
        margin: 0px;
    }

    div, aside, main, header, input{
        box-sizing: border-box;
    }

    aside{
        width: 30vw;
        height: 100vh;
        border: 1px solid black;
        
    }

    main{
        width: 80vw;
        height: 100vh;
        border: 1px solid black;
        display: block;
    }
    
    header{
        width: 100%;
        height: 10%;
        
        border: 1px solid black;

        
    }
    article{
    	
		width: 100%;        	
    	height: 90%;
    	border: 1px solid black;
    }

    #wrap{
        display: flex;

    }
</style>
<body>
        <div id="wrap">
    
            <aside>
                <%-- <%@include file="/WEB-INF/views/common/sidemenu-content.jsp" %> --%>
                    side
            </aside>
    
            <main>            
                <header>
                    공지사항 아이콘
                </header>
                <%-- <%@include file="/WEB-INF/views/home-content.jsp" %> --%>
                <article>
                    main
                </article>
            </main>
    
        </div>
    
</body>
</html>