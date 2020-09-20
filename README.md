# Welcome to The Projection Room!
More info coming soon!



Election data from [The Washington Post](https://www.washingtonpost.com/elections/election-results/2020-primary-results/).

Charts created using [Google Sheets](https://www.google.com/sheets/about/).

The [Computerized Real-time Accounting Program](https://github.com/zecellomaster/the-coverage-gasm/blob/master/CRAP.m) is a MATLAB script I designed myself.

If you find errors or have potential sugestions, please do not hesiate to let me know!

<!-- Begin 270towin.com 2020 Presidential Election Countdown Widget -->
<iframe src="https://www.270towin.com/2020-countdown-clock/widget300x200.php" width="300" height="215" border="0" frameBorder="0">
    Browser not supported. Visit <a href="https://www.270towin.com/">www.270towin.com</a>
</iframe>
<!-- End 270towin.com 2020 Presidential Election Countdown widget -->

<!--<meta http-equiv="refresh" content="360" />-->

<head>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawSeriesChart);
    
    function drawSeriesChart() {
    function drawGID() {
      var queryString = encodeURIComponent('SELECT A, B, C, D, E');

      var query = new google.visualization.Query(
          'https://docs.google.com/spreadsheets/d/1hmawmq3I3MzvqmMqS194_gTIROpyRmc-T_GMG-TVmj8/edit?usp=sharing' + queryString);
      var data = query.send(handleQueryResponse);
    }

    function handleQueryResponse(response) {
      if (response.isError()) {
        alert('Error in query: ' + response.getMessage() + ' ' + response.getDetailedMessage());
        return;
        }
        var stuff = response.getDataTable();
        return stuff
      }
      
      var options = {
        title: 'Correlation between life expectancy, fertility rate ' +
               'and population of some world countries (2010)',
        hAxis: {title: 'Life Expectancy'},
        vAxis: {title: 'Fertility Rate'},
        bubble: {textStyle: {fontSize: 11}}
      };
      
      var chart = new google.visualization.BubbleChart(document.getElementById('series_chart_div'));
      chart.draw(data, options);
    }
    </script>
  </head>
  <body>
    <div id="series_chart_div" style="width: 900px; height: 500px;"></div>
  </body>
