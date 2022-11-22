<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<html>
<head>
	<title>Home</title>
</head>
<style>
    #wrap{
        background-color: white;
        width: 70vw;
        height: 70vh;
        font-size: 20px;
        border-radius: 18px;
		box-shadow:  0 3px 6px rgba(0,0,0,0.16), 0 3px 6px rgba(0,0,0,0.23);
		margin-top: 10px;
    }
    table{
        width: 100%;
        text-align: center;
    }
    #title{
        text-align: center;
        font-size: larger;  
        font-weight: bolder;
    }
    .back-color{
        background-color: #EEF1FF;
    }
    select{
        border:3px solid  lightgray;	
		border-radius: 10px;
        font-size: 30px;
        width: 120px;
        height: 40px;
    }
    #top{
        border-bottom: 2px double gray;
        height: 20px;
        font-size: 20px;
    }
    #test>tbody{
        font-size: 18px;
    }
    .bo{
        border-radius: 15px;
        background-color: #EEF1FF;
        border-color:#dae1ff;
        width: 80px;
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
                           <h3>급여명세서</h3>
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
				<select name="year" id="year" title="년도" ></select> 
                <div id="wrap">
                    <table id="test">
                        <thead><tr id="top"><th>지급월</th><th>지급종류</th><th>지급일</th><th>상세보기</th></tr></thead>
                        <tbody>
                            
                        </tbody>
                    </table>
                    
		    	</div>
	
               </section>
           </div>
           
       </div>

</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>

<!--SELECTBOX 연도 설정-->
<script>
    $(document).ready(function(){
        var now = new Date();
        var year = "";
        var com_year = now.getFullYear();
        console.log("com_year" + com_year);
        $("#year").append("<option value=''>연도</option>");
        for(var i = (com_year); i >= 2000 ; i--){
            $("#year").append("<option value='"+i+"'>"+i+"년"+"</option>");
        }
    })

</script>
<!--연도에 따른 급여명세서 조회-->
<script>
    $("select[name=year]").change(function(){
        var year = $(this).val();
        $.ajax({
            url : "/ForWorks/salary/slipList",
            type : "POST",
            data : {
                year : year
            },
            success : function(data){
                $('#test>tbody').empty();
                
                for(var i = 0 ; i <data.length ; i++){
                    if(data[i].salCate == 1){
                        data[i].salCate = "월급";
                    }else if(data[i].salCate == 2){
                        data[i].salCate = "상여";
                    }else{
                        data[i].salCate = "월급+상여";
                    }
                    $('#test>tbody').append('<tr><td>'+data[i].salMonth+'</td><td>'+data[i].salCate+'</td><td>'+data[i].payDate+'</td><td><button class="bo" onclick="detail('+data[i].no+')">보기</button></td></tr>')
                };
               
            }
            ,error : function(){
                toastContent.innerText = "다시 시도해주세요";
            }
            
        })
    })
</script>

<script>
    function detail(no){
        window.open("${root}/salary/payslipDetail/"+no, "_blank", "width=650, height=750")
    }
    
</script>

<script>
	
	$().ready(function() {
		$('#salary-pay').addClass("active");
		$('#salary-part').css("display", "block");
	});
	
</script>
</html>
