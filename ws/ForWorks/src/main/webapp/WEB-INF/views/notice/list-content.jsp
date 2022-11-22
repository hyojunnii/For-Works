<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<c:set var="alertMsg" value="${sessionScope.alertMsg }"/>
<c:remove var="alertMsg" scope="session"/>
<c:if test="${not empty alertMsg }">
    <script>
        alert('${alertMsg}');
    </script>
</c:if>   

<link rel="stylesheet" href="${root}/resources/css/sjy.css"/>
<style>
tr:hover{
    cursor: pointer;
    background-color: rgba(128, 128, 128, 0.425);
}
tr>th:hover{
    cursor: default; 
}
.b{
    color:black;
}
</style>
<!-- 검색박스 -->
<div class="container" style="margin: 3% 5%;">
    <div class="row">

        <div class="col">
            <div class="csearch">

                <form action="${root}/notice/list/1" method="get">
                <!-- <input type="search" class="form-control ds-input" id="" placeholder="Search docs..." style="width: auto; display: inline; " > -->
                <div class="input-group w-70">
                    <!-- <select  class="form-select" aria-label="Default select example" name="condition">
                        <option value="title" selected >제목</option>
                    </select> -->
                    <input style="text-align: center;" type="text" value="제목" name="title" disabled>
                    <input type="text" class="form-control" placeholder="검색어를 입력해주세요"
                        aria-label="Input group example" aria-describedby="basic-addon1" name="keyword" value="${keyword}">
                    <span class="input-group-text" id="basic-addon1">
                        <button type="submit" class="mybtn">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
                                <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"></path>
                            </svg>
                        </button>
                    </span>

                    <span class="input-group-text" id="basic-addon1">
                        <a href="${root}/notice/list/1">
                        <button type="button" class="mybtn">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-counterclockwise" viewBox="0 0 16 16">
                                <path fill-rule="evenodd" d="M8 3a5 5 0 1 1-4.546 2.914.5.5 0 0 0-.908-.417A6 6 0 1 0 8 2v1z"></path>
                                <path d="M8 4.466V.534a.25.25 0 0 0-.41-.192L5.23 2.308a.25.25 0 0 0 0 .384l2.36 1.966A.25.25 0 0 0 8 4.466z"></path>
                            </svg>
                        </button>
                        </a>
                    </span>
                </div>
                </form>
            </div>
            <br>
            <!-- 공지사항 리스트박스 -->
            <div id="notice">
                <div id="list" style="overflow:auto;">

                    <table class="table" id="table-main">
                        <thead class="table-light">
                            <tr id="center">
                                <th scope="col">#</th>
                                <th scope="col" colspan="5">제목</th>
                                <th scope="col">작성자</th>
                                <th scope="col">열람대상</th>
                                <th scope="col">조회수</th>
                                <th scope="col">등록일자</th>
                            </tr>
                        </thead>

                        
                        <c:forEach items="${ntList }" var="nt">
                            <tbody id="tbd">
                                <tr id="center">
                                    
                                    <input type="hidden" value="${nt.ntno}">
                                    <th scope="row">${nt.rownum }</th>
                                    <td colspan="5">${nt.ntTitle }</td>

                                    <td>${nt.empNo }</td>
                                    <td>${nt.ntAccess }</td>
                                    <td>${nt.ntCnt }</td>
                                    <td>${nt.ntEnrollDate }</td>
                                </tr>
                            </tbody>
                        </c:forEach>
                        <td colspan="10" style="border:none; cursor: default; background: white;">

                            <ul class="pagination justify-content-center">

                                <c:if test="${pv.startPage ne 1 }">
                                    <li><a href="${root}/notice/list/1?&keyword=${keyword}" class="page-link b disabled">처음</a></li>
                                    <li class="page-item"><a href="${root}/notice/list/${pv.startPage -1 }?&keyword=${keyword}"
                                            class="page-link">이전</a></li>
                                </c:if>



                                <c:forEach begin="${pv.startPage }" end="${pv.endPage }" var="i">
                                    <li class="page-item " aria-current="page">
                                        <a class="page-link b" href="${root}/notice/list/${i}?&keyword=${keyword}">${i}</a>
                                    </li>
                                </c:forEach>

                                <c:if test="${pv.endPage ne pv.maxPage }">
                                    <li><a class="page-link b" href="${root}/notice/list/${pv.endPage +1 }?&keyword=${keyword}">다음</a></li>
                                    <li><a class="page-link b" href="${root}/notice/list/${pv.maxPage }?&keyword=${keyword}">끝</a></li>
                                </c:if>
                            </ul>

                        </td>

                    </table>
                </div>
                <c:if test = "${loginMember.opLevel eq 3}">
                    <div style="text-align: right;">
                        <a href="${root }/notice/write"><button class="myBtn" >글작성</button></a>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</div>


<script>
    $(function(){
        $('#table-main>tbody>#center').click(function(){
            //행 클릭 되었을때, 동작할 내용

            //글번호 가져오기
            const num = $(this).children().eq(0).val();
            
            //해당 번호로 요청 보내기
            location.href='${root}/notice/detail/'+num;
            
        });
    })
</script>

