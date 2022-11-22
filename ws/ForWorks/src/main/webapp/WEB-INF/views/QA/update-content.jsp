<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link rel="stylesheet" href="${root}/resources/css/sjy.css">
<style>
    div,input{margin-bottom: 1%;}
    .nbtn{
    padding: 0;
    border: none;
    background: none;
    }
    #dplist{
        display: none;
    }
    
    
</style>
<div id="container" style="margin: 3% 5%;">
    
        <form action="" method="post" enctype="multipart/form-data" onsubmit="return check()">
            
            
                <div class="md-3"> 
                    <label for="qaTitle" class="form-label">제목</label>
                    <input type="text" class="form-control" id="qaTitle" name="qaTitle" style="height: 10vh;" value="${qavo.qaTitle}" required>
                    <br>
                </div>
            
                <div class="md-3" >
                    <input  type="file" class="form-control" style="width: 50%;" name="qaFile" >
                    <input type="hidden" name="qaatOrigin" value="${qaatList.qaatChange}">
                    <c:choose>
                        <c:when test="${qaatList.qaatChange ne null}">
                            <div class="form-control"  style="width: 50%;">
                                현재파일 :: <a  href="${root}/resources/upload/QA/${qaatList.qaatChange}" download="">${qaatList.qaatChange}</a>
                            </div>
                        </c:when>
                        
                        <c:otherwise>
                            <div class="form-control"  style="width: 50%;">현재 저장된 파일이없습니다.</div>
                        </c:otherwise>
                    </c:choose>
                </div>
                <hr>
                
                <div class="md-3"> 
                    <label for="qaContent" class="form-label">내용</label>
                    <input type="text" class="form-control" id="qaContent" name="qaContent" style="width: 50%;" value="${qavo.qaContent}" required>
                </div>

                <div class="md-3"> 
                    
                    <label for="period" class="form-label">설문기간</label><br>
                    <input type="datetime-local" class="form-control" id="qaSdate" name="qaSdate" style="width: 24.5%;display: inline;" value="${qavo.qaSdate}" required>~
                    <input type="datetime-local" class="form-control" id="qaEdate" name="qaEdate" style="width: 24.5%; display: inline;" value="${qavo.qaEdate}" required>
                </div>
                
                <div class="md-3" id="cgList"> 
                    <label for="qacgName" class="form-label">항목</label><br>
                    <input type="hidden" id="qa-list" value="${fn:length(qacgList) }" >
                    <c:forEach items="${qacgList}" var="qacg">
                        <c:set var="i" value="${i+1}"/>
                            <div id="cg${i}">
                                <input type="text" class="form-control" style="width: 50%; display: inline;" value="${qacg.qacgName}" disabled>
                            
                            </div>
                        
                    </c:forEach>

                    
                </div>
                <button type="button" class="nbtn" onclick="addList()">+ 항목 추가</button>
                <div class="md-3" id="cgAddList"> 

                </div>
</div>

<script>
    function chdp() { 
        var x = $('input[id=target2]').is(":checked");
        if (x){$('#dplist').show(); }    
            else { 
                $('#dplist').hide(); } 
    }
</script>

<script>
    var i = 1;
</script>

<!-- 투표기간 체크 -->
<script>
    //투표 시작일 가져오기
    
    var start;
    var end; 
    var dbStart = new Date('${qavo.qaSdate}');
    var today =new Date();
    var stday = new Date($('#qaSdate').val());  //시작일
    var edday =new Date($('#qaEdate').val());  //마감일
    console.log(today);
    console.log(start);
    console.log(end);
    $('#qaSdate').change(function () {
        start = $(this).val();
        stday = new Date(start);

        

    })

    $('#qaEdate').change(function () {
        end = $(this).val();
        edday = new Date(end);

    })

    function check() {
        console.log(stday);
        console.log(edday);
        console.log("시작<오늘"+(stday<=today));
        console.log("시작>마감"+(stday>=edday));
        console.log("시작>마감"+(stday>=edday));
        console.log("마감<오늘"+(edday<=today));
        
        if ((stday<=today) || (stday>=edday)) {
            alert('시작일 오류');
            return false;
        }

        else if ( (stday>=edday) || (edday<=today)) {
            alert('마감일 오류');
            return false;
        }
    }
</script>




<script>
    function deleteCg(x) {
        console.log(x);
        
        const k = Number($('#qa-list').val())-1;
            $('input[id=qa-list]').attr('value',k);
            $('#'+x).remove();
            
    }
    </script>

<script>
    console.log(i);
    console.log($("input[name='qacgName']").length);
    function addList() {
        console.log(i);
        const k = Number($('#qa-list').val())+1;
        $('input[id=qa-list]').attr('value',k);
        $('#cgAddList').append("<div id='cg"+ i +"'>"+
            "<input type='text' class='form-control'  name='qacgName' style='width: 50%; display: inline;'>"+
            "<button type='button' class='nbtn' onclick='deleteCg($(this).closest("+"&#39;div&#39;"+").attr("+"&#39;id&#39;"+"))'>x</button>"
            +"</div>");
        }
</script>