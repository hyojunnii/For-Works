<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link rel="stylesheet" href="${root}/resources/css/sjy.css">
<html>
<head>
	<title>투표-상세정보(작성자)</title>
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
                            <p class="text-subtitle text-muted">투표 상세보기</p>
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
                        
                        <%@include file="/WEB-INF/views/vote/detailCreator-content.jsp" %>
                    </div>
                    
                            <div style="text-align: right;"> 
                                <button type="button" class="myBtn" id="e">종료</button>
                                <button type="button" class="myBtn" id="u">수정</button>
                                <button type="button" class="myBtn" id="d">삭제</button>
                                <c:if test="${loginMember.opLevel eq 3}">
                                    <a href="${root}/vote/detailUser/${vtvo.vtNo}"><button class="btn btn-primary">투표참여하기</button></a>
                                </c:if>
                            </div>
                        
                </section>
            </div>
        
</div>

</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>

<script>
    var x;
    var y;
    console.log("aaaaaa");
    for (let i = 0; i < ${fn:length(vtcgList) }; i++) {
        x = ${vtcgList[i].vtcgName};
        console.log(x);
        y = ${vtcgList[i].vtcgCnt};
        console.log(y);
    }
</script>

<script>
	
	$().ready(function() {
		console.log("test:");
		$('#ex1').addClass("active");
	});
	
</script>

<script>
    

    const stday= new Date('${vtvo.vtCreate}');
    const today  = new Date();
    const edday  = new Date('${vtvo.vtEnd}');
    console.log(today);
    console.log(edday);
    console.log(edday<=today);

    var st = '${vtvo.vtStatus}';
    console.log("st::"+ st);

    var e = document.getElementById('e');
    e.addEventListener('click',function () {
        //마감일 현재 날짜 확인
        if(stday >= today){
            alert('시작되지 않은 투표입니다.');
            return;
        }else if(st == 'E'){
            alert('이미 종료된 투표입니다.');
            return;
        }
        location.href = "${root}/vote/end/"+${vtvo.vtNo};
    });

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
            alert('투표가 종료 되었습니다.');
            return;
        }
        location.href = "${root}/vote/update/"+${vtvo.vtNo};
    });

    var d = document.getElementById('d');
    d.addEventListener('click',function () {
        location.href = "${root}/vote/delete/"+${vtvo.vtNo};
    });

</script>

</html>
