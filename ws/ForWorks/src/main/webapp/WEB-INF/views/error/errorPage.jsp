<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="root" value="${pageContext.request.contextPath}" />

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>errorPage</title>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${root}/resources/css/common/bootstrap.css">
    <link rel="stylesheet" href="${root}/resources/vendors/bootstrap-icons/bootstrap-icons.css">
    <link rel="stylesheet" href="${root}/resources/css/common/app.css">
    <link rel="stylesheet" href="${root}/resources/css/common/error.css">
</head>

<body>
    <div id="error">

        <div class="error-page container">
            <div class="col-md-8 col-12 offset-md-2">
                <img class="img-error" src="${root}/resources/img/errorImg.png" alt="Not Found">
                <div class="text-center">
                    <h1 class="error-title">System Error</h1>
                    <p class="fs-5 text-gray-600">알수없는 문제가 발생했습니다. 나중에 다시 시도해주세요!</p>
                    <a href="${root}/att/day" class="btn btn-lg btn-outline-primary mt-3">Go Home</a>
                </div>
            </div>
        </div>

    </div>
</body>

</html>