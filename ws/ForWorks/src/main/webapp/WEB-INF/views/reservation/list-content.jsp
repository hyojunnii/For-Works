<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
.wrapper {
    margin: 15px auto;
    /* max-width: 1100px; */
}

.container-calendar {
    background: #ffffff;
    padding: 15px;
    /* max-width: 475px; */
    margin: 0 auto;
    overflow: auto;
}

.button-container-calendar button {
    cursor: pointer;
    display: inline-block;
    zoom: 1;
    background: #00a2b7;
    color: #fff;
    border: 1px solid #0aa2b5;
    border-radius: 4px;
    padding: 5px 10px;
}

.table-calendar {
    border-collapse: collapse;
    width: 100%;
}

.table-calendar td, .table-calendar th {
    padding: 5px;
    border: 1px solid #e2e2e2;
    text-align: center;
    vertical-align: top;
}

.date-picker.selected {
    font-weight: bold;
    outline: 1px dashed #00BCD4;
}

.date-picker.selected span {
    border-bottom: 2px solid currentColor;
}

/* sunday */
.date-picker:nth-child(1) {
  color: red;
}

/* friday */
.date-picker:nth-child(6) {
  color: green;
}

#monthAndYear {
    text-align: center;
    margin-top: 0;
}

.button-container-calendar {
    position: relative;
    margin-bottom: 1em;
    overflow: hidden;
    clear: both;
}

#previous {
    float: left;
}

#next {
    float: right;
}

.footer-container-calendar {
    margin-top: 1em;
    border-top: 1px solid #dadada;
    padding: 10px 0;
}

.footer-container-calendar select {
    cursor: pointer;
    display: inline-block;
    zoom: 1;
    background: #ffffff;
    color: #585858;
    border: 1px solid #bfc5c5;
    border-radius: 3px;
    padding: 5px 1em;
}
.date-picker:hover{
    cursor: pointer;
}
</style>
<div class="wrapper">

<div class="container-calendar">
    <h3 id="monthAndYear"></h3>

    <div class="button-container-calendar">
        <button id="previous" onclick="previous()">&#8249;</button>
        <button id="next" onclick="next()">&#8250;</button>
    </div>

    <table class="table-calendar" id="calendar" data-lang="en">
        <thead id="thead-month"></thead>
        <tbody id="calendar-body"></tbody>
    </table>

    <div class="footer-container-calendar ">
        <label for="month">Jump To: </label>
        <select id="month" onchange="jump()">
            <option value=0>Jan</option>
            <option value=1>Feb</option>
            <option value=2>Mar</option>
            <option value=3>Apr</option>
            <option value=4>May</option>
            <option value=5>Jun</option>
            <option value=6>Jul</option>
            <option value=7>Aug</option>
            <option value=8>Sep</option>
            <option value=9>Oct</option>
            <option value=10>Nov</option>
            <option value=11>Dec</option>
        </select>
        <select id="year" onchange="jump()"></select>
    </div>

</div>
</div>


<!-- Modal -->
<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
    aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staticBackdropLabel">[시간 날짜]_예약 </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="md-3"> 
                    <label for="title" class="form-label">분류</label>
                    <div class="md-3 ">
                        <label for="campAdd" class="form-label">* 분류/자산명:</label> 
                        <select name="cls" class="form-select" id="cls" ></select> 
                        <select name="asset" class="form-select" id="asset"></select>
                    </div>

                    <label for="title" class="form-label">예약내용</label>
                    <div class="md-3 ">
                        
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>


<script>
    function generate_year_range(start, end) {
    var years = "";
    for (var year = start; year <= end; year++) {
        years += "<option value='" + year + "'>" + year + "</option>";
    }
    return years;
}

today = new Date();
currentMonth = today.getMonth();
currentYear = today.getFullYear();
selectYear = document.getElementById("year");
selectMonth = document.getElementById("month");


createYear = generate_year_range(1970, 2050);
/** or
 * createYear = generate_year_range( 1970, currentYear );
 */

document.getElementById("year").innerHTML = createYear;

var calendar = document.getElementById("calendar");
var lang = calendar.getAttribute('data-lang');

var months = "";
var days = "";

var monthDefault = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];

var dayDefault = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];

if (lang == "en") {
    months = monthDefault;
    days = dayDefault;
} else if (lang == "id") {
    months = ["Januari", "Februari", "Maret", "April", "Mei", "Juni", "Juli", "Agustus", "September", "Oktober", "November", "Desember"];
    days = ["Ming", "Sen", "Sel", "Rab", "Kam", "Jum", "Sab"];
} else if (lang == "fr") {
    months = ["Janvier", "Février", "Mars", "Avril", "Mai", "Juin", "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"];
    days = ["dimanche", "lundi", "mardi", "mercredi", "jeudi", "vendredi", "samedi"];
} else {
    months = monthDefault;
    days = dayDefault;
}


var $dataHead = "<tr>";
for (dhead in days) {
    $dataHead += "<th data-days='" + days[dhead] + "'>" + days[dhead] + "</th>";
}
$dataHead += "</tr>";

//alert($dataHead);
document.getElementById("thead-month").innerHTML = $dataHead;


monthAndYear = document.getElementById("monthAndYear");
showCalendar(currentMonth, currentYear);



function next() {
    currentYear = (currentMonth === 11) ? currentYear + 1 : currentYear;
    currentMonth = (currentMonth + 1) % 12;
    showCalendar(currentMonth, currentYear);
}

function previous() {
    currentYear = (currentMonth === 0) ? currentYear - 1 : currentYear;
    currentMonth = (currentMonth === 0) ? 11 : currentMonth - 1;
    showCalendar(currentMonth, currentYear);
}

function jump() {
    currentYear = parseInt(selectYear.value);
    currentMonth = parseInt(selectMonth.value);
    showCalendar(currentMonth, currentYear);
}

function showCalendar(month, year) {

    var firstDay = ( new Date( year, month ) ).getDay();

    tbl = document.getElementById("calendar-body");

    
    tbl.innerHTML = "";

    
    monthAndYear.innerHTML = months[month] + " " + year;
    selectYear.value = year;
    selectMonth.value = month;

    // creating all cells
    var date = 1;
    for ( var i = 0; i < 6; i++ ) {
        
        var row = document.createElement("tr");

        
        for ( var j = 0; j < 7; j++ ) {
            if ( i === 0 && j < firstDay ) {
                cell = document.createElement( "td" );
                cellText = document.createTextNode("");
                cell.appendChild(cellText);
                row.appendChild(cell);
            } else if (date > daysInMonth(month, year)) {
                break;
            } else {
                cell = document.createElement("td");
                cell.setAttribute("data-bs-toggle","modal");
                cell.setAttribute("data-bs-target","#staticBackdrop");
                cell.setAttribute("data-date", date);
                cell.setAttribute("data-month", month + 1);
                cell.setAttribute("data-year", year);
                cell.setAttribute("data-month_name", months[month]);
                cell.className = "date-picker";
                cell.innerHTML = "<span>" + date + "</span>";

                if ( date === today.getDate() && year === today.getFullYear() && month === today.getMonth() ) {
                    cell.className = "date-picker selected";
                }
                row.appendChild(cell);
                date++;
            }


        }

        tbl.appendChild(row);
    }

}

function daysInMonth(iMonth, iYear) {
    return 32 - new Date(iYear, iMonth, 32).getDate();
}
</script>

<script>	
    console.log("hi");
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
    
                        });
    </script>