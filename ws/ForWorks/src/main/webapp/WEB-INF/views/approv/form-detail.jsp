<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>양식 상세</title>

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
        height: 1000px;
        margin-bottom: 35px;
        background-color: white;
        border-radius: 20px;
        padding: 20px;
        border: 1px solid #7D6CFF;
        display: flex;
        flex-direction: column;
        align-items: center;
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

    .default-text{
        font-weight: 800;
    }

    .detail-title{
        height: 50px;
        margin-bottom: 10px;
        font-size: 30px;
    }

    .detail-approve{
        display: flex;
        justify-content: flex-end;
        width: 100%;
        height: 148px;
        margin-bottom: 15px;
    }

    .detail-content{
        height: 533px;
    }

    .detail-etc{
        height: 138px;
        font-size: 14px;
        display: grid;
        border-top: 1px solid black;
        grid-template-columns: repeat(2, 1fr);
        grid-template-rows: repeat(2, 0.5fr);
        width: 100%;
    }

    .detail-part, .detail-position{
        height: 69px;
        font-size: 27px;
    }

    .etc-item{
        font-size: 14px;
        height: 20px;
        padding-top: 27.5px;
    }

    .table-area{
        height: 125px;
        
    }

    .approv-table td{
        width: 85px;
        border: 1px solid black;
        text-align: center;
        font-size: 14px;
    }

    .sign-area{
        height: 76px;
    }

    .default-text{
        font-weight: 800;
    }

    .detail-title{
        height: 50px;
        margin-bottom: 10px;
        font-size: 30px;
    }

    .detail-approve{
        display: flex;
        justify-content: flex-end;
        width: 100%;
        height: 148px;
        margin-bottom: 15px;
    }

    .detail-content{
        height: 533px;
        width: 100%;
    }

    .detail-etc{
        height: 138px;
        font-size: 14px;
        display: grid;
        border-top: 1px solid black;
        grid-template-columns: repeat(2, 1fr);
        grid-template-rows: repeat(2, 0.5fr);
        width: 100%;
    }

    .detail-part, .detail-position{
        height: 69px;
        font-size: 27px;
    }

    .etc-item{
        font-size: 14px;
        height: 20px;
        padding-top: 27.5px;
    }

    .table-area{
        height: 125px;
        
    }

    .approv-table{
        display: grid;
        grid-template-columns: repeat(4, 85px); /*jstl로 유동적으로 늘림*/
        grid-template-rows: 24px 24px 76px 24px;
        
    }

    .approv-table div{
        border: 1px solid black;
        text-align: center;
        font-size: 14px;
    }

    .sign-area{
        height: 76px;
    }

    #approv-member{
        grid-column: 2/5; /*jstl로 유동적으로 늘림*/
    }

    #creater-sign{
        grid-row: 2/4;
    }

    #coop-member{
        grid-column: 2/5; /*jstl로 유동적으로 늘림*/
    }

</style>

        <%@ include file="/WEB-INF/views/common/sidebar.jsp" %>
        
		<%@ include file="/WEB-INF/views/common/header.jsp" %>
		<link rel="stylesheet" href="${root}/resources/css/approv/common.css">
</head>
<body>

    <div id="wrap">


        <main>
            
            <div id="main-wrap">

                <div id="main-header">양식상세</div>

                <div class="approv-main">

                    <div class="approv-detail-div">
                        <div class="detail-title default-text">제목</div>
                        <div class="detail-approve default-text">
                            <div class="approv-table">

                                    <div>기안자</div>
                                    <div id="approv-member">결재자</div>

                                    <div id="creater-sign"></div>
                                    <div>직위</div>
                                    <div>직위</div>
                                    <div>직위</div>

                                    <div class="sign-area"></div>
                                    <div class="sign-area"></div>
                                    <div class="sign-area"></div>

                                    <div>협조자</div>
                                    <div id="coop-member"></div>

                            </div>
                        </div>
                        <div class="detail-content">
                            ${docForm.formContent }
                        </div>
                        <div class="detail-etc default-text">
                            <div class="etc-item">내용</div>
                            <div class="etc-item">내용</div>
                        </div>
                        <div class="detail-part default-text">처부</div>
                        <div class="detail-position default-text">직위</div>
                    </div>

                    <div class="btn-area">
                        <button type="button" class="approv-btn" onclick="location.href='${root}/approv/form/main/1'">목록보기</button>
                        <div class="approv-btn-area">
                            <button type="button" class="approv-btn approv-btn-margin" onclick="location.href='${root}/approv/form/edit/${docForm.formNo}'">
                                <span class="approv-btn-text">수정</span>
                            </button>
                            <form action="${root}/approv/form/delete/${docForm.formNo}" method="post">
                            <button class="approv-btn">
                                <span class="approv-btn-text">삭제</span>
                            </button>
                            </form>
                        </div>
                    </div>
                
                </div>
            </div>

        </main>        
    </div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>