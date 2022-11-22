<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link rel="stylesheet" href="${root}/resources/css/sjy.css">
<style>
    .cic{
        
        height: 60vh;
        border-left: 1px dashed rgba(121, 121, 121, 0.555);
        
    }

</style>
<link rel="stylesheet" href="${root}/resources/css/sjy.css"/>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>

<div id="container">
    <div class="dcontent" style="float: left; ">
        <div class="mglt" style="margin-top: 30px;">

            <h3>
                <a href="${root}/QA/list/1">
                    <button type="button" class=" myBtn ps">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-house-door-fill"viewBox="0 0 16 16">
                            <path d="M6.5 14.5v-3.505c0-.245.25-.495.5-.495h2c.25 0 .5.25.5.5v3.5a.5.5 0 0 0 .5.5h4a.5.5 0 0 0 .5-.5v-7a.5.5 0 0 0-.146-.354L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293L8.354 1.146a.5.5 0 0 0-.708 0l-6 6A.5.5 0 0 0 1.5 7.5v7a.5.5 0 0 0 .5.5h4a.5.5 0 0 0 .5-.5z"></path>
                        </svg>
                    </button>
                </a>
                <label for="">${qavo.qaTitle}</label>
            </h3>
            <label class="text-subtitle text-muted">생성자: ${qavo.empNo}</label>
            <p class="text-subtitle text-muted" style="font-weight: 900;">${qavo.qaSdate}~${qavo.qaEdate}</p>
            
            
            <div class="md-3"> 
                
                <div class="form-control" style="width: 80%; border: none; font-size: px;">내용 :: ${qavo.qaContent}</div>
            </div>
            <br>

            <div class="md-3"> 
            <c:forEach items="${qacgList}" var="cg">
                <input type="hidden" name="num" value="${cg.rownum}">
                <div class="form-control" style="width: 80%;">${cg.rownum}번 항목 :: <label for="${cg.rownum}" class="form-label">${cg.qacgName}</label></div><br>
            </c:forEach>
            </div>

            
            <div>
                <label for="" style="font-weight: 800; color: rgba(90, 90, 90, 0.644);">파일여부::</label>
                <c:if test="${qaatList eq null}">
                    
                        <div class="form-control" style="width: 50%; display: inline;">첨부파일이 없습니다.</div>
                    
                </c:if>
                <c:if test="${qaatList ne null}">
                    <div class="form-control" style="width: 50%; display: inline;"><a href="${root}/resources/upload/QA/${qaatList.qaatChange}"download>${qaatList.qaatChange}</a></div> <br><br>
                    <button class="btn btn-primary" onclick="ig()" >이미지미리보기</button>
                    <br>
                    <div id="fimg">

                    </div>
                    
                </c:if>
            </div>
        </div>

        
    </div>
    <div class="chart" style="float: left;">
        <div class="kk tab-content" style="height: 100%;padding-bottom: 5%; color: none;  background-color: rgba(201, 201, 201, 0.26);" >
            <div class="mglt" style="margin-top: 30px;">
                <h3><label for="">답변내용</label></h3>
                
            </div>
                

			<ul class="nav nav-tabs">
                <li class="nav-item"><a class="nav-link active"data-toggle="tab" href="#a">▷</a></li>
                <c:forEach items="${qacgList}" var="cg">
                    <li class="nav-item"><a class="nav-link "data-toggle="tab" href="#cg${cg.rownum}">${cg.rownum}번항목</a></li>
                </c:forEach>  
			</ul>

            <!-- 답변내용 -->
            
                <div class="tab-pane fade show active" id="a" >
                    <div id="list" style="border: none;">
                        <img src="${root}/resources/img/Checklist.png"  width="100%" height="100%" style="opacity: 0.7; border: none;"/>
                    </div>
                </div>
                <c:forEach items="${qacgList}" var="cg" varStatus="status">
                <div class="tab-pane fade" id="cg${cg.rownum}">
                    <div id="list" style="overflow-y:scroll;">
                        <table class="table" id="table-main">
                            <thead class="table-light">
                                <tr id="center">
                                    <th scope="col" style="width: 20%;">사원명</th>
                                    <th scope="col">내용</th>
                                </tr>
                            </thead>

                            <tbody id="tbd">
                                    <c:forEach items='${qaawList}' var='aw' >
                                        
                                        <c:set var="x" value="${status.count}"/>
                                        <c:if test="${aw.qacgNo eq x}">
                                            <tr>
                                                <th scope='row' id="aw-name">${aw.empName}</th>
                                                <th id="aw-content">${aw.qaawContent}</th>
                                            </tr>
                                        </c:if>
                                    </c:forEach>
                            </tbody>
                            <td colspan="2"></td>
                        </table>
                    </div>
                </div>
            </c:forEach>
                
            <!-- /답변내용 -->
        </div>
    </div>
        <!-- Button trigger modal -->
<button type="button" class="btn btn-primary" style="text-align: right;"  data-bs-toggle="modal" data-bs-target="#exampleModal">
    대상자 명단
    </button>
    
    <!-- Modal -->
    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
            <h1 class="modal-title fs-5" id="exampleModalLabel">대상자 명단</h1>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div id="notice">
                    <h2>대상자수 : ${fn:length(qaptList) }</h2>
                    <h9 class="text-subtitle text-muted">참여 인원수 : <span id="cg"></span></h9>
                    <h9 class="text-subtitle text-muted">참여율 :<span id="pt"></span></h9>
                    <div id="list" style="overflow:auto;">
                        <table class="table" id="table-main">
                            <thead class="table-light">
                                <tr id="center">
                                    <th scope="col" colspan="5">이름</th>
                                    <th scope="col">부서명</th>
                                    <th scope="col">참가여부</th>
                                </tr>
                            </thead>
    
    
                                <c:forEach items="${qaptList}" var="qa">
                                <tbody id="tbd">
                                    <tr >
                                        <th scope="col" colspan="5">${qa.empName}</th>
                                        <th scope="col">${qa.deptName}</th>
                                        <th scope="col">${qa.qaptStatus}</th>
                                    </tr>
                                </tbody>
                                </c:forEach>
                        </table>
                            
            </div></div></div>
            <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            
            </div>
        </div>
        </div>
    </div>
</div>



<script>
    var n =[];
    var nn = ${fn:length(qacgList) };
    for(var i =1; i<=nn; i++){
        n.push(i);
    }
    console.log("n::"+n);
    
    var x =${fn:length(qaptList) };
    console.log("x::"+x);
    var y = ${checkNum};
    console.log("y::"+y);
    console.log((y/x)*100);
    var av = ((y/x)*100).toFixed(1);
    document.getElementById('cg').innerHTML=y;
    document.getElementById('pt').innerHTML=av+"%";
</script>

<script>
    
    var cglength = ${fn:length(qacgList) };
    
    var cgname = document.querySelectorAll("label[for='cgName']");
    console.log("cg"+cgname);
    



</script>

<script>
    // String ext = ntatVo.getNtatChange().substring(ntatVo.getNtatChange().lastIndexOf("."));
    var x = '${qaatList.qaatChange}';
    var ext = x.substring(x.lastIndexOf("."));
    console.log("E"+ext); 
    
    function ig() {

        if(ext === '.jpg' || ext === '.png'){
            $('#fimg').append("<img src='${root}/resources/upload/QA/${qaatList.qaatChange}' id='p' alt='' width='200px' height='150px'>");
            ext="";
        }
        $('#p').toggle();

    }

    // <img src="${root}/resources/upload/QA/${qaatList.qaatChange}" alt="" width="300px" height="150px">
</script>