<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    .nbtn{
        border: none;
        outline: none;
    }
    
</style>
<div id="container" style="margin: 3% 5%;">
    
        <form action="" method="post" enctype="multipart/form-data" onsubmit="return check()">
            
            
                <div class="md-3"> 
                    <label for="qaTitle" class="form-label">제목</label>
                    <input type="text" class="form-control" id="qaTitle" name="qaTitle" style="height: 10vh;" required placeholder="제목을 입력해주세요">
                    <br>
                </div>
            
                <div class="md-3">
                    <input type="file" class="form-control" style="width: 50%;" name="qaFile">
                </div>
                <hr>
                
                <div class="md-3"> 
                    <label for="qaContent" class="form-label">내용</label>
                    <input type="text" class="form-control" id="qaContent" name="qaContent" style="width: 50%;" required placeholder="내용을 입력해주세요">
                </div>

                <div class="md-3"> 
                    
                    <label for="period" class="form-label">설문기간</label><br>
                    <input type="datetime-local" class="form-control" id="qaSdate" name="qaSdate" style="width: 24.5%;display: inline;"  required >~
                    <input type="datetime-local" class="form-control" id="qaEdate" name="qaEdate" style="width: 24.5%; display: inline;" required>
                </div>

                <div class="md-3"> 
                    <label for="target" class="form-label">대상자</label>    &nbsp;&nbsp;&nbsp;
                    <label for="target1"><input type="radio" id="target1" name="target"  value="all"  onclick="chdp()" checked>전체</label>
                    <label for="target2"><input type="radio" id="target2" name="target"  value="dp" onclick="chdp()">부서선택</label>
                    <br>
                    <div id="dplist">
                        <!-- 부서정보 가져오기 -->
                        <c:forEach items="${dpvo }" var="dp">
                            
                            <label for="d${dp.deptNo}">${dp.deptName}<input type="checkbox" id="d${dp.deptNo}" name="dept" value="${dp.deptNo}" ></label> &emsp;
                        </c:forEach>


                    </div>
                </div>
                
                <div class="md-3" id="cgList"> 
                    <label for="qacgName" class="form-label">항목</label><br>
                    <input type="hidden" id="qa-list" value="2" >
                    <div>
                        <input type="text" class="form-control"  name="qacgName" style="width: 50%; display: inline;" required placeholder="항목을 입력해주세요">
                        
                    </div>

                    <div>
                        <input type="text" class="form-control"  name="qacgName" style="width: 50%; display: inline;" required placeholder="항목을 입력해주세요">

                    </div>

                    
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
    var i = $('#qa-list').val();
    console.log("iii"+i);
</script>

<!-- 설문기간 체크 -->
<script>
    //설문 시작일 가져오기
    var start;
    var today =new Date();
    var end;
    var stday;
    var edday;
    console.log(today);
    
    $('#qaSdate').change(function () {
        start = $(this).val();

        stday = new Date(start);
        console.log(stday);
        console.log((stday<=today));
        

    })

    $('#qaEdate').change(function () {
        end = $(this).val();

        edday = new Date(end);
        console.log(edday);
        console.log((edday<=today));
        console.log(stday);
        console.log(stday>=edday);
    })


    function check() {
        
        if (stday <= today) {
            alert('시작일 오류');
            return false;
        }

        else if ( (stday>=edday) && (edday<=today)) {
            alert('마감일 오류');
            return false;
        }
        else if($('input[id=target2]').is(":checked") && !($('input[name=dept]').is(":checked"))){
            alert('대상자 선택 오류(부서를 선택부탁드립니다.)');
            return false;
        } 
    }
</script>




<script>
    function deleteCg(x) {
        i--;
        console.log("-클릭후"+i);
        const k = Number($('#qa-list').val())-1;
        $('input[id=qa-list]').attr('value',k);
        $('#'+x).remove();
        
    }
</script>

<script>
    
    function addList() {
        
        console.log("+클릭후"+i);
        const k = Number($('#qa-list').val())+1;
        $('input[id=qa-list]').attr('value',k);
        $('#cgAddList').append("<div id='cg"+ $('#qa-list').val() +"'>"+
            "<input type='text' class='form-control'  name='qacgName' style='width: 50%; display: inline;' placeholder='항목을 입력해주세요'>"+
            "<button style='' type='button' class='nbtn' onclick='deleteCg($(this).closest("+"&#39;div&#39;"+").attr("+"&#39;id&#39;"+"))'><i style='font-size:20px;' class='bi bi-dash-square' ></i></button>"
            +"</div>");
        }
</script>