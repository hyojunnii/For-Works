<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link rel="stylesheet" href="${root}/resources/css/sjy.css">
<link rel="stylesheet"href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />

<html>
<head>
	<title>투표-상세정보(사원)</title>
    <!-- <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script> -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
</head>
<body style="display: inline;">
    <%@ include file="/WEB-INF/views/common/toastify.jsp" %>
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
                        
                        <%@include file="/WEB-INF/views/vote/detailUser-content.jsp" %>
                    </div>
                    
                            <div style="text-align: right;"> 
                                <c:choose>
                                    <c:when  test="${check eq 1}">
                                        <button type="submit" class="myBtn" id="vt">투표</button>
                                    </c:when>
                                    <c:when  test="${chvo ne null}">
                                        <!-- <button type="button" class="myBtn" id="confirmStart">투표</button> -->
                                        <button type="button" class="myBtn" onclick="Confirm();">투표</button>
                                    </c:when>
 
                                </c:choose>
                                <a href="${root}/vote/list/1"><button type="button" class="myBtn">Back</button></a>
                                
                            </div>
                        </form>  
                </section>
            </div>
        
</div>

</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>


<script>

// $("#confirmStart").click(function () {
//         Swal.fire({
//         title: '현재 투표를 하였습니다.',
//         text: "다시 투표하시겠습니까??",
//         icon: 'warning',
//         showCancelButton: true,
//         confirmButtonColor: '#3085d6',
//         cancelButtonColor: '#d33',
//         confirmButtonText: '확인',
//         cancelButtonText: '취소'
        
        
//         }).then((result) => {
//         if (result.isConfirmed) {
//             Swal.fire(
//             $("form[name=vote]").submit()
            
//             )
//         }
//         })
//     });

var alert = function(msg, type) {
		swal({
			title : '',
			text : msg,
			type : type,
			timer : 1500,
			customClass : 'sweet-size',
			showConfirmButton : false
		});
	}

	var confirm = function(msg, title, resvNum) {
		swal({
			title : title,
			text : msg,
			type : "warning",
			showCancelButton : true,
			confirmButtonClass : "btn-danger",
			confirmButtonText : "예",
			cancelButtonText : "아니오"
			
		}, function(isConfirm) {
			if (isConfirm) {
                swal($("form[name=vote]").submit())

                
                
                }
            else{
				swal({
                    title:'',
                    closeOnClickOutside : false
                })
			}

		});
	}


	function Confirm() {
		confirm('', '투표를 다시하시겠습니까?');
    }
</script>
<script>
	
	// $().ready(function() {
	// 	console.log("test:");
	// 	$('#ex1').addClass("active");
	// });

</script>


<script>
    var today =new Date();
    var stday = new Date('${vtvo.vtCreate}');
    var edday = new Date('${vtvo.vtEnd}');
    console.log(today);        
    console.log(stday);
    console.log(edday);
    // console.log(stday >= today);
    // console.log(edday <= today);
    
    function check() {
                    if (stday >= today) {
                        alert('투표가 시작되지않았습니다.','success'); 
                        return false;
                    }else if(edday <= today){
                            alert('투표가 마감되었습니다.');
                            return false;
                        }
                        
                    }
</script>

<script>
    //로그인한 회원이 투표를 하였는지 확인
    //투표한경우 투표한 내용 checked
    var x = '${chvo.vtcgNo}';
    // console.log(x);
    if (x != null) {
        $("input[id='${chvo.vtcgNo}']").prop("checked",true);

    }



</script>


</html>
