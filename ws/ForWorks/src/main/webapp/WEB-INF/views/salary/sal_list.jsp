<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html>
<head>
	<title>Home</title>
</head>
<style>
   #wrap{
        width: 70vw;
        height: 60vh;
        border-radius: 18px;
        box-shadow:  0 3px 6px rgba(0,0,0,0.16), 0 3px 6px rgba(0,0,0,0.23);
    }
    #center{
        width: 70vw;
        height: 60vh;
        display: grid;
        grid-template-columns: 2fr 4fr 4fr 4fr 4fr 6fr 2fr;
        grid-template-rows: repeat(11,30px);
        text-align: center;
        background-color: white;
        overflow-y: scroll;
    }
    .div-top{
        font-size: larger;
        color: black;
        font-weight: bolder;
        border-bottom: 1px solid #7D6CFF;
    }
    #page-area{
        width: 30%;
        margin: 0 auto;
        display: flex;
        justify-content: space-around;
    }
    #search-area{
        width: 70vw;
        margin: 0 auto;
        display: flex;
        justify-content: space-around;
        margin-top: 10px;
    }
    #check-date{
        display: inline-block;
        background-color:white;
        height: 30px;
        font-size: large;
        color: #7D6CFF;
        font-weight: bolder;
    }
    #check-btn{
        position: relative;
        float: right;
        height: 30px;
    }
    .bbutton{
        cursor: pointer;
        height: 100%;
        font-size: 20px;
        background-color:  #dae1ff;
		border: 0.5px solid #D9E5FF;
        font-weight: bolder;
    }
    .app{
        vertical-align: bottom;
    }
    #search-zone{
        width: 70vw;
        margin-bottom: 5px;
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
                           <h3>급여대장목록</h3>
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
                   <div id="search-zone">
                       <input type="month" name="salMonth" id="salMonth">
                       <select name="dept" id="dept" >
                           <option value="">부서선택</option>
                           <c:forEach items="${departList}" var="d">
                               <option value="${d}">${d}</option>
                            </c:forEach>
                        </select>
                        <button onclick="search()" class="btn btn-primary btn-sm">조회</button>
                        <div id="check-btn">
                            <button onclick="status()" class="bbutton" ><i class="bi bi-check2-square"></i>명세서공개</button>
                        </div>
                    </div>
                    <div id="wrap">
				        <div id="center">
				            <div class="div-top">□</div>
                            <div class="div-top">부서명</div>
                            <div class="div-top">사원명</div>
				            <div class="div-top">급여구분</div>
                            <div class="div-top">지급일</div>
                            <div class="div-top">공개여부</div>
                            <div class="div-top">보기</div>
				        </div>
				        
	 
					</div>

               </section>
           </div>
           
       </div>

</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
<script>
    function search(){
        var salMonth = document.getElementById("salMonth").value;
       
        var dept = document.getElementById("dept").value;
      

        $.ajax({
            url : "/ForWorks/salary/list",
            type: "POST",
            data : {
                salMonth : salMonth,
                dept : dept
            },
            success:function(data){
                $(".app").remove();
                for(var i = 0 ; i < data.length ; i++){
                    if(data[i].salCate == 1){
                        data[i].salCate = "월급";
                    }else if(data[i].salCate == 2){
                        data[i].salCate = "상여";
                    }else{
                        data[i].salCate = "월급+상여";
                    }
                    
                    $("#center").append(
                        '<div class="app"><input type="checkbox" name="status" value="'+data[i].no+'"></div><div class="app">'+dept+'</div><div class="app">'+data[i].empName+'</div><div class="app">'+data[i].salCate+'</div><div class="app">'+data[i].payDate+'</div><div class="app">'+data[i].status+'</div><div class="app"><button  onclick="detail('+data[i].no+')">보기</button></div>'
                    );
                }
                
            },
            error:function(){
                toastContent.innerText = "다시 시도해주세요";
            }
        })

    }
</script>

<script>
    function status(){
        var x = document.getElementsByName("status");
        var checked = 0;
        var status = [];
        for(i = 0 ; i < x.length ; i++){
            checked ++;
            if(x[i].checked == true){
                status.push(x[i].value);
                console.log(status[i]);
            }
        }


        $.ajax({
            url : "/ForWorks/salary/status",
            type: "POST",
            data : {status : status},
            success : function(data){
                if(data == 1){
                    toastContent.innerText = "변경 완료되었습니다.";
                }else{
                    toastContent.innerText = "변경 완료되었습니다.";
                }
            },
            error : function(){
                toastContent.innerText = "변경 완료되었습니다.";
            }
        })

    }
</script>
<script>
    function detail(no){
        window.open("${root}/salary/payslipDetail/"+no, "_blank", "width=500, height=500")
    }
    
</script>
<script>
	
	$().ready(function() {
		console.log("test:");
		$('#ex1').addClass("active");
	});
	
</script>
</html>
