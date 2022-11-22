<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${root}/resources/css/sjy.css">
<style>
    .cic{
        
        height: 60vh;
        border-left: 1px dashed rgba(121, 121, 121, 0.555);
        
    }
</style>
<div id="content" style="height: 60vh;">
    <div class="dcontent" style="float: left; margin-left: 25%; ">
        <div class="mglt" style="margin-top: 30px;">

            <div class="md-3"> 
                <label for="title" class="form-label">예약자</label>
                <input type="text" class="form-control" id="title" name="title" value="로그인사원명" disabled>
            </div>

            <div class="md-3"> 
                <label for="title" class="form-label">분류</label>
                <div class="md-3 ">
                    <label for="campAdd" class="form-label">* 분류/자산명:</label> 
                    <select name="cls" class="form-select" id="cls" ></select> 
                    <select name="asset" class="form-select" id="asset"></select>
                </div>
            </div>
            
            <br>

            <div class="md-3"> 
                    
                <label for="title" class="form-label">예약 기간</label><br>
                <input type="date" class="form-control" id="title" name="title" style="width: auto; display: inline;">
                <input type="time" class="form-control"  style="width: auto; display: inline;">
                ~<br>
                <input type="date" class="form-control" id="title" name="title" style="width: auto; display: inline;">
                <input type="time" class="form-control"  style="width: auto; display: inline;">
            </div>

        </div>
    </div>
    

</div>

<script>	console.log("hi");
	$('document')
			.ready(
					function() {
						var area0 = [ "분류 선택", "회의실","전자","편의시설"  ];
						var area1 = [ "_층 a회의실","_층 b회의실","_층 c회의실", "_층 a회의실","_층 b회의실","_층 c회의실", "_층 a회의실","_층 b회의실","_층 c회의실", "_층 a회의실","_층 b회의실","_층 c회의실"];
						var area2 = ["_ _ _ 실 컴퓨터 a호", "_ _ _ 실 컴퓨터 b호", "_ _ _ 실 컴퓨터 c호", "_ _ _실 에어컨", "_ _ _실 ㅁㅁㅁ"];
						var area3 = [ ];
						var area4 = [ ];
						var area5 = [ ];
						var area6 = [  ];
						var area7 = [ ];
						var area8 = [  ];
						var area9 = [  ];
						var area10 = [  ];
						var area11 = [ ];
						var area12 = [  ];
						var area13 = [  ];
						var area14 = [  ];
						var area15 = [  ];
						var area16 = [  ];

						// 시/도 선택 박스 초기화

						$("select[name^=cls]")
								.each(
										function() {
											$selsido = $(this);
											$
													.each(
															eval(area0),
															function() {
																$selsido
																		.append("<option value='" + this + "'>"
																				+ this
																				+ "</option>");
															});
											 $selsido.next().append("<option value=''>자산명</option>");
										});

						// 시/도 선택시 구/군 설정

						$("select[name^=cls]")
								.change(
										function() {
											var area = "area"
													+ $("option", $(this))
															.index(
																	$(
																			"option:selected",
																			$(this))); // 선택지역의 구군 Array
											var $asset = $(this).next(); // 선택영역 군구 객체
											$("option", $asset).remove(); // 구군 초기화

											if (area == "area0")
												 $asset.append("<option value=''>자산명</option>"); 
											else {
												$
														.each(
																eval(area),
																function() {
																	$asset
																			.append("<option value='" + this + "'>"
																					+ this
																					+ "</option>");
																});
											}
										});

					});</script>