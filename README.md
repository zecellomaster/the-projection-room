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

<script>  
        
    function drawGID() {
      var queryString = encodeURIComponent('SELECT A, H, O, Q, R, U LIMIT 5 OFFSET 8');

      var query = new google.visualization.Query(
          'https://docs.google.com/spreadsheets/d/1XWJLkAwch5GXAt_7zOFDcg8Wm8Xv29_8PWuuW15qmAE/gviz/tq?gid=0&headers=1&tq=' + queryString);
      query.send(handleQueryResponse);
    }

    function handleQueryResponse(response) {
      if (response.isError()) {
        alert('Error in query: ' + response.getMessage() + ' ' + response.getDetailedMessage());
        return;
      }

      var data = response.getDataTable();
      var chart = new google.visualization.ColumnChart(document.getElementById('chart_div'));
      chart.draw(data, { height: 400 });
    }
    
<script>  
    
    
