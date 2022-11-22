<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${root}/resources/css/sjy.css">
<style>
	table{margin: auto;}
tr, td{
    border: 1px solid rgba(0, 0, 0, 0.144);
    margin: auto;
    text-align: center;
    vertical-align: middle;
}


table {
    border-spacing: 0;
    border-collapse: initial;
}


table {
    display: table;
    border-collapse: separate;
    box-sizing: border-box;
    text-indent: initial;
    border-spacing: 2px;
    border-color: grey;
}
</style>
<link rel="stylesheet" href="${root}/resources/css/sjy.css">
<script src="${root }/resources/js/summernote/summernote-lite.js"></script>
<script src="${root }/resources/js/summernote/lang/summernote-ko-KR.js"></script>

<link rel="stylesheet" href="${root }/resources/css/summernote/summernote-lite.css">

<form action="" method="post" enctype="multipart/form-data">
    
    
        <div id="wcontent">
            <div class="row">
                <div class="col-md-2"></div>
                <div class="col-md-8">
                    <form action="" method="post">
                        <div class="table table-responsive">
                            <table class="table table-striped" >
                                
                                <tr>
                                    <td class="" style="width: 15%;"><label for="empNo" class="form-label">작성자</label> </td>
                                    <td  style="background : white; width: 30%;">${ntvo.empNo}</td>
                                    <td style="width: 15%;"><label for="ntAccess" class="form-label" >대상</label></td>
                                    <td  style="background: white;" style="width: 30%;">
                                        <select name="ntAccess" id="ntAccess"  class="form-select form-select-sm" aria-label=".form-select-sm example">
                                            <option  selected >부서를 선택해주세요</option>
                                            <option value="0">전체</option>
                                            <c:forEach items="${dpvo }" var="dp">
                                                <option value="${dp.deptNo}" id="dep">${dp.deptName}</option>
                                            </c:forEach>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td ><label for="ntTitle" class="form-label">제목</label></td>
                                    <td colspan="3"><input type="text" class="form-control" name="ntTitle" value="${ntvo.ntTitle}"></td>
                                </tr>
    
    
                                <tr>
                                    <td ><label for="ntContent" class="form-label">내용</label></td>
                                    <td colspan="3" style=" background : white; text-align: left;"><textarea id="summernote" name="ntContent" class="form-control" style="background-color: white;" 
                                        >${ntvo.ntContent}</textarea></td>
                                </tr>
                                
                                
                                <tr >
                                    <td ><label for="ntFileName" class="form-label">첨부<br>파일</label></td>
                                    <td colspan="3" style="background: white;"><input type="file" class="form-control" name="ntFileName"></td>
                                </tr>

                                <tr>
                                    <td style="width:10%;">선택<br>파일</td>
                                    <td style="width:40%; background: white;"><img id="notice_img" src="" alt="" width="128px" height="128px"></td>

                                    <td style="width:10%;">등록<br>파일</td>
                                    <td style="width:40%; background: white;">
                                        <input type="hidden" name="ntatOrigin" value="${ntatVo.ntatChange}">
                                        <c:choose>
                                            <c:when test="${ntatVo eq null}">
                                                <div style="height: 10vh;">첨부파일이 없습니다.</div>
                                            </c:when>
                                            
                                            <c:when test="${ext eq '.jpg' || ext eq '.png'}">
                                            <div >
                                                <a href="${root}/resources/upload/notice/${ntatVo.ntatChange}" download=""><img src="${root}/resources/upload/notice/${ntatVo.ntatChange}" width="128px" height="128px"></a>
                                            </div>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="${root}/resources/upload/notice/${ntatVo.ntatChange}" download="">${ntatVo.ntatChange}</a>
                                            </c:otherwise>
                                            
                                        </c:choose>
                                    </td>

                                    

                                </tr>
                                
                                <tr>
                                    <td colspan="4" class="text-end" style="border:none; background : white;">
                                        <input type="hidden" name="num" value="">
                                        <input type="submit" value="수정하기" class="myBtn" >
    
                                    </td>
                                </tr>
                        </div>
                </div>
            </div>
        </div>
    

</form> 


<script>
$(document).ready(function() {
	//여기 아래 부분
	$('#summernote').summernote({
		  height: 300,                 // 에디터 높이
		  minHeight: null,             // 최소 높이
		  maxHeight: null,             // 최대 높이
		  focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
		  lang: "ko-KR",					// 한글 설정
		  placeholder: '최대 2048자까지 쓸 수 있습니다'	//placeholder 설정
        
	});
});
</script>   

<script>
    $(function(){
        $('#upDate').click(function(){
            //해당 번호로 요청 보내기
            location.href="${root}/notice/update?num=" ;
            
            
        });
    })
</script>

<script>
    var nt = "${ntvo.deptNum}";
    var lg = "${loginMember.deptNo}";
    

    
    console.log('nt::'+nt);
    console.log('lg::'+lg);
    
    $("#ntAccess").val(nt);

    $("#ntAccess").val(nt).prop("selected", true);

</script>



<script>
	//파일 태그 가져와서
	const fileInputTag = document.querySelector('input[name=ntFileName]');
	
	//파일 변화가 일어나면 어떤행동
	fileInputTag.onchange = function(){
		const imgTag = document.querySelector('#notice_img');
		
		if(fileInputTag.files.length>0){
			//파일 선택 되었을때
			const fr = new FileReader();
			//파라미터로 방금 로드한 데이터를 받기
			fr.onload = function(data){
				console.log(data);
				
				imgTag.src= data.target.result; //target의 result값 가져오기
			}
			fr.readAsDataURL(fileInputTag.files[0]);//파일 읽기
		}else{
			imgTag.src = "";
		}
	
	}
	
</script>