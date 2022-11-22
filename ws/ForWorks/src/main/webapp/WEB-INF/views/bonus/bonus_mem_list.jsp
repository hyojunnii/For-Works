<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html>
<head>
	<title>Home</title>
</head>
<style>
 	#wrap{
        width: 60vw;
        height: 60vh;
        font-size: 20px;
    }
    #center{
        width: 60vw;
        height: 60vh;
  
        display: grid;
        grid-template-columns: 4fr 4fr 4fr 4fr;
        grid-template-rows: repeat(11,35px);
        text-align: center;
        background-color: white;
        border-radius: 18px;
        box-shadow:  0 3px 6px rgba(0,0,0,0.16), 0 3px 6px rgba(0,0,0,0.23);
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
        margin: 0 auto;
        display: flex;
        justify-content: space-around;
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
  
    /*모달 css*/
    .modal{
        position:absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        display: none;
        background-color: rgba(0,0,0,0.4);
    }

    .modal .show{
        display: block;
    }

    .modal_body{
        position: absolute;
        top: 50%;
        left: 50%;
        width: 500px;
        height: 600px;
        padding: 40px;
        text-align: left;
        background-color: rgb(255,255,255);
        border-radius: 10px;
        box-shadow: 0 2px 3px 0 rgba(34,36,38,0.15);

        transform: translateX(-50%) translateY(-50%);
    }
    table.type01 {
    border-collapse: collapse;
    text-align: left;
    line-height: 1.5;
    margin : 20px 10px;
    color: #25396f;
    }
    table.type01 th {
    width: 150px;
    padding: 10px;
    font-weight: bold;
    vertical-align: top;
    border: 1px solid #ccc;
    }
    table.type01 td {
    width: 400px;
    padding: 10px;
    vertical-align: top;
    border: 1px solid #ccc;
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
                           <h3>상여금 해당 사원 목록</h3>
                           <p class="text-subtitle text-muted"> </p>
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
			    

			        <div id="check-btn">
			            <button class="btn btn-primary btn-sm btn-open-popup">사원 추가</button>
			        </div>
			        <div id="center">
			        <div class="div-top">부서명</div>
			        <div class="div-top">사원명</div>
			        <div class="div-top">지급률</div>
			        <div class="div-top">지급액</div>
			        
                    <c:forEach items="${memList}" var = "m">
                        <div>${m.deptName}</div>
                        <div>${m.empName}</div>
                        <div>${m.rate}%</div>
                        <div>${m.payment}원</div>
                    </c:forEach>
			
			        </div>
			        
			        

                <!--사원 등록 버튼 클릭 시 모달창-->
				        
				<div class="modal">
                    <div class="modal_body">
                        <table class="type01">
                            <tr>
                                <th scope="row" colspan="2" style="font-size: 25px; text-align: center;">사원등록</th>
                            </tr>
                            <tr>
                                <td scope="row" >부서</td><td><select name="dept" id="dept">
                                    <option value="">부서선택</option>
                                    <c:forEach items="${departList}" var="d">
                                        <option value="${d}">${d}</option>
                                    </c:forEach>
                                </select></td>
                            </tr>
                            <tr>
                                <td scope="row">사원명</td><td><select name="emp" id="emp">
                                    <option value="">사원선택</option>
                                </select></td>
                            </tr>
                            <tr>
                                <td scope="row">지급율</td><td><input type="number" name="rate" id="rate" value="0"></td>
                            </tr>
                            <tr>
                                <td scope="row">지급액</td><td><input type="number" name="payment" id="payment" value="0"></td>
                            </tr>
                        </table>
                        <div><button class="modal_close btn btn-primary btn-sm">close</button><button style="float: right;" id="addEmp" class="btn btn-primary btn-sm" onclick="addEmp()">등록</button></div>


                      
                    </div>
                </div>
                


                <!--모달 js-->
                <script>
                    const modal = document.querySelector('.modal');
                    const btnOpenPopup = document.querySelector('.btn-open-popup');

                    btnOpenPopup.addEventListener('click',()=>{
                        modal.style.display = 'block';
                    })
                    
                    const close = document.querySelector('.modal_close');
                    close.addEventListener('click',()=>{
                        modal.style.display = 'none';
                    })
                </script>
               </section>
           </div>
           
       </div>

    </div>

<script>
    $("select[name=dept]").change(function(){
        var depart = $(this).val();
        console.log(depart);
        
        $.ajax({
                url : "/ForWorks/bonus/selectEmp",
                type : "POST",
                data : {depart : depart},
                success : function(result){
                    $('#emp').empty;
                    console.log(result[0]);
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

    <script>
        function addEmp(){
        var binfoNo = ${infoNo};
      
        var x = document.getElementById("emp");
	    var empNo = x.options[x.selectedIndex].value; 
      
        var rate = document.getElementById("rate").value;
        var payment = document.getElementById("payment").value;


        $.ajax({
            url : "/ForWorks/bonus/addEmp",
            type : "POST",
            data : {
                empNo : empNo,
                rate : rate,
                payment : payment,
                binfoNo : binfoNo
            },
            success : function(data){
                if(data == 1){
                    toastContent.innerText = "등록완료되었습니다.";
                    modal.style.display = 'none';
                }
                },
            error : function(){
                toastContent.innerText = "다시 시도해주세요";
            }
            })
        }
    </script>
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
    <script>
        
        $().ready(function() {
            console.log("test:");
            $('#ex1').addClass("active");
        });
        
    </script>
</html>
