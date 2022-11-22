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
        height: auto;
        font-size: 20px;
		border-radius: 18px;
		box-shadow:  0 3px 6px rgba(0,0,0,0.16), 0 3px 6px rgba(0,0,0,0.23);
		padding-bottom: 10px;
    }
    table{
		margin-top: 1px;
		margin-bottom: 5px;
        width: 100%;
		height: 250px;
        border-bottom: 2px dashed #EEF1FF;
        text-align: left;
    }
	input , select{
		border:3px solid  #dae1ff;	
		border-radius: 10px;
	}
    #title{
        text-align: center;
        font-size: larger;
        font-weight: bolder;
    }
    .back-color{
        /*background-color: #EEF1FF;*/
		display: none;
	
    }
	.back-color2{
        /*background-color: #EEF1FF;*/
		display: none;
	
    }
	.btn-css{
		background-color:  #dae1ff;
		border: 0.5px solid D9E5FF;
	}
	.tright{
		text-align: right;
		width: 20%;
		padding-right: 20px;
		color: black;
	}
	.stable{
		border-bottom: 1px solid  #dae1ff;
	}
	#input-zone{
		float: right;
		margin-top: 30px;
		margin-bottom: 10px;
	}
	#month{
		border: none;
	}
	#zone{
		height: auto;
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
                           <h3>급여대장 등록</h3>
                           <p class="text-subtitle text-muted">The default layout </p>
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
				        <div id="title"><br> 급여대장 등록</div>
						<form action="" method="post">
							<div id="input-zone"><input id="month" type="month" name="salMonth" required><input type="submit" value="등록" class="btn-css"></div>
							<div id="center">

									<table>
										<tr>
											<th class="tright">부서명</th>
											<td>
												<select name="dept" id="dept" required >
													<option value="">부서선택</option>
													<c:forEach items="${departList}" var="d">
														<option value="${d}">${d}</option>
													</c:forEach>
												</select>
											</td>
										</tr>
										<tr>
											<th class="tright">사원명</th>
											<td>
												<select name="empNo" id="emp" required>
													<option value="" disabled selected>직원선택</option>
												</select>
											</td>
										</tr>
										<tr>
											<th class="tright">정산기간</th>
											<td><input name="startMonth" id="start-month" required> ~ <input name="endMonth" id="end-month" required></td>
										</tr>
										<tr>
											<th class="tright">지급날짜</th>
											<td><input type="date" name="payDate" required></td>
										</tr>
										<tr>
											<th class="tright">급여구분</th>
											<td>
												<select name="salCate" id="cate" required>
													<option value="">선택</option>
													<option value="1">월급</option>
													<option value="2">상여</option>
													<option value="3">월급+상여</option>
												</select>
											</td>
										</tr>
										
									</table>
									<div id="zone">
										<div class="back-color">
											<div id="s-zone">기본급/수당내역</div>
											<table id="s-table">
												
											</table>
										</div>
										<div class="back-color2">
											<div id="bonus-zone">상여내역</div>
											<table id="b-table">
												
											</table>
										</div>
									</div>	
								</div>
								
									
							</form>
							</div>
               </section>
           </div>
           
       </div>

</div>

<!--부서별 직원조회-->
<script>
	$("select[name=dept]").change(function(){
        var depart = $(this).val();
        $('select#emp option').remove();
		$("select#emp").append("<option value='option'>직원선택</option>");
        $.ajax({
			url : "/ForWorks/salary/selectEmp",
			type : "POST",
			data : {depart : depart},
			success : function(result){
		
				for(var i = 0 ; i <result.length ; i++){
                        $('#emp').append(
                            '<option value='+result[i].empNo+'>'+result[i].empName+'</option>'
                        )
                }
            },
            error:function(){
				toastContent.innerText = "다시 시도해주세요";
            }

        })
    })
</script>
<!--급여구분 선택 시 div-->
<script>

	let isCate01Empty = true;
	let isCate02Empty  = true;
	$("#cate").change(function(){
		var cate = $(this).val();
		var szone = document.querySelector(".back-color");
		var bzone = document.querySelector(".back-color2");

		var x = document.getElementById("emp");
		var empNo = x.options[x.selectedIndex].value; 

		var startMonth = document.getElementById("start-month").value;
		var endMonth = document.getElementById("end-month").value;
		
		var a = 0;
		if(cate == 1 ){
			bzone.style.display = 'none';
			szone.style.display = 'block';
			a();
			function a(){
				if(isCate01Empty){
					$.ajax({
						url : "/ForWorks/salary/empSal",
						type : "POST",
						data :{ 
							empNo : empNo,
							startMonth : startMonth,
							endMonth : endMonth
						},
						success : function(data){
							var total = 0;
							$('#s-table').empty;
							
							$('#s-table').append('<tr><th class="stable">기본급</th><td class="stable">'+data[0].empMoney+'</td></tr>')
								total += parseInt(data[0].empMoney);
								$('#s-table').append('<tr><th class="stable">수당명</th><th class="stable">수당금</th>')
									for(var i = 0; i < data.length;i++){
										if(data[i].amount == 0 && data[i].cate == " "){
											data[i].cate = "해당없음";
										}
										$('#s-table').append('<tr><td class="stable">'+data[i].cate+'</td><td class="stable">'+data[i].amount+'</td></tr>');
										total += parseInt(data[i].amount);
									}
								$('#s-table').append('<tr><td>초과수당</td><td>'+data[0].addOverTime+"(분)"+data[0].addCalc+"(원)"+'</td></tr>')
								total += parseInt(data[0].addCalc);
							
							
						},
						error : function(){
							toastContent.innerText = "다시 시도해주세요";
						}
					});
					isCate01Empty = false;
				};
			}
			
			
		}



		if(cate == 2){
			szone.style.display = 'none';
			bzone.style.display = 'block';
			b();
			function b(){
				if(isCate02Empty){		
					$.ajax({
						url : "/ForWorks/salary/empBonus",
						type : "POST",
						data :{ 
							empNo : empNo,
							startMonth : startMonth,
							endMonth : endMonth 
						},
						success : function(data){
							var total2 = 0;
							$('#total').remove();
							for(var i = 0; i < data.length;i++){
								$('#b-table').append('<tr><td>'+data[i].title+'</td><td>'+data[i].payment+'</td></tr>');
								total2 += parseInt(data[i].payment);
			
							}
							
						},
						error : function(){
							toastContent.innerText = "다시 시도해주세요";
						}
					});
					isCate02Empty = false;
				}
			}
		}

		if(cate == 3){
			szone.style.display = 'block';
			bzone.style.display = 'block';
			a();
			b();
			
			
		}



	})
</script>
<!--연도 selectbox-->
<script>
    $(document).ready(function(){
        var now = new Date();
        var com_year = now.getFullYear();
        $("#year").append("<option value=''>연도</option>");
        for(var i = (com_year); i >= 2000 ; i--){
            $("#year").append("<option value='"+i+"'>"+i+"년"+"</option>");
        }
		for(var j = 1; j <=12; j++){
			$("#month").append("<option value='"+j+"'>"+j+"월"+"</option>");
		}
    })
</script>
<!--시작일, 종료일-->
<script>
	$(function(){
		$('#start-month , #end-month').datepicker({
			dateFormat : "yy-mm-dd",
			maxDate : 0,
			monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
			monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
			dayNames: ['일', '월', '화', '수', '목', '금', '토'],
			dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
			dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
			showMonthAfterYear: true,
			yearSuffix: '년'
		}
		);
	})
</script>

<!--제이쿼리 ui css-->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!--제이쿼리 style css
<link rel="stylesheet" href="/resources/demos/style.css">-->
<!--제이쿼리 js-->
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<!--제이쿼리 ui js-->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
<script>
	
	$().ready(function() {
		console.log("test:");
		$('#ex1').addClass("active");
	});
	
</script>
</html>
