<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>결재메뉴</title>

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
        margin-bottom: 35px;
    }

    .approv-check-div{
        width: 1460px;
        height: 270px;
        margin-bottom: 35px;
        background-color: white;
        border-radius: 20px;
        padding: 20px;
    }

    .approv-check-title{
        font-weight: 800;
        font-size: 20px;
        color: #6F5CFA;
        display: flex;
        justify-content: space-between;
    }

    .approv-check-title>a{
        font-size: 13px;
        text-decoration: none;
        color: #6F62FA;
    }

    .approv-check-content-wrap{
        display: flex;
        height: 85%;
    }

    .approv-check-content{
        width: 340px;
        height: 100%;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: space-around;
    }
    
    .approv-btn-wrap{
        display: flex;
        align-items: center;
        position: relative;
        width: 40px;
    }
    

    .approv-btn{
       border: none;
       background-color: white;
       width: 40px;
       height: 40px;
       
    }
    
    .approv-btn-left{
    	position: absolute;
    	top: 80px;
    	left: 0;
    }
    
    .approv-btn-right{
    	position: absolute;
    	top: 80px;
    	right: 0;
    }

    .approv-btn>svg{
        fill: #7D6CFF;
        width: 40px;
        height: 40px;
    }

    .content-title{
        font-weight: 800;
        color: #7F7894;
    }

    .content-bot{
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    .content-bot-font{
        font-weight: 800;
        color: #959D9C;
        margin-top: 5px;
        margin-bottom: 5px;
    }

    .div-bar{
        width: 1px;
        height: 100%;
        border: 0.5px solid #B7ADFC;
    }

    .approv-content-wrap{
        display: flex;
        align-items: center;
        overflow : hidden;
        width: 100%;
    }
    
    
    .approv-content-a{
    	height : 100%;
    }
    
    .approv-content-slide{
    	display: flex;
        align-items: center;
        height : 100%;
        transition: 500ms;
    }
    

</style>

</head>
<body>

        <%@ include file="/WEB-INF/views/common/sidebar.jsp" %>
        
		<%@ include file="/WEB-INF/views/common/header.jsp" %>
		<link rel="stylesheet" href="${root}/resources/css/approv/common.css">
		
    <div id="wrap">
        <main>
            
            <div id="main-wrap">
                <div id="main-header">결재문서</div>

                <div class="approv-check-div">
                    <div class="approv-check-title">
                        미결재문서
                    </div>
                    <div class="approv-check-content-wrap">
                        <div class="approv-btn-wrap">
                            <button class="approv-btn approv-btn-left" id="approv-btn-left"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-left-circle-fill" viewBox="0 0 16 16">
                                <path d="M8 0a8 8 0 1 0 0 16A8 8 0 0 0 8 0zm3.5 7.5a.5.5 0 0 1 0 1H5.707l2.147 2.146a.5.5 0 0 1-.708.708l-3-3a.5.5 0 0 1 0-.708l3-3a.5.5 0 1 1 .708.708L5.707 7.5H11.5z"/>
                            </svg></button>
                        </div> 
                        <div class="approv-content-wrap">
                        	<div class="approv-content-slide" id="doc-approv-slide">
                        		<c:forEach var="approv" items="${approvList}">
	                            <a href="${root}/approv/detail/${approv.adocNo}" class="approv-content-a">
		                            <div class="approv-check-content doc-approv">
			                                <div class="content-title">${approv.adocName}</div>
			                                <div class="content-bot">
			                                    <div class="content-date content-bot-font">${approv.draftDate}</div>
			                                    <div class="content-writer content-bot-font">${approv.empName}</div>
			                                </div>
		                            </div>
	                            </a>
	                            <div class="div-bar"></div>
	                            </c:forEach>
	                            <c:if test="${empty approvList}">
	                            	<div>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</div>
	                            	<div class="approv-check-title">
				                        결제할 문서가 없습니다.
				                    </div>
	                            </c:if>
	                            
                            </div>
                        </div>
                        <div class="approv-btn-wrap">
                            <button class="approv-btn approv-btn-right" id="approv-btn-right"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-right-circle-fill" viewBox="0 0 16 16">
                                <path d="M8 0a8 8 0 1 1 0 16A8 8 0 0 1 8 0zM4.5 7.5a.5.5 0 0 0 0 1h5.793l-2.147 2.146a.5.5 0 0 0 .708.708l3-3a.5.5 0 0 0 0-.708l-3-3a.5.5 0 1 0-.708.708L10.293 7.5H4.5z"/>
                              </svg></button>
                        </div> 
                    </div>
                </div>
                
                <div class="approv-check-div">
                    <div class="approv-check-title">
                        반려된 문서
                    </div>
                    <div class="approv-check-content-wrap">
                        <div class="approv-btn-wrap">
                            <button class="approv-btn reject-btn-left"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-left-circle-fill" viewBox="0 0 16 16">
                                <path d="M8 0a8 8 0 1 0 0 16A8 8 0 0 0 8 0zm3.5 7.5a.5.5 0 0 1 0 1H5.707l2.147 2.146a.5.5 0 0 1-.708.708l-3-3a.5.5 0 0 1 0-.708l3-3a.5.5 0 1 1 .708.708L5.707 7.5H11.5z"/>
                            </svg></button>
                        </div> 
                        <div class="approv-content-wrap">
                        	<div class="approv-content-slide" id="doc-reject-slide">
                        		<c:forEach var="reject" items="${rejectApprovList}">
	                            <a href="${root}/approv/reject/${reject.adocNo}" class="approv-content-a">
		                            <div class="approv-check-content doc-reject">
			                                <div class="content-title">${reject.adocName}</div>
			                                <div class="content-bot">
			                                    <div class="content-date content-bot-font">${reject.draftDate}</div>
			                                    <div class="content-writer content-bot-font">${reject.empName}</div>
			                                </div>
		                            </div>
	                            </a>
	                            <div class="div-bar"></div>
	                            </c:forEach>
	                            <c:if test="${empty rejectApprovList}">
	                            	<div>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</div>
	                            	<div class="approv-check-title">
				                        반려된 문서가 없습니다.
				                    </div>
	                            </c:if>
	                            
                            </div>
                        </div>
                        <div class="approv-btn-wrap">
                            <button class="approv-btn approv-btn-right" id="reject-btn-right"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-right-circle-fill" viewBox="0 0 16 16">
                                <path d="M8 0a8 8 0 1 1 0 16A8 8 0 0 1 8 0zM4.5 7.5a.5.5 0 0 0 0 1h5.793l-2.147 2.146a.5.5 0 0 0 .708.708l3-3a.5.5 0 0 0 0-.708l-3-3a.5.5 0 1 0-.708.708L10.293 7.5H4.5z"/>
                              </svg></button>
                        </div> 
                    </div>
                </div>

                <div class="approv-check-div">
                    <div class="approv-check-title">
                        미확인 협조 문서
                    </div>
                    <div class="approv-check-content-wrap">
                        <div class="approv-btn-wrap">
                            <button class="approv-btn approv-btn-left" id="coop-btn-left"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-left-circle-fill" viewBox="0 0 16 16">
                                <path d="M8 0a8 8 0 1 0 0 16A8 8 0 0 0 8 0zm3.5 7.5a.5.5 0 0 1 0 1H5.707l2.147 2.146a.5.5 0 0 1-.708.708l-3-3a.5.5 0 0 1 0-.708l3-3a.5.5 0 1 1 .708.708L5.707 7.5H11.5z"/>
                            </svg></button>
                        </div> 
                        <div class="approv-content-wrap">
                        	<div class="approv-content-slide" id="doc-coop-slide">
                        		<c:forEach var="coop" items="${coopList}">
	                            <a href="${root}/approv/coop/${coop.adocNo}" class="approv-content-a">
		                            <div class="approv-check-content doc-coop">
			                                <div class="content-title">${coop.adocName}</div>
			                                <div class="content-bot">
			                                    <div class="content-date content-bot-font">${coop.draftDate}</div>
			                                    <div class="content-writer content-bot-font">${coop.empName}</div>
			                                </div>
		                            </div>
	                            </a>
	                            <div class="div-bar"></div>
	                            </c:forEach>
	                            <c:if test="${empty coopList}">
	                            	<div>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</div>
	                            	<div class="approv-check-title">
				                        협조 문서가 없습니다.
				                    </div>
	                            </c:if>
	                            
                            </div>
                        </div>
                        <div class="approv-btn-wrap">
                            <button class="approv-btn approv-btn-right" id="coop-btn-right"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-right-circle-fill" viewBox="0 0 16 16">
                                <path d="M8 0a8 8 0 1 1 0 16A8 8 0 0 1 8 0zM4.5 7.5a.5.5 0 0 0 0 1h5.793l-2.147 2.146a.5.5 0 0 0 .708.708l3-3a.5.5 0 0 0 0-.708l-3-3a.5.5 0 1 0-.708.708L10.293 7.5H4.5z"/>
                              </svg></button>
                        </div> 
                    </div>
                </div>

                <div class="approv-check-div">
                    <div class="approv-check-title">
                        미확인 참조 문서
                    </div>
                    <div class="approv-check-content-wrap">
                        <div class="approv-btn-wrap">
                            <button class="approv-btn approv-btn-left" id="refer-btn-left"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-left-circle-fill" viewBox="0 0 16 16">
                                <path d="M8 0a8 8 0 1 0 0 16A8 8 0 0 0 8 0zm3.5 7.5a.5.5 0 0 1 0 1H5.707l2.147 2.146a.5.5 0 0 1-.708.708l-3-3a.5.5 0 0 1 0-.708l3-3a.5.5 0 1 1 .708.708L5.707 7.5H11.5z"/>
                            </svg></button>
                        </div> 
                        <div class="approv-content-wrap">
                        	<div class="approv-content-slide" id="doc-refer-slide">
                        		<c:forEach var="refer" items="${referList}">
	                            <a href="${root}/approv/refer/${refer.adocNo}" class="approv-content-a">
		                            <div class="approv-check-content doc-refer">
			                                <div class="content-title">${refer.adocName}</div>
			                                <div class="content-bot">
			                                    <div class="content-date content-bot-font">${refer.draftDate}</div>
			                                    <div class="content-writer content-bot-font">${refer.empName}</div>
			                                </div>
		                            </div>
	                            </a>
	                            <div class="div-bar"></div>
	                            </c:forEach>
	                            <c:if test="${empty referList}">
	                            	<div>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</div>
	                            	<div class="approv-check-title">
				                        참조 문서가 없습니다.
				                    </div>
	                            </c:if>
	                            
	                            
                            </div>
                        </div>
                        <div class="approv-btn-wrap">
                            <button class="approv-btn approv-btn-right" id="refer-btn-right"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-right-circle-fill" viewBox="0 0 16 16">
                                <path d="M8 0a8 8 0 1 1 0 16A8 8 0 0 1 8 0zM4.5 7.5a.5.5 0 0 0 0 1h5.793l-2.147 2.146a.5.5 0 0 0 .708.708l3-3a.5.5 0 0 0 0-.708l-3-3a.5.5 0 1 0-.708.708L10.293 7.5H4.5z"/>
                              </svg></button>
                        </div> 
                    </div>
                </div>

            </div>

        </main>        
    </div>


  <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>

<script>
	const approvSlide = document.querySelector('#doc-approv-slide');//#doc-approv-slide
	const approvLeftBtn = document.querySelector('#approv-btn-left');//#approv-btn-left
	const approvRightBtn = document.querySelector('#approv-btn-right');//#approv-btn-right
	let sApprovLength = document.querySelectorAll('.doc-approv').length
	console.log(sApprovLength);
	const slideApprovLength = parseInt(sApprovLength/4+1);//.doc-approv
	console.log(slideApprovLength);
	
	let approvCurrentPage = 1;
	
	function approvSlideShow() {
		approvSlide.style.transform = 'translateX(-'+((approvCurrentPage - 1) * 1368)+'px)';
	}
	
	approvLeftBtn.onclick = function(){
        approvCurrentPage--;
	  if(approvCurrentPage < 1){
	    approvCurrentPage = slideApprovLength;
	  }
	  approvSlideShow();
	}
	approvRightBtn.onclick = function(){
        approvCurrentPage++;
	  if(approvCurrentPage > slideApprovLength){
	    approvCurrentPage = 1;
	  }
	  approvSlideShow();
	}
	
</script>

<script>
	const rejectSlide = document.querySelector('#doc-reject-slide');//#doc-reject-slide
	const rejectLeftBtn = document.querySelector('#reject-btn-left');//#reject-btn-left
	const rejectRightBtn = document.querySelector('#reject-btn-right');//#reject-btn-right
	let srejectLength = document.querySelectorAll('.doc-reject').length
	console.log(srejectLength);
	const sliderejectLength = parseInt(srejectLength/4+1);//.doc-reject
	console.log(sliderejectLength);
	
	let rejectCurrentPage = 1;
	
	function rejectSlideShow() {
		rejectSlide.style.transform = 'translateX(-'+((rejectCurrentPage - 1) * 1368)+'px)';
	}
	
	rejectLeftBtn.onclick = function(){
        rejectCurrentPage--;
	  if(rejectCurrentPage < 1){
	    rejectCurrentPage = sliderejectLength;
	  }
	  rejectSlideShow();
	}
	rejectRightBtn.onclick = function(){
        rejectCurrentPage++;
	  if(rejectCurrentPage > sliderejectLength){
	    rejectCurrentPage = 1;
	  }
	  rejectSlideShow();
	}
	
</script>

<script>
	const coopSlide = document.querySelector('#doc-coop-slide');//#doc-coop-slide
	const coopLeftBtn = document.querySelector('#coop-btn-left');//#coop-btn-left
	const coopRightBtn = document.querySelector('#coop-btn-right');//#coop-btn-right
	let scoopLength = document.querySelectorAll('.doc-coop').length
	console.log(scoopLength);
	const slidecoopLength = parseInt(scoopLength/4+1);//.doc-coop
	console.log(slidecoopLength);
	
	let coopCurrentPage = 1;
	
	function coopSlideShow() {
		coopSlide.style.transform = 'translateX(-'+((coopCurrentPage - 1) * 1368)+'px)';
	}
	
	coopLeftBtn.onclick = function(){
        coopCurrentPage--;
	  if(coopCurrentPage < 1){
	    coopCurrentPage = slidecoopLength;
	  }
	  coopSlideShow();
	}
	coopRightBtn.onclick = function(){
        coopCurrentPage++;
	  if(coopCurrentPage > slidecoopLength){
	    coopCurrentPage = 1;
	  }
	  coopSlideShow();
	}
	
</script>

<script>
	const referSlide = document.querySelector('#doc-refer-slide');//#doc-refer-slide
	const referLeftBtn = document.querySelector('#refer-btn-left');//#refer-btn-left
	const referRightBtn = document.querySelector('#refer-btn-right');//#refer-btn-right
	let sreferLength = document.querySelectorAll('.doc-refer').length
	console.log(sreferLength);
	const slidereferLength = parseInt(sreferLength/4+1);//.doc-refer
	console.log(slidereferLength);
	
	let referCurrentPage = 1;
	
	function referSlideShow() {
		referSlide.style.transform = 'translateX(-'+((referCurrentPage - 1) * 1368)+'px)';
	}
	
	referLeftBtn.onclick = function(){
        referCurrentPage--;
	  if(referCurrentPage < 1){
	    referCurrentPage = slidereferLength;
	  }
	  referSlideShow();
	}
	referRightBtn.onclick = function(){
        referCurrentPage++;
	  if(referCurrentPage > slidereferLength){
	    referCurrentPage = 1;
	  }
	  referSlideShow();
	}
	
</script>

<script>
var myModal = document.getElementById('myModal')
var myInput = document.getElementById('myInput')

myModal.addEventListener('shown.bs.modal', function () {
  myInput.focus()
})
</script>

</html>