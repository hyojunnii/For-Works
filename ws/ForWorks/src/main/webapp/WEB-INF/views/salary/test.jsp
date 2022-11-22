<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>SummerNoteExample</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  
  <!-- 서머노트를 위해 추가해야할 부분 -->
  <script src="${pageContext.request.contextPath}/resources/summernote/summernote-lite.js"></script>
  <script src="${pageContext.request.contextPath}/resources/summernote/lang/summernote-ko-KR.js"></script>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/summernote/summernote-lite.css">
  <!--  -->
  <style>
    #wrap{
        align-items: left;
    }
    th{
      width: 25%;
    }
    input[type=text]{
      width:100%;
    }
    #sub{
      width: 80%;
      text-align: center;
    }
    
  </style>
</head>
<body>
    <form action="">
        <div id="wrap">

          <table>
            <tr>
              <th>보존 마감 날짜</th>
              <td><input type="date" name="end_date"></td>
            </tr>
            <tr>
              <th>공개범위</th>
              <td>
                <select name="range_no" id="">
                <option value="">전체공개</option>
                </select>
              </td>
            </tr>
            <tr>
              <th>제목</th>
              <td><input type="text" name="title"></td>
            </tr>
            <tr>
              <th>첨부파일</th>
              <td><input type="file"></td>
            </tr>
            <tr>  
              <td colspan="3"><textarea class="summernote" name="content"></textarea></td>
            </tr>
            
            
          </table>
          <div id="sub"><input type="button" value="취소"><input type="submit" value="등록"></div>
              
        </div>
        </form>
<script>
$('.summernote').summernote({
	  height: 350,
	  lang: "ko-KR"
	});


</script>
</body>
</html>