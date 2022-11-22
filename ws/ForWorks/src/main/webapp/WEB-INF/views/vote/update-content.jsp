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
                    <label for="vtTitle" class="form-label">제목</label>
                    <input type="text" class="form-control" id="vtTitle" name="vtTitle" style="height: 10vh;" value="${vtvo.vtTitle}" required>
                    <br>
                </div>
            
                <div class="md-3" >
                    <input  type="file" class="form-control" style="width: 50%;" name="vtFile" >
                    <input type="hidden" name="vtatOrigin" value="${vtatList.vtatChange}">
                    <c:choose>
                        <c:when test="${vtatList.vtatChange ne null}">
                            <div class="form-control"  style="width: 50%;">
                                현재파일 :: <a  href="${root}/resources/upload/vote/${vtatList.vtatChange}" download="">${vtatList.vtatChange}</a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="form-control"  style="width: 50%;">파일이없습니다.</div>
                        </c:otherwise>
                    </c:choose>
                </div>
                <hr>
                
                <div class="md-3"> 
                    <label for="vtContent" class="form-label">내용</label>
                    <input type="text" class="form-control" id="vtContent" name="vtContent" style="width: 50%;" value="${vtvo.vtContent}" required>
                </div>

                <div class="md-3"> 
                    
                    <label for="period" class="form-label">설문기간</label><br>
                    <input type="datetime-local" class="form-control" id="vtCreate" name="vtCreate" style="width: 24.5%;display: inline;" value="${vtvo.vtCreate}" required>~
                    <input type="datetime-local" class="form-control" id="vtEnd" name="vtEnd" style="width: 24.5%; display: inline;" value="${vtvo.vtEnd}" required>
                </div>

                <!-- 부서정보 가져오기 -->
                <!-- <div class="md-3"> 
                    <label for="target" class="form-label">대상자</label>    &nbsp;&nbsp;&nbsp;
                    <label for="target1"><input type="radio" id="target1" name="target"  value="all"  onclick="chdp()" checked>전체</label>
                    <label for="target2"><input type="radio" id="target2" name="target"  value="dp" onclick="chdp()">부서선택</label>
                    <br>
                    <div id="dplist">
                        <c:forEach items="${dpvo }" var="dp">
                            
                            <label for="d${dp.deptNo}">${dp.deptName}<input type="checkbox" id="d${dp.deptNo}" name="dept" value="${dp.deptNo}" ></label> &emsp;
                        </c:forEach>


                    </div>
                </div> -->
                
                <div class="md-3" id="cgList"> 
                    <label for="vtcgName" class="form-label">항목</label><br>
                    <input type="hidden" id="vt-list" value="${fn:length(vtcgList) }" >
                    <c:forEach items="${vtcgList}" var="vtcg">
                        <c:set var="i" value="${i+1}"/>
                            <div id="cg${i}">
                                <input type="text" class="form-control" style="width: 50%; display: inline;" value="${vtcg.vtcgName}" disabled>
                            
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
    
    var today =new Date();
    var stday =new Date($('#vtCreate').val());  //시작일
    var edday =new Date($('#vtEnd').val());  //마감일
    console.log(today);

    $('#vtCreate').change(function () {
        start = $(this).val();
        stday = new Date(start);

        

    })

    $('#vtEnd').change(function () {
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
    
    // else if($('input[id=target2]').is(":checked") && !($('input[name=dept]').is(":checked"))){
    //     alert('대상자 선택 오류(부서를 선택부탁드립니다.)');
    //     return false;
    // } 
</script>



<script>
    function deleteCg(x) {
        console.log(x);
        
        const k = Number($('#vt-list').val())-1;
            $('input[id=vt-list]').attr('value',k);
            $('#'+x).remove();
            
    }
    </script>

<script>
    console.log(i);
    console.log($("input[name='vtcgName']").length);
    function addList() {
        console.log(i);
        const k = Number($('#vt-list').val())+1;
        $('input[id=vt-list]').attr('value',k);
        $('#cgAddList').append("<div id='cg"+ i +"'>"+
            "<input type='text' class='form-control'  name='vtcgName' style='width: 50%; display: inline;'>"+
            "<button type='button' class='nbtn' onclick='deleteCg($(this).closest("+"&#39;div&#39;"+").attr("+"&#39;id&#39;"+"))'>x</button>"
            +"</div>");
        }
</script>