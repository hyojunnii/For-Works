<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    

    <script type="text/javascript">
      google.charts.load('current', {'packages':['bar']});
      google.charts.setOnLoadCallback(drawStuff);
      
      function drawStuff() {
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
        
        console.log(data2);

        var data = new google.visualization.arrayToDataTable(data2);

        var options = {
          title: 'Chess opening moves',
          
          legend: { position: 'none' },
          chart: { title: '투표현황',
                  // subtitle: 'popularity by percentage' 
                },
          bars: 'horizontal', // Required for Material Bar Charts.
          axes: {
            x: {
              0: { side: 'top', label: '득표수'} // Top x-axis.
            }
          },
          bar: { groupWidth: "90%" }
        };

        var chart = new google.charts.Bar(document.getElementById('top_x_div'));
        chart.draw(data, options);
      };
    </script>
 <div id="top_x_div" style="width: 900px; height: 300px;"></div>
 <c:forEach items="${vtcgList}" var="cg">
   <span id="cgCnt" style="visibility: hidden;">${cg.vtcgCnt}</span>
 </c:forEach>
 