<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
   
<!DOCTYPE html>
<html>
<head>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
	
	<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1" />
	<title>일정 등록</title>
</head>

<style>
	body, html{
	margin:0;
	padding:0;
	font-weight:600;
	font-size:16px;
	}
	a{
	text-decoration:none;
	}
	/*팝업창 본 내용*/
	.pj_popup{
	width:700px;
	background:#eef1ff;
	padding:84px 36px 38px;
	position: relative;
	}
	.popup_name{
	position: absolute;
	left:15px;
	top:20px;}
	.pj_c_block{
	width:width:100%;
	background:#fff;
	border-radius:10px;
	padding:18px 30px;
	}
	.pj_top{
	text-align:center;
	}
	.pj_name{
	background:#F5F5F5;
	border:1px solid #6F5CFA;
	padding:20px 15px;
	color:#A1A1A1;
	font-size:13px;
	font-weight:600;
	display:block;
	width:95.5%;
	height:50px;
	margin:10px 0;}
	
	/*버튼 설정*/
	.pj_bts{
	margin:8px 0 0;
	}
	
	/*날짜 관련 설정*/
	.pj_fday_eday{
	display:flex;
	justify-content:space-between;
	}
	.pj_fday, .pj_eday{
	width:45%;
	}
	.pj_fday_eday input{
	background:#F5F5F5;
	border:1px solid #6F5CFA;
	padding:8px 5px;
	color:#A1A1A1;
	font-size:13px;
	font-weight:600;
	display:block;
	width:95.5%;
	margin:10px 0;
	}
	
	input[type="date"] { 
   	position: relative; 
    padding-right:42px; 
    width: 230px;
    height: 48px;
    padding: 0 42px 0 16px;
    background: <img src="/resources/img/calendar.svg">  no-repeat right 21px center / 16px auto;
    border:1px solid #6F5CFA;

    }
    
    input[type="date"] ::-webkit-clear-button,
    input[type="date"] ::-webkit-inner-spin-button { display: none;}
    input[type="date"] ::-webkit-calendar-picker-indicator {

    position:absolute;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background: transparent;
    color: transparent;
    cursor: pointer;
    }

    input[type="date"]::before {
    /*attr(속성) : 속성값을 가져옴, input date에 required 입력해야 실행됨.*/
    content: attr(data-placeholder);
    width: 100%;
    }
    input[type="date"]:valid::before {
    display: none;
    }
    input[type="data-placeholder"]::before {
    color:gray
    font: size 14px;
    padding: left 16px;

    }
    
	/*등록 버튼 설정*/
	.pj_submit{
	margin:8px 0 0;
	text-align: right;
	}
	.pj_submit a{
	background: #6F5CFA;
	color: #FFF;
	border-radius:13px;
	padding:3px 0;
	width:100px;
	display:inline-block;
	text-align:center;
	margin:4px 2px;
	}
	.pj_submit a:hover{
	border:1px solid #6F5CFA;
	background: #FFF;
	color:#000;
	}
	.pj_submit .on{
	border:1px solid #6F5CFA;
	background: #FFF;
	color:#000;
	}
	
	.pj_close{
	margin:8px 0 0;
	text-align: right;
	border-radius:13px;
	padding:3px 0;
	width:100px;
	display:inline-block;
	text-align:center;
	margin:4px 2px;	
	}	
</style>


<body>
	<div class="pj_popup">
		<div class="popup_name">일정등록</div>
		<div class="pj_c_block">
			<div class="pj_top">일정 등록</div>
			<div class="pj_title"><input type="text" name="pname" placeholder="일정 제목을 입력하세요." style="border: none; background: transparent;" autofocus></div>
				<input type="text" class="pj_name" name="pcontent" placeholder="내용 입력">

			<div class="pj_fday_eday">
				<div class="pj_fday">
					시작일 <a href="" class="calendar"></a>
					<input type="date" name="pstart" data-placeholder="시작일을 선택해주세요." required>
				</div>

				<div class="pj_eday">
					종료일 <a href="" class="calendar"></a>
					<input type="date" name="pend" data-placeholder="종료일을 선택해주세요." required>
				</div>
			</div>
			<div class="pj_submit">
				<a href="javascript:click_ok();">등록</a>
			<div class="pj_close">
				<a href="">취소</a>
			</div>
		</div>
	</div>
</div>
</body>
<script>

$().ready(function() {
	console.log("test:");
	$('#ex1').addClass("active");
});

	/* $.fn.serializeObject = function(){
	    var o = {};
	    var a = this.serializeArray();
	    $.each(a, function() {
	    	var name = $.trim(this.name),
	    		value = $.trim(this.value);
	    	
	        if (o[name]) {
	            if (!o[name].push) {
	                o[name] = [o[name]];
	            }
	            o[name].push(value || '');
	        } else {
	            o[name] = value || '';
	        }
	    });
	    return o;
	}; */
	
	
	
	function click_ok(){

		//var scheduleData = JSON.stringify($('form#scheduleData').serializeObject());
		
		const pname = document.querySelector('input[name=pname]').value;
		const pcontent = document.querySelector('input[name=pcontent]').value;
		const pstart = document.querySelector('input[name=pstart]').value;
		const pend = document.querySelector('input[name=pend]').value;
		
		$.ajax({
			data : {
				"pname" : pname ,
				"pcontent" : pcontent ,
				"pstart" : pstart ,
				"pend" : pend
			},
			url : "addSchedule",
			type : "POST",
			//dataType : "json",
			//contentType : "application/json; charset=UTF-8",
			success : function(data) {
				alert("일정" + data + "개가 추가되었습니다");
				opener.parent.location.reload();
				window.close();
			}
		});
	};	
</script>
</html>