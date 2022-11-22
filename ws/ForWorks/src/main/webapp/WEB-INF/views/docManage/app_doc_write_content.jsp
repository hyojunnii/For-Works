<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>   

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<!-- 서머노트를 위해 추가해야할 부분 -->
<script src="${pageContext.request.contextPath}/resources/summernote/summernote-lite.js"></script>
<script src="${pageContext.request.contextPath}/resources/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/summernote/summernote-lite.css">

<style>
    table{
        width: 100%;
    }
    th{
      width: 15%;
    }
    input[type=text]{
      width:100%;
    }
    #sub{
      text-align: center;
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
        width: 800px;
        height: 800px;
        padding: 40px;
        text-align: left;
        background-color: rgb(255,255,255);
        border-radius: 10px;
        box-shadow: 0 2px 3px 0 rgba(34,36,38,0.15);
        transform: translateX(-50%) translateY(-50%);
    }
   
   
</style>

</head>
<body>
    <form action="" method="post" enctype="multipart/form-data" >
        <div id="wrap">

          <table>
            <tr>
              <th>보존 시작 날짜</th>
              <td><input type="date" name="contEnrollDate"></td>
            </tr>
            <tr>
              <th>보존 마감 날짜</th>
              <td><input type="date" name="contEndDate"></td>
            </tr>
            <tr>
              <th>공개범위</th>
              <td>
                    <label><input type="checkbox" name="range_" id="all" value="OPEN">전체공개</label>
                  <c:forEach items="${dept}" var="d">
                    <label> <input type="checkbox" name="range_"  value="${d.deptNo}${d.deptName}">${d.deptName}</label>
                  </c:forEach>
                
              </td>
            </tr>
            <tr>
              <th>제목</th>
              <td><input type="text" name="title" id="title"></td>
              <td><button type="button" class="btn-open-popup btn btn-primary btn-sm" >결재문서불러오기</button></td>
            </tr>
            <tr>
              <th>기안날짜</th>
              <td><div id="draftDate"></div><input type="hidden" name="adocNo" id="adocNo"></td>
            </tr>
            <tr>
              <th>결재인</th>
              <td><div id="approvMember"></div></td>
            </tr>
            <tr>
              <th>첨부파일</th>
              <td id="addfile"></td>
            </tr>
            <tr>  
              <td colspan="3" id="miri"> <div id="content"></div></td>
            </tr>
            
            
          </table>
          <div id="sub"><input type="button" onclick="window.history.back()" class="btn btn-primary btn-sm" value="취소"><input type="submit" value="등록"  class="btn btn-primary btn-sm"></div>
              
        </div>
        </form>
        <!--조회 버튼 클릭 시 모달창-->
				        
				<div class="modal">
          <div class="modal_body">
            <table id="set">
              <tr>
                <td>날짜</td>
                <td><input type="month" name="docDate" id="docDate"></td>
                <td><button type="button" class="btn btn-primary btn-sm" onclick="select()">결재문서조회</button></td>
              </tr>
              <tr>
                <td>결재종류</td>
                <td>제목</td>
                <td>기안날짜</td>
              </tr>
            </table>
            <button class="modal_close btn btn-primary btn-sm" style="float: right;">닫기</button>
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
<script>
	function select(){
		var docDate = document.getElementById("docDate").value;
        $.ajax({
            url : "/ForWorks/appmanage/select",
            type: "POST",
            data : {docDate : docDate},
            success : function(data){
				$(".ajax").remove();
				for(var i = 0 ; i < data.length; i++){
					
					$("#set").append('<tr><td class="ajax">전자결재</td><td class="ajax"><div onclick="goval('+data[i].adocNo+')">'+ data[i].adocName+'</div></td><td class="ajax">'+data[i].draftDate+'</td></tr>')
				}
            },
            error : function(){
              toastContent.innerText = "다시 시도해주세요";
            }
        })
	}
</script>
<script>
  function goval(data){
    modal.style.display = 'none';
    var adocNo = data;
    $.ajax({
      url : "/ForWorks/appmanage/selectOne",
      type: "POST",
      data : {adocNo : adocNo},
      success : function(data){
        var no = data[0].adocNo;
        document.getElementById("adocNo").value = no;
        var name = data[0].adocName;
        document.getElementById("title").value = name;
        var draftDate = data[0].draftDate;
        
        $("#draftDate").text(draftDate);
        var approveMember = data[0].approveMember;
       
        $("#approvMember").text(approveMember);
        if(data[0].changeFileName != null){

          for(var i = 0 ; i < data.length ; i++){
           
            $("#addfile").append('<a href="{root}/resources/upload/doc/'+data[i].changeFileName+'">'+data[i].fileName+'</a>');
          }
        }else{
          $("#addfile").append('<span>*첨부파일없음</span>');
        }
        var content = data[0].adocContent;
        $("#content").html(content);
       
      },
      error : function(){
        toastContent.innerText = "다시 시도해주세요";
      }
    })
  }
</script>

<script>
  function fmiri(no){
    window.location.href="${root}/appmanage/formtest/"+no;
  }

</script>


<script>
$('.summernote').summernote({
	  height: 350,
	  lang: "ko-KR"
	});
</script>
<script>
  $(document).ready(function() {
	$("#all").click(function() {
		if($("#all").is(":checked")) $("input[name=range_]").prop("checked", true);
		else $("input[name=range_]").prop("checked", false);
	});

	$("input[name=range_]").click(function() {
		var total = $("input[name=range_]").length;
		var checked = $("input[name=range_]:checked").length;

		if(total != checked) $("#all").prop("checked", false);
		else $("#all").prop("checked", true); 
	});
});
</script>


</body>
</html>