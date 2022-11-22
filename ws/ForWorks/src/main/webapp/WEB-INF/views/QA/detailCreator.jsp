<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link rel="stylesheet" href="${root}/resources/css/sjy.css">
<html>
<head>
	<title>설문-상세보기(작성자)</title>
</head>
<body style="display: inline;">

<div id="app">

	<%@ include file="/WEB-INF/views/common/sidebar.jsp" %>

	<div id="main">
        <%@ include file="/WEB-INF/views/common/header.jsp" %>
        
            <div class="page-heading">
                <div class="page-title">
                    <div class="row">
                        <div class="col-12 col-md-6 order-md-1 order-last">
                            <h3>투표/설문조사</h3>
                            <p class="text-subtitle text-muted">설문 상세보기</p>
                        </div>
                        <div class="col-12 col-md-6 order-md-2 order-first">
                            <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
                                <ol class="breadcrumb">
                                    <!-- <li class="breadcrumb-item"><a href="index.html">Dashboard</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Layout Default</li> -->
                                </ol>
                            </nav>
                        </div>
                    </div>
                </div>
                <section class="section" >
                    <div class="card" >
                        
                        <%@include file="/WEB-INF/views/QA/detailCreator-content.jsp" %>
                    </div>
                            <div style="text-align: right;"> 
                                <button class="myBtn" id="e">종료</button>
                                <button class="myBtn" id="u">수정</button>
                                <button class="myBtn" id="d">삭제</button>
                                <c:if test="${loginMember.opLevel eq 3}">
                                    <a href="${root}/QA/detailUser/${qavo.qaNo}"><button class="btn btn-primary">설문작성하기</button></a>
                                </c:if>
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


<script>
    const stday= new Date('${qavo.qaSdate}');
    const today  = new Date();
    const edday  = new Date('${qavo.qaEdate}');
    console.log(today);
    console.log(edday);
    console.log(edday<=today);

    var st = '${qavo.qaStatus}';
    console.log("st::"+ st);

    //종료
    var e = document.getElementById('e');
    console.log(e);
    e.addEventListener('click',function () {
        //마감일 현재 날짜 확인
        console.log("ch");
        if(stday >= today){
            alert('시작되지 않은 투표입니다.');
            return;
        }else if(st == 'E'){
            alert('이미 종료된 투표입니다.');
            return;
        }
        location.href = "${root}/QA/end/${qavo.qaNo}";
    });


    //수정
    var u = document.getElementById('u');
    u.addEventListener('click',function () {
        if(stday <= today && edday >= today){
            alert('설문이 진행중 입니다.');
            return;
        }
        else if (edday<=today) {
            alert('마감일이 지났습니다.');
            return;
        }else if(st == 'E'){
            alert('설문이 종료 되었습니다.');
            return;
        }
        location.href = "${root}/QA/update/${qavo.qaNo}";
    });

    //삭제
    var d = document.getElementById('d');
    d.addEventListener('click',function () {
        location.href = "${root}/QA/delete/${qavo.qaNo}";
    });
</script>
</html>
