<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>ForWorks Admin</title>

    <link rel="stylesheet" href="${root}/resources/css/address/email.css" />
    <link rel="stylesheet" href="${root}/resources/css/address/style.css" />
    <script src="https://kit.fontawesome.com/3a92c85ff9.js" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <style>
      .star {
        visibility: hidden;
        cursor: pointer;
      }
      .star:before {
        content: "\f005";
        font-family: FontAwesome;
        color: #ccc;
        position: absolute;
        visibility: visible;
      }
      .star:checked:before {
        content: "\f005";
        color: #ffc107;
        font-family: FontAwesome;
        position: absolute;
      }
      
      .pagination span, .pagination button {
      	margin: 0 5px;
      }
      
      #member-table tbody > tr:hover {
      	background-color: #eeeeee;
      }
    </style>
  </head>
  <body>
    <div id="app">
      <%@ include file="/WEB-INF/views/admin/admin-sidebar.jsp" %>

      <div id="main" class="pt-0">
      	<%@ include file="/WEB-INF/views/admin/admin-header.jsp" %>
        <div class="page-heading">
          <div class="page-title">
            <div class="row">
              <div class="col-12 col-md-6 order-md-1 order-last">
                <h3>구성원 설정</h3>
                <p class="text-subtitle text-muted p-1">조직 구성원을 관리해보세요</p>
              </div>
              <div class="col-12 col-md-6 order-md-2 order-first p-4 pb-2">
                <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
                  <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${root}/foradmin/member/1">구성원 설정</a></li>
                    <li class="breadcrumb-item active" aria-current="page">구성원 승인</li>
                  </ol>
                </nav>
              </div>
            </div>
          </div>
          <section class="section">
            <div class="card">
              <div class="card-header">
                <h4 class="card-title mb-0">구성원 승인 요청</h4>
              </div>
              <div class="card-body" style="overflow:auto; min-height: 700px">
				<div class="content-right" style="width: 100%">
              <div class="email-app-area">
                <!-- Email list Area -->
                <div class="email-app-list-wrapper">
                    <div class="card">
                      <div class="card-body pt-2">
                        <table class="table" id="member-table">
                          <thead>
                            <tr>	
                              <th>신청번호</th>
                              <th>이름</th>
                              <th>주민번호</th>
                              <th>휴대전화</th>
                              <th></th>
                            </tr>
                          </thead>
                          <tbody>
                          <c:forEach items="${applyList}" var="l">
                          	<!-- <tr data-bs-toggle="modal" data-bs-target="#modalMemberEdit"> -->
                          	<tr id="apply${l.empNo}">
                              <td>${l.empNo}</td>
                              <td>${l.empName}</td>
                              <td>${l.empRegno}</td>
                              <td>${l.empPhone}</td>
                              <td style="display:none">${l.empExphone}</td>
                              <td>
                                <button type="button" class="btn btn-sm btn-success"
                                data-bs-toggle="modal" data-bs-target="#modalApprove"
                                role = "button" data-backdrop="static"
                                data-no="${l.empNo}" data-name="${l.empName}" data-exphone="${l.empExphone}"
                                >추가 정보 입력</button>
                                <button class="btn btn-sm btn-secondary" onclick="deleteMember(${l.empNo});">거절</button>
                              </td>
                            </tr>
                          </c:forEach>
                          </tbody>
                        </table>
                      </div>
                  </div>
                  </div>
              </div>
            </div>
			</div>
            </div>
          </section>
        </div>
      </div>
    </div>
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
    
    <!-- 구성원 정보입력 모달 -->
    <div class="modal fade" tabindex="-1" id="modalApprove" role="dialog">
	 <div class="modal-dialog modal-dialog-centered" role="document">
	   <div class="modal-content rounded-4 shadow">
	     <div class="modal-header p-5 pb-4 border-bottom-0">
	       <!-- <h1 class="modal-title fs-5" >Modal title</h1> -->
	        <h1 class="fw-bold mb-0 fs-2">구성원 정보 입력</h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	
	      <div class="modal-body p-5 pt-0">
	        <form action="${root}/foradmin/memberApprove" method="post">
	          <input name="empNo" type="hidden" id="emp_no"/>
	          <div class="form-floating mb-3">
	            <input type="text" class="form-control rounded-4" id="emp_name" disabled>
	            <label for="emp_name">성명</label>
	          </div>
	          <div class="form-floating mb-3">
	          	<select name="posNo" class="form-control rounded-4" id="emp_pos" required>
	          		<option value="">선택안함</option>
	          		<c:forEach items="${posList}" var="pl">
		            	<option value="${pl.posNo}">${pl.posName}</option>
	          		</c:forEach>
	            </select>
	            <label for="emp_pos">직급</label>
	          </div>
	          <div class="form-floating mb-3">
	            <select name="deptNo" class="form-control rounded-4" id="emp_dept" required>
	            	<option value="">선택안함</option>
	            	<c:forEach items="${deptList}" var="dl">
		            	<option value="${dl.deptNo}">${dl.deptName}</option>
	          		</c:forEach>
	            </select>
	            <label for="emp_dept">직무</label>
	          </div>
	          <div class="form-floating mb-3">
	            <input name="empMoney" value="" type="number" class="form-control rounded-4" id="emp_money" required>
	            <label for="emp_money">연봉</label>
	          </div>
	          <div class="form-floating mb-3">
	            <input name="empExphone" type="text" class="form-control rounded-4" id="emp_exphone">
	            <label for="emp_exphone">내선번호</label>
	          </div>
	          <div class="form-floating mb-3">
	            <input name="empJdate" type="date" class="form-control rounded-4" id="emp_date" required>
	            <label for="emp_date">입사일</label>
	          </div>
	          <button class="w-100 mb-2 btn btn-lg rounded-4 btn-secondary" type="submit">사원 등록하기</button>
	        </form>
	      </div>
	    </div>
	  </div>
	</div>
  </body>
  <script>
  	$("#modalApprove").on('show.bs.modal', function(e) {
  		var no = $(e.relatedTarget).data('no');
  		var name = $(e.relatedTarget).data('name');
  		var exphone = $(e.relatedTarget).data('exphone');
  		
  		document.getElementById("emp_no").value = no;
  		document.getElementById("emp_name").value = name;
  		document.getElementById("emp_exphone").value = exphone;
  	})
  	
  	function deleteMember(empNo) {
  		swal({
  		  title: "거절하시겠습니까?",
  		  text: "해당 구성원 정보가 삭제되며 되돌릴 수 없습니다.",
  		  icon: "warning",
  		  buttons: true,
  		  dangerMode: true,
  		})
  		.then((willDelete) => {
  		  if (willDelete) {
  			  
  			$.ajax({
  	          url: "${root}/foradmin/deleteApply",
  	          type: "post",
  	          data: {
  	            empNo: empNo,
  	          },
  	          success: function (data) {
  	        	console.log(data);
  	            if (data == 1) {
 	            	swal("승인을 거절하였습니다.", {
 	      		      icon: "success",
 	      		    });
 	            	$('#apply'+ empNo).remove();
  	            }
  	          },
  	          error: function (e) {
  	        	swal("접속 실패", {
  	  		      icon: "warning",
  	  		    });
  	          },
  	        });
  		  } else {
  		    swal("다시 승인을 진행해주세요.");
  		  }
  		});
  	}
  </script>
</html>
