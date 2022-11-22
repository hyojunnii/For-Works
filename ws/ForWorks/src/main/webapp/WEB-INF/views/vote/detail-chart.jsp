<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">

     

      google.charts.load("current", {packages:["corechart"]});
      google.charts.setOnLoadCallback(drawChart);
      function drawChart() {
        var data2 = [];
        data2.push(['항목이름', '득표수']);
        for (var i = 0; i < cglength; i++) {
          var temp = [];
          console.log("항목 :: "+cgname[i].textContent);
          console.log("투표수  ::"+cnt[i].textContent);
          temp.push(cgname[i].textContent);
          temp.push(Number(cnt[i].textContent));

          data2.push(temp);
          console.log(data2[i]); 
        }
        data2.push(['불참', x-y]);
        console.log(data2);
        // console.log(data2[0]);
        // console.log((data2)[0][0]);
        // console.log((data2)[0][1]);

        var ds = [];
        
        var data = google.visualization.arrayToDataTable(
          data2
          //[
          // ['항목이름', '득표수'],
          // //투표 항목들 
          
          // (data2)[0], == ['투표1 ㅎ1', 2],
          // (data2)[1], == ['투표1 ㅎ2', 3],
          // (data2)[2], == ['투표1 ㅎ3', 5],
          
          // //투표 항목들 
          // ['불참',    x-y]
          //]
        );

        

        var options = {
          title: '투표현황',
          is3D: true,
        };

        
        var chart = new google.visualization.PieChart(document.getElementById('piechart_3d'));
        chart.draw(data, options);
      }
    </script>


    <div id="piechart_3d" style="width: 900px; height: 500px;"></div>

