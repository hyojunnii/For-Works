<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${root}/resources/css/sjy.css">    
<script src="${root }/resources/js/summernote/summernote-lite.js"></script>
<script src="${root }/resources/js/summernote/lang/summernote-ko-KR.js"></script>

<link rel="stylesheet" href="${root }/resources/css/summernote/summernote-lite.css">
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


<form action="" method="post" enctype="multipart/form-data" onsubmit="return check()">
    
    
        <div id="wcontent">
            <div class="row">
                <div class="col-md-2"></div>
                <div class="col-md-8">
                    <form action="" method="post">
                        <div class="table "><!--table-responsive-->
                            <table class="table table-striped">
                                <tr>
                                    <td class="" style="width: 15%;"><label for="empNo" class="form-label">작성자</label> </td>
                                    <td  style=" background : white;" style="width: 30%;">${loginMember.empName}</td>
                                    <td style="width: 15%;"><label for="ntAccess" class="form-label">대상</label></td>
                                    <td  style="background: white; width: 30%;">
                                        <select name="ntAccess" id="ntAccess" class="form-select form-select-sm" aria-label=".form-select-sm example" style="width: auto;">
                                            <option value="nu" selected >접근권한을 선택해주세요</option>
                                            
                                            <option value="0">전체</option>
                                            <c:forEach items="${dpvo }" var="dp">
                                                <option value="${dp.deptNo}">${dp.deptName}</option>
                                            </c:forEach>
                                            
                                        </select>
                                    </td>
                                </td>
                                <td style="background: white; border:0;">
                                    <a href="${root}/notice/list/1">
                                        <button type="button" class=" myBtn">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-house-door-fill"
                                                viewBox="0 0 16 16">
                                                <path d="M6.5 14.5v-3.505c0-.245.25-.495.5-.495h2c.25 0 .5.25.5.5v3.5a.5.5 0 0 0 .5.5h4a.5.5 0 0 0 .5-.5v-7a.5.5 0 0 0-.146-.354L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293L8.354 1.146a.5.5 0 0 0-.708 0l-6 6A.5.5 0 0 0 1.5 7.5v7a.5.5 0 0 0 .5.5h4a.5.5 0 0 0 .5-.5z"></path>
                                            </svg>
                                        </button>
                                    </a>
                                </td>
                                </tr>
                                <tr>
                                    <td ><label for="ntTitle" class="form-label">제목</label></td>
                                    <td colspan="3"><input type="text" class="form-control" name="ntTitle" required></td>
                                </tr>
    
    
                                <tr>
                                    <td ><label for="ntContent" class="form-label">내용</label></td>
                                    <td colspan="3" style=" background : white; text-align: left;"><textarea id="summernote" name="ntContent" class="form-control" style="background-color: white;" required></textarea></td>
                                </tr>
    
                                <tr>
                                    <td ><label for="ntFileName" class="form-label">첨부파일</label></td>
                                    <td colspan="3"><input type="file" class="form-control" name="ntFileName"></td>
                                </tr>
                                
                                <tr>
                                    <td colspan="4" class="text-end" style="border:none; background : white;">
                                        <input type="hidden" name="num" value="현재글번호">
                                        <input type="submit" value="작성하기" class="myBtn">
    
                                    </td>
                                </tr>
                            </table>
                        </div>
                </div>
            </div>
        </div>
    

</form> 

<!-- 공지사항 작성시 대상 선택여부확인 -->
<script>
	var x;
	$("select[name=ntAccess]").change(function(){
		x= $(this).val();
		console.log(x);
	}); 
    function check(){
        if (x== "nu") {
            alert('대상을 선택해주세요!');
            return false;
        }
    }
</script>

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


        <script type="text/javascript">
            $(document).ready(function() {
                $('#summernote').summernote({
                    height: 300,
                    minHeight: null,
                    maxHeight: null,
                    focus: true,
                    callbacks: {
                        onImageUpload: function (files, editor, welEditable) {
                            for (var i = files.length - 1; i >= 0; i--) {
                                sendFile(files[i], this);
                            }
                        }
                    }
                });
        });
        function sendFile(file, el) {
            var form_data = new FormData();
                    form_data.append('file', file);
                    $.ajax({
                        data: form_data,
                        type: "POST", url: '/image',
                        cache: false, contentType: false,
                        enctype: 'multipart/form-data',
                        processData: false,
                        success: function (url) {
                            $(el).summernote('editor.insertImage', url);
                            $('#imageBoard > ul').append('<li><img src="' + url + '" width="480" height="auto" /></li>');
                        }
                    });
                }
            </script>

