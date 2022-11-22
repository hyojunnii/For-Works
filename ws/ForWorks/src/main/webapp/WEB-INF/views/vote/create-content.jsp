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
    
    
</style>
<div id="container" style="margin: 3% 5%;">
    
        <form action="" method="post" enctype="multipart/form-data" onsubmit="return check()">
            
            
                <div class="md-3"> 
                    <label for="vtTitle" class="form-label">제목</label>
                    <input type="text" class="form-control" id="vtTitle" name="vtTitle" style="height: 10vh;" required placeholder="제목을 입력해주세요">
                    <br>
                </div>
            
                <div class="md-3">
                    <input type="file" class="form-control" style="width: 50%;" name="vtFile">
                </div>
                <hr>
                
                <div class="md-3"> 
                    <label for="vtContent" class="form-label">내용</label>
                    <input type="text" class="form-control" id="vtContent" name="vtContent" style="width: 50%;" required placeholder="내용을 입력해주세요">
                </div>

                <div class="md-3"> 
                    
                    <label for="period" class="form-label">설문기간</label><br>
                    <input type="datetime-local" class="form-control" id="vtCreate" name="vtCreate" style="width: 24.5%;display: inline;"  required>~
                    <input type="datetime-local" class="form-control" id="vtEnd" name="vtEnd" style="width: 24.5%; display: inline;" required>
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
                    <label for="vtcgName" class="form-label">항목</label><br>
                    <input type="hidden" id="vt-list" value="2" >
                    <div>
                        <input type="text" class="form-control"  name="vtcgName" style="width: 50%; display: inline;" required placeholder="항목을 입력해주세요">
                        
                    </div>

                    <div>
                        <input type="text" class="form-control"  name="vtcgName" style="width: 50%; display: inline;" required placeholder="항목을 입력해주세요">
                        
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
    var i = 1;
</script>

<script>
    //투표 시작일 가져오기
    
    var start;
    var end; 
    
    var today =new Date();
    var stday ;  //시작일
    var edday ;  //마감일
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
        
        const k = Number($('#vt-list').val())-1;
        $('input[id=vt-list]').attr('value',k);
        $('#'+x).remove();
        
    }
</script>

<script>
    console.log(i);
    function addList() {
        
        console.log(i);
        const k = Number($('#vt-list').val())+1;
        $('input[id=vt-list]').attr('value',k);
        $('#cgAddList').append("<div id='cg"+ $('#vt-list').val() +"'>"+
            "<input type='text' class='form-control'  name='vtcgName' style='width: 50%; display: inline;' placeholder='항목을 입력해주세요'>"+
            "<button type='button' class='nbtn' onclick='deleteCg($(this).closest("+"&#39;div&#39;"+").attr("+"&#39;id&#39;"+"))'><i style='font-size:20px;' class='bi bi-dash-square' ></i></button>"
            +"</div>");
        }
</script>