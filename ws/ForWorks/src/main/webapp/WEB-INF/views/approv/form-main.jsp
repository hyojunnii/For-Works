<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>양식</title>

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
        margin-right: 1.5px;
        margin-left: 1.5px;
    }

    .approv-title-wrap{
        display: flex;
        width: 800px;
    }

    .select-form-wrap{
        margin-right: 80px;
    }

    .approv-area{
        margin-bottom: 35px;
        background-color: white;
        border-radius: 20px;
        padding: 20px;
        border: 1px solid #7D6CFF;
    }

    .form-title-label{
        font-weight: 800;
        font-size: 26px;
        color: #6F5CFA;
        margin-right: 15px;
        height: 60px;
        display: flex;
        align-items: center;
    }

    .title-input{
        font-weight: 800;
        font-size: 26px;
        color: black;
        height: 60px;
        width: 86%;
    }

    .form-list{
        display: flex;
        flex-direction: column;
        width: 500px;
        margin-right: 15px;
        height: 600px;
    }

    .approv-list-btn{
        border: none;
        background-color: #7D6CFF;
        width: 100px;
        height: 50px;
        color: white;
        border-radius: 20px;
        font-size: 15px;
        font-weight: 800;
    }

    .form-list-item{
        display: flex;
        align-items: center;
        flex-direction: column;
    }

    .item-no{
        width: 10%;
    }

    .item-title{
        width: 70%;
        text-overflow: ellipsis;
    }

    .approv-main-wrap{
        display: flex;
    }

    .item-text{
        font-size: 30px;
        font-weight: 800;
    }

    .approv-page-btn{
        border: none;
        background-color: #7D6CFF;
        width: 50px;
        height: 50px;
        color: white;
        border-radius: 20px;
        font-size: 15px;
        font-weight: 800;
    }

    .page-area{
        display: flex;
        justify-content: center;
    }

    .item-list{
        width: 100%;
        display: flex;
    }


    .detail-title{
        height: 50px;
        margin-bottom: 10px;
        font-size: 30px;
    }

    .default-text{
        font-weight: 800;
    }

    .detail-approve{
        display: flex;
        justify-content: flex-end;
        width: 100%;
        height: 148px;
        margin-bottom: 15px;
    }

    .approv-table{
        display: grid;
        grid-template-columns: repeat(4, 85px); 
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
        grid-column: 2/5; 
    }

    #creater-sign{
        grid-row: 2/4;
    }

    #coop-member{
        grid-column: 2/5; 
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

    .etc-item{
        font-size: 14px;
        height: 20px;
        padding-top: 27.5px;
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

                <div id="main-header">양식 목록</div>

                <div class="approv-main">

					<div class="approv-main-wrap">
					
                        <div class="approv-area form-list">
                            <div class="form-list-item">
                                <c:forEach items="${formList}" var="x">
								    <div class="item-list">
	                                    <div class="item-no item-text">${x.formNo}</div>
	                                
	                                    
	                                    <div class="item-title item-text"><a href="${root}/approv/form/detail/${x.formNo}">${x.formName}</a></div>
	                                    
	
	                                    <button type="button" class="approv-list-btn approv-btn-margin" onclick="formPreview(${x.formNo});">
	                                        <span class="approv-btn-text">미리보기</span>
	                                    </button>
                                	</div>
								</c:forEach>
                                
                                    

                            </div>
                            <div class="page-area">
                                <c:if test="${pageVo.startPage ne 1}">
                                <button class="approv-page-btn approv-btn-margin" onclick="location.href='${root}/approv/form/main/1'">
                                    <span class="approv-btn-text">&lt;&lt;</span>
                                </button>
                                <button class="approv-page-btn approv-btn-margin" onclick="location.href='${root}/approv/form/main/${pageVo.currentPage-1}'">
                                    <span class="approv-btn-text">&lt;</span>
                                </button>
								</c:if>
								<c:forEach begin="${pageVo.startPage}" end="${pageVo.endPage}" var="i">
								<button class="approv-page-btn approv-btn-margin" onclick="location.href='${root}/approv/form/main/${i}'">
                                    <span class="approv-btn-text">${i}</span>
                                </button>
							    </c:forEach>
							    <c:if test="${pageVo.endPage ne pageVo.maxPage}">
							    <button class="approv-page-btn approv-btn-margin" onclick="location.href='${root}/approv/form/main/${pageVo.currentPage+1}'">
                                    <span class="approv-btn-text">&gt;</span>
                                </button>
                                <button class="approv-page-btn approv-btn-margin" onclick="location.href='${root}/approv/form/main/${pageVo.maxPage}'">
                                    <span class="approv-btn-text">&gt;&gt;</span>
                                </button>
							    </c:if>
                            </div>
                        </div>
					
                        
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
	                            <p>내용</p>
	                        </div>
	                        <div class="detail-etc default-text">
	                            <div class="etc-item">내용</div>
	                            <div class="etc-item">내용</div>
	                        </div>
	                        <div class="detail-part default-text">처부</div>
	                        <div class="detail-position default-text">직위</div>
                        </div>
                            
                    </div>
                        
                    <div class="btn-area">
                        <button type="button" class="approv-btn" onclick="">목록보기</button>
                        <div class="approv-btn-area">
                            <button type="button" class="approv-btn" onclick="location.href='${root}/approv/form/create'">
                                <span class="approv-btn-text">양식 생성</span>
                            </button>
                        </div>
                    </div>
                
                </div>
            </div>

        </main>        
    </div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>

<script>
		
	function formPreview(no){
		$.ajax({
			url : "${root}/approv/form/callContent",
			type : "get",
			data : {formNo : no},
			success : function (val) {
				const content = document.querySelector(".detail-content");
				content.innerHTML = val;
			},
			error : function () {
				alert("불러오기 실패");
			}
		});
	}
</script>



</html>