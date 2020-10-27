<html>  
  <head>
  <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js">
  google.charts.load('current', {
          'packages': ['corechart']
        });
        google.charts.setOnLoadCallback(drawBubbleChart);

        function drawBubbleChart() {

          var query = new google.visualization.Query('https://docs.google.com/spreadsheets/d/1DLtvZ9YqcIoV_mxNDHvvyTXpaycDfGqPYhaNhJEwe68/gviz/tq?gid=553196491');

          query.setQuery('SELECT A, C, D, B, F LIMIT 57 OFFSET 1');
          query.send(handleQueryResponse);

        }

        function handleQueryResponse(response) {

          if (response.isError()) {
            alert('Error in query: ' + response.getMessage() + ' ' + response.getDetailedMessage());
            return;
          }

          var data = response.getDataTable();

          var options = {
            title: "State Forecast",
            hAxis: {
              title: "Chance of Victory",
              maxValue: 1.25
            },
            vAxis: {
              title: "Points"
            },
            sizeAxis: {
                  title: "Biden"
            },
            colorAxis:{
                  title: "Margin of Victory (%)",
              colors: ['red', 'white', 'blue']
            },
            bubble: {
              textStyle: {
                fontSize: 11
              }
            }
          }

          //Alter chance to reflect on Joe Biden chance of victory
          for(var i = 0; i < 56; i++){
                  var chance = data.getValue(i, 1);
                  if(chance < 0.5){
                  data.setValue(i, 1, 1 - chance);
            }
          }

          var chart = new google.visualization.BubbleChart(document.getElementById('series_chart_div'));
          chart.draw(data, options);

        }
  </script>
  </head>
  <body>
    <div id="series_chart_div" style="width: 900px; height: 500px;"></div>
  </body>
</html>
