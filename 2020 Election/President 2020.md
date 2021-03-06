---
theme: jekyll-theme-cayman
title: "2020 Presidential Forecast"
permalink: /president-2020/
---

<meta name="twitter:card" content="summary">
<meta property="og:image" content="https://raw.githubusercontent.com/zecellomaster/the-projection-room/master/websitefavicon3.png">

[<<Back to Home Page<<](https://theprforecast.com/)

# 2020 Presidential Election Forecast
Hi there! This is the archived page of our 2020 election forecast. [Click here](https://zecellomaster.github.io/the-projection-room/) to go back to the main page.

**Update (11/14/20)**: The final calls have been made by all major networks, and it appears Joesph R. Biden Jr. [has won the electoral college 306-232](https://www.nytimes.com/interactive/2020/11/03/us/elections/results-president.html?action=click&pgtype=Article&state=default&module=styln-elections-2020&region=TOP_BANNER&context=election_recirc), a margin of 74 votes. Ironically, this is the same result as Donald J. Trump's 2016 victory over Hillary R. Clinton (if the faithless electors are discarded). The state calls are enough to do some preliminary analysis (which will come eventually), but the overal vote count will still take time, so a more in-depth look about where the model failed and succeeded will be a bit longer down the road.

As for what is next, [both of Georgia's senate seats are going into runoffs](https://www.nytimes.com/2020/11/14/us/politics/georgia-runoffs-senate-control.html) that will occur early next year and this site will attempt to forecast (perhaps even live forecast) those races. A lot is still to come, so stay tuned!

*Note: This model has been locked since 11/03. On that day, I wrote about what it was forecasting. You can still find that article [here](https://docs.google.com/document/d/1V6jIQTXFkJLPBknkXslr5KtGvBdZ2AzCw2xey2JpaTo/edit?usp=sharing)*.

Before we dive in, is important to note a couple of things:

1) This forecast is based a lot on polling data, and while better quality polls are weighted more than worse ones, it is still subject to pollster error and is only a snapshot in time.

2) It is important to note the fact that as with most numerical predictions, this only tells the *likelihood* of an event and therefore not a guarentee of what is **going** to happen.

3) The model assumes an election where all the votes cast are counted and the election overall is run fairly. Recent [events](https://ballotpedia.org/Changes_to_election_dates,_procedures,_and_administration_in_response_to_the_coronavirus_(COVID-19)_pandemic,_2020), [comments](https://www.vox.com/policy-and-politics/2020/9/30/21454325/trump-2020-peaceful-transition-election-stealing), and [actions](https://fivethirtyeight.com/features/five-ways-trump-and-gop-officials-are-undermining-the-election-process/) have cast some doubt on whether or not that will happen this year or at least to the extent it did in past elections, so uncertainty may be more than expected.

## Presidential Election Forecast
### Forecasted Chance of Winning
<iframe width="600" height="212" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vQT7zI2PyREKcBTf5CJflh-Y0O-B_E0DExA0AQJICXH9gMMJia4ugx6LezMPtNZ3qWxozhOZFA_zbL6/pubchart?oid=1003958298&amp;format=interactive"></iframe>
This tells the *probability* that a candidate will win the election via the electoral college. The higher the chance, the more pathways that candidate has to 270. If no candidate reaches 270 electoral votes, a much more [complicated process is used to choose the president](https://www.270towin.com/content/electoral-college-ties/).

### Chance of Winning Over Time
<iframe width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vQT7zI2PyREKcBTf5CJflh-Y0O-B_E0DExA0AQJICXH9gMMJia4ugx6LezMPtNZ3qWxozhOZFA_zbL6/pubchart?oid=1593274173&amp;format=interactive"></iframe>
This shows how the chances of winning have modified over time.

### Electoral College Map
<iframe width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vRsb4OQeyJBX2P0Od5zN1-S6EGaB4ChjwERt_hbjkp9ck_4XTCZx_SgDzaDxgietocK2hPAtlgFdS6d/pubchart?oid=2086820880&amp;format=interactive"></iframe>
The percent values represent the chance of victory for the incumbent, Donald J. Trump. Red indicates the *likelihood* of a Trump win while blue indicates a *likelihood* of a Biden win. The darker the shade, the higher the chance, with white being a 50%-50% tossup

### A Different Perspective
<html>
        <head></head>
        <body>
                <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
                <script type="text/javascript">
        
        google.charts.load('current', {'packages': ['corechart']});

              function drawBubbleChart() {

                var query = new google.visualization.Query('https://docs.google.com/spreadsheets/d/1DLtvZ9YqcIoV_mxNDHvvyTXpaycDfGqPYhaNhJEwe68/gviz/tq?gid=553196491');

                query.setQuery('SELECT A, D, C, B, F LIMIT 57 OFFSET 1');
                query.send(handleQueryResponse);

              }

              function handleQueryResponse(response) {

                if (response.isError()) {
                  alert('Error in query: ' + response.getMessage() + ' ' + response.getDetailedMessage());
                  return;
                }

                var data = response.getDataTable();

                var options = {
                  title: " ",
                  hAxis: {
                    title: "Margin of Victory (%)",
                    //maxValue: 1.25
                  },
                  vAxis: {
                    title: "Chance of Victory",
                    format: 'percent',
                    maxValue: 1.1,
                    minValue: 0.45
                  },
                  sizeAxis: {
                        maxSize: 50,
                        title: "Biden"
                  },
                  colorAxis:{
                        title: "Margin of Victory (%)",
                    colors: ['red', 'white', 'blue']
                  },
                  bubble: {
                    textStyle: {
                      fontSize: 15
                    }
                  }
                }

                //Alter chance to reflect on Joe Biden chance of victory
                for(var i = 0; i < 56; i++){
                        var chance = data.getValue(i, 2);
                        if(chance < 0.5){
                        data.setValue(i, 2, 1 - chance);
                  }
                }

                var chart = new google.visualization.BubbleChart(document.getElementById('series_chart_div'));
                chart.draw(data, options);

              }
              google.charts.setOnLoadCallback(drawBubbleChart);
        </script>
        <div id="series_chart_div" style="width: 900px; height: 500px;"></div>
        </body>
</html>

<i>Visual developed by Brandon Wilson ([@KnightLizard](https://github.com/KnightLizard)) - Computer Science Undergraduate</i>

This view shows all the races with the sizes representing the number of electoral votes they have, the horizontal axis representing the margin of victory (negative for Biden, positive for Trump), and the color/vertical axis representing who has the better odds of winning there (red for Trump, blue for Biden). The darker the shade, the higher the chance.

### Electoral Votes Over Time
<iframe width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vQT7zI2PyREKcBTf5CJflh-Y0O-B_E0DExA0AQJICXH9gMMJia4ugx6LezMPtNZ3qWxozhOZFA_zbL6/pubchart?oid=993494504&amp;format=interactive"></iframe>
A look at how the range of forecasted electoral votes have changed over the course of time. Dotted lines represent the 90% confidence interval for each candidate. Remember, 270 votes are required to win.

### Spread of Electoral Votes
<iframe width="753" height="505" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vQT7zI2PyREKcBTf5CJflh-Y0O-B_E0DExA0AQJICXH9gMMJia4ugx6LezMPtNZ3qWxozhOZFA_zbL6/pubchart?oid=1793068855&amp;format=interactive"></iframe>
The spread of the electoral votes for the winner in all of the 40,000 simulations done to make this forecast.

### Forecasted Vote Share
<iframe width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vQT7zI2PyREKcBTf5CJflh-Y0O-B_E0DExA0AQJICXH9gMMJia4ugx6LezMPtNZ3qWxozhOZFA_zbL6/pubchart?oid=1119499338&amp;format=interactive"></iframe>
This is a look at what the vote share could look like on election day using historical data and polling averages.

### Popular Vote Over Time
<iframe width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vQT7zI2PyREKcBTf5CJflh-Y0O-B_E0DExA0AQJICXH9gMMJia4ugx6LezMPtNZ3qWxozhOZFA_zbL6/pubchart?oid=687436770&amp;format=interactive"></iframe>
A look at how the range of the forecasted vote share has changed over the course of time. Dotted lines represent the 90% confidence interval for each candidate.

### Battleground Races
These are the races that are either the most interesting or most likely to get interesting 

[Arizona](https://zecellomaster.github.io/the-projection-room/president-2020/arizona/) | [Colorado](https://zecellomaster.github.io/the-projection-room/president-2020/colorado/) |
[Florida](https://zecellomaster.github.io/the-projection-room/president-2020/florida/) | [Georgia](https://zecellomaster.github.io/the-projection-room/president-2020/georgia/) |
[Iowa](https://zecellomaster.github.io/the-projection-room/president-2020/iowa/) | [Maine (Statewide)](https://zecellomaster.github.io/the-projection-room/president-2020/maine/) |
[Michigan](https://zecellomaster.github.io/the-projection-room/president-2020/michigan/) | [Minnesota](https://zecellomaster.github.io/the-projection-room/president-2020/minnesota/) |
[Nevada](https://zecellomaster.github.io/the-projection-room/president-2020/nevada/) | [New Hampshire](https://zecellomaster.github.io/the-projection-room/president-2020/new-hampshire/) |
[New Mexico](https://zecellomaster.github.io/the-projection-room/president-2020/new-mexico/) | [North Carolina](https://zecellomaster.github.io/the-projection-room/president-2020/north-carolina/) |
[Ohio](https://zecellomaster.github.io/the-projection-room/president-2020/ohio/) | [Pennsylvania](https://zecellomaster.github.io/the-projection-room/president-2020/pennsylvania/) |
[Texas](https://zecellomaster.github.io/the-projection-room/president-2020/texas/) | [Wisconsin](https://zecellomaster.github.io/the-projection-room/president-2020/wisconsin/) |
[Maine CD-2](https://zecellomaster.github.io/the-projection-room/president-2020/maine-cd-2/) | [Nebraska CD-2](https://zecellomaster.github.io/the-projection-room/president-2020/nebraska-cd-2/)


### Tipping Point
<iframe width="500" height="371" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vQT7zI2PyREKcBTf5CJflh-Y0O-B_E0DExA0AQJICXH9gMMJia4ugx6LezMPtNZ3qWxozhOZFA_zbL6/pubhtml?gid=1871926673&amp;single=true&amp;widget=true&amp;headers=false"></iframe>
The tipping point is defined as the state that gets the eventual winner their 270th electoral vote. Here is a list of the races that are most likely to do just that, along with the forecasted margins of victory (negative if Biden leads, positive if Trump leads). Note that Nebraska and Maine use a [slightly different system](https://www.270towin.com/content/split-electoral-votes-maine-and-nebraska/) to allocate electors than winner-take-all, so the statewide vote for both is denoted with a (S) while the congressional districts are labeled individually.


### Big Board
<iframe width="500" height="371" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vRsb4OQeyJBX2P0Od5zN1-S6EGaB4ChjwERt_hbjkp9ck_4XTCZx_SgDzaDxgietocK2hPAtlgFdS6d/pubhtml?gid=160042951&amp;single=true&amp;widget=true&amp;headers=false"></iframe>
Highlighted bold states are battleground races. Note that the margin of victory is negative if Biden leads and positive if Trump leads. Nebraska and Maine use a [slightly different system](https://www.270towin.com/content/split-electoral-votes-maine-and-nebraska/) to allocate electors than winner-take-all, so the statewide vote for both is denoted with a (S) while the congressional districts are labeled individually.

### All Races
[Alabama](https://zecellomaster.github.io/the-projection-room/president-2020/alabama/)                           | [Alaska](https://zecellomaster.github.io/the-projection-room/president-2020/alaska/)                 |
[Arizona](https://zecellomaster.github.io/the-projection-room/president-2020/arizona/)                           | [Arkansas](https://zecellomaster.github.io/the-projection-room/president-2020/arkansas/)             |
[California](https://zecellomaster.github.io/the-projection-room/president-2020/california/)                     | [Colorado](https://zecellomaster.github.io/the-projection-room/president-2020/colorado/)             |
[Connecticut](https://zecellomaster.github.io/the-projection-room/president-2020/connecticut/)                   | [Delaware](https://zecellomaster.github.io/the-projection-room/president-2020/delaware/)             |
[District of Columbia](https://zecellomaster.github.io/the-projection-room/president-2020/district-of-columbia/) | [Florida](https://zecellomaster.github.io/the-projection-room/president-2020/florida/)               |
[Georgia](https://zecellomaster.github.io/the-projection-room/president-2020/georgia/)                           | [Hawaii](https://zecellomaster.github.io/the-projection-room/president-2020/hawaii/)                 |
[Idaho](https://zecellomaster.github.io/the-projection-room/president-2020/idaho/)                               | [Illinois](https://zecellomaster.github.io/the-projection-room/president-2020/illinois/)             |
[Indiana](https://zecellomaster.github.io/the-projection-room/president-2020/indiana/)                           | [Iowa](https://zecellomaster.github.io/the-projection-room/president-2020/iowa/)                     |
[Kansas](https://zecellomaster.github.io/the-projection-room/president-2020/kansas/)                             | [Kentucky](https://zecellomaster.github.io/the-projection-room/president-2020/kentucky/)             |
[Louisiana](https://zecellomaster.github.io/the-projection-room/president-2020/louisiana/)                       | [Maine (Statewide)](https://zecellomaster.github.io/the-projection-room/president-2020/maine/)       |
[Maryland](https://zecellomaster.github.io/the-projection-room/president-2020/maryland/)                         | [Massachusetts](https://zecellomaster.github.io/the-projection-room/massachusetts/)   |
[Michigan](https://zecellomaster.github.io/the-projection-room/president-2020/michigan/)                         | [Minnesota](https://zecellomaster.github.io/the-projection-room/president-2020/minnesota/)           |
[Mississippi](https://zecellomaster.github.io/the-projection-room/president-2020/mississippi/)                   | [Missouri](https://zecellomaster.github.io/the-projection-room/president-2020/missouri/)             |
[Montana](https://zecellomaster.github.io/the-projection-room/president-2020/montana/)                           | [Nebraska (Statewide)](https://zecellomaster.github.io/the-projection-room/president-2020/nebraska/) |
[Nevada](https://zecellomaster.github.io/the-projection-room/president-2020/nevada/)                             | [New Hampshire](https://zecellomaster.github.io/the-projection-room/president-2020/new-hampshire/)   |
[New Jersey](https://zecellomaster.github.io/the-projection-room/president-2020/new-jersey/)                     | [New Mexico](https://zecellomaster.github.io/the-projection-room/new-mexico/)         |
[New York](https://zecellomaster.github.io/the-projection-room/president-2020/new-york)                          | [North Carolina](https://zecellomaster.github.io/the-projection-room/north-carolina/) |
[North Dakota](https://zecellomaster.github.io/the-projection-room/president-2020/north-dakota/)                 | [Ohio](https://zecellomaster.github.io/the-projection-room/president-2020/ohio/)                     |
[Oklahoma](https://zecellomaster.github.io/the-projection-room/president-2020/oklahoma/)                         | [Oregon](https://zecellomaster.github.io/the-projection-room/president-2020/oregon/)                 |
[Pennsylvania](https://zecellomaster.github.io/the-projection-room/president-2020/pennsylvania/)                 | [Rhode Island](https://zecellomaster.github.io/the-projection-room/president-2020/rhode-island/)     |
[South Carolina](https://zecellomaster.github.io/the-projection-room/president-2020/south-carolina/)             | [South Dakota](https://zecellomaster.github.io/the-projection-room/president-2020/south-dakota/)     |
[Tennessee](https://zecellomaster.github.io/the-projection-room/president-2020/tennessee/)                       | [Texas](https://zecellomaster.github.io/the-projection-room/president-2020/texas/)                   |
[Utah](https://zecellomaster.github.io/the-projection-room/president-2020/utah/)                                 | [Vermont](https://zecellomaster.github.io/the-projection-room/president-2020/vermont/)               |
[Virginia](https://zecellomaster.github.io/the-projection-room/president-2020/virginia/)                         | [Washington](https://zecellomaster.github.io/the-projection-room/president-2020/washington/)         |
[West Virginia](https://zecellomaster.github.io/the-projection-room/president-2020/west-virginia/)               | [Wisconsin](https://zecellomaster.github.io/the-projection-room/president-2020/wisconsin/)           |
[Wyoming](https://zecellomaster.github.io/the-projection-room/president-2020/wyoming/)                           | [Maine CD-1](https://zecellomaster.github.io/the-projection-room/president-2020/maine-cd-1/)         |
[Maine CD-2](https://zecellomaster.github.io/the-projection-room/president-2020/maine-cd-2/)                     | [Nebraska CD-1](https://zecellomaster.github.io/the-projection-room/president-2020/nebraska-cd-1/)   |
[Nebraska CD-2](https://zecellomaster.github.io/the-projection-room/president-2020/nebraska-cd-2/)               | [Nebraska CD-3](https://zecellomaster.github.io/the-projection-room/president-2020/nebraska-cd-3/)   |



Polling data from [538.com](https://projects.fivethirtyeight.com/polls/?ex_cid=irpromo).

Charts created using [Google Sheets](https://www.google.com/sheets/about/) and [Google Visualization API](https://developers.google.com/chart/interactive/docs/reference)

The [Pre-Election Estimation System](https://github.com/zecellomaster/the-projection-room/tree/master/Scripts) is powered by a group of MATLAB scripts.

All data presented can be found on the [official online repository](https://drive.google.com/drive/folders/1kHx-x_HtC0uqQKqF8HZOrfzr62zd8wP6?usp=sharing).

Page built by: [@zecellomaster](https://github.com/zecellomaster)  [@KnightLizard](https://github.com/KnightLizard)

Found any errors? Want to make a suggestion? Have any comments? Email us: [theprojectionroomdata@gmail.com](mailto:theprojectionroomdata@gmail.com)

<!-- Begin 270towin.com 2020 Presidential Election Countdown Widget -->
<iframe src="https://www.270towin.com/2020-countdown-clock/widget300x200.php" width="300" height="215" border="0" frameBorder="0">
    Browser not supported. Visit <a href="https://www.270towin.com/">www.270towin.com</a>
</iframe>
<!-- End 270towin.com 2020 Presidential Election Countdown widget -->

<!--<meta http-equiv="refresh" content="600" />-->
