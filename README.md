# Welcome!

Before we dive in, is important to note a couple of things:

1) This forecast is based a lot on polling data, and while better quality polls are weighted more than worse ones, it is still subject to pollster error and is only a snapshot in time.

2) It is important to note the fact that as with most numerical predictions, this only tells the *likelihood* of an event and therefore not a guarentee of what is **going** to happen.

3) The model assumes an election where all the votes cast are counted and the election overall is run fairly. Recent [events](https://ballotpedia.org/Changes_to_election_dates,_procedures,_and_administration_in_response_to_the_coronavirus_(COVID-19)_pandemic,_2020), [comments](https://www.vox.com/policy-and-politics/2020/9/30/21454325/trump-2020-peaceful-transition-election-stealing), and [actions](https://fivethirtyeight.com/features/five-ways-trump-and-gop-officials-are-undermining-the-election-process/) have cast some doubt on whether or not that will happen this year or at least to the extent it did in past elections, so uncertainty may be more than expected.

**Update (10/31/20)**: Happy Halloween all! TL;DR: Updated the way the odds, electoral votes, and tipping point percents were calculated.

I've updated the percent chance of winning using a system adopted from [Sam Minter](http://www.abulsme.com/) over on [ElectionGraphs.com](https://electiongraphs.com/). The previous chance estimator used a "top down system", where a national result was simulated with a Gaussian distribution and applied to each of the states using their [538 elasticity rating](https://twitter.com/NateSilver538/status/1272618296571985920?s=20). While it allowed for more variance in the national results, it also resulted in basically impossible state level ones (for example, Trump winning California or Biden winning Oklahoma). Moreover, it seems a bit incompatible with the mean electoral vote lead Biden had leveraged (~150).

The opposite is a "bottom up" system, where the individual state chances are put through a uniform distribution sim, then the electoral votes are added up to determine the winner. The problem is that this causes the results to be completely detached from each other, so a win for a candidate in one state would not correlate to an increased chance for them in a demographically similar state. This method resulted in Biden winning >99% of the time, as the states he leads in have far more electoral votes than those he is not. This also seemed a little too unreasonable.

The solution? Average values produced by both methods to get a little bit of both worlds, some connection to the national environment, yet some independence for each state. This shifts Biden's odds of victory from 77.5% -> 88.8%. 

Keep in mind that none of this guareentees a Biden win/Trump loss. It only emphasizes the fact that Biden seems to have more pathways to the White House than Trump does to reelection.

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

[Arizona](https://theprforecast.com/arizona/) | [Colorado](https://theprforecast.com/colorado/) |
[Florida](https://theprforecast.com/florida/) | [Georgia](https://theprforecast.com/georgia/) |
[Iowa](https://theprforecast.com/iowa/) | [Maine (Statewide)](https://theprforecast.com/maine/) |
[Michigan](https://theprforecast.com/michigan/) | [Minnesota](https://theprforecast.com/minnesota/) |
[Nevada](https://theprforecast.com/nevada/) | [New Hampshire](https://theprforecast.com/new-hampshire/) |
[New Mexico](https://theprforecast.com/new-mexico/) | [North Carolina](https://theprforecast.com/north-carolina/) |
[Ohio](https://theprforecast.com/ohio/) | [Pennsylvania](https://theprforecast.com/pennsylvania/) |
[Texas](https://theprforecast.com/texas/) | [Wisconsin](https://theprforecast.com/wisconsin/) | 
[Maine CD-2](https://theprforecast.com/maine-cd-2/) | [Nebraska CD-2](https://theprforecast.com/nebraska-cd-2/)

### Tipping Point
<iframe width="500" height="371" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vQT7zI2PyREKcBTf5CJflh-Y0O-B_E0DExA0AQJICXH9gMMJia4ugx6LezMPtNZ3qWxozhOZFA_zbL6/pubhtml?gid=1871926673&amp;single=true&amp;widget=true&amp;headers=false"></iframe>
The tipping point is defined as the state that gets the eventual winner their 270th electoral vote. Here is a list of the races that are most likely to do just that, along with the forecasted margins of victory (negative if Biden leads, positive if Trump leads). Note that Nebraska and Maine use a [slightly different system](https://www.270towin.com/content/split-electoral-votes-maine-and-nebraska/) to allocate electors than winner-take-all, so the statewide vote for both is denoted with a (S) while the congressional districts are labeled individually.


### Big Board
<iframe width="500" height="371" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vRsb4OQeyJBX2P0Od5zN1-S6EGaB4ChjwERt_hbjkp9ck_4XTCZx_SgDzaDxgietocK2hPAtlgFdS6d/pubhtml?gid=160042951&amp;single=true&amp;widget=true&amp;headers=false"></iframe>
Highlighted bold states are battleground races. Note that the margin of victory is negative if Biden leads and positive if Trump leads. Nebraska and Maine use a [slightly different system](https://www.270towin.com/content/split-electoral-votes-maine-and-nebraska/) to allocate electors than winner-take-all, so the statewide vote for both is denoted with a (S) while the congressional districts are labeled individually.

### All Races
[Alabama](https://theprforecast.com/alabama/)                           | [Alaska](https://theprforecast.com/alaska/)                 |
[Arizona](https://theprforecast.com/arizona/)                           | [Arkansas](https://theprforecast.com/arkansas/)             |
[California](https://theprforecast.com/california/)                     | [Colorado](https://theprforecast.com/colorado/)             |
[Connecticut](https://theprforecast.com/connecticut/)                   | [Delaware](https://theprforecast.com/delaware/)             |
[District of Columbia](https://theprforecast.com/district-of-columbia/) | [Florida](https://theprforecast.com/florida/)               |
[Georgia](https://theprforecast.com/georgia/)                           | [Hawaii](https://theprforecast.com/hawaii/)                 |
[Idaho](https://theprforecast.com/idaho/)                               | [Illinois](https://theprforecast.com/illinois/)             |
[Indiana](https://theprforecast.com/indiana/)                           | [Iowa](https://theprforecast.com/iowa/)                     |
[Kansas](https://theprforecast.com/kansas/)                             | [Kentucky](https://theprforecast.com/kentucky/)             |
[Louisiana](https://theprforecast.com/louisiana/)                       | [Maine (Statewide)](https://theprforecast.com/maine/)       |
[Maryland](https://theprforecast.com/maryland/)                         | [Massachusetts](https://theprforecast.com/massachusetts/)   |
[Michigan](https://theprforecast.com/michigan/)                         | [Minnesota](https://theprforecast.com/minnesota/)           |
[Mississippi](https://theprforecast.com/mississippi/)                   | [Missouri](https://theprforecast.com/missouri/)             |
[Montana](https://theprforecast.com/montana/)                           | [Nebraska (Statewide)](https://theprforecast.com/nebraska/) |
[Nevada](https://theprforecast.com/nevada/)                             | [New Hampshire](https://theprforecast.com/new-hampshire/)   |
[New Jersey](https://theprforecast.com/new-jersey/)                     | [New Mexico](https://theprforecast.com/new-mexico/)         |
[New York](https://theprforecast.com/new-york)                          | [North Carolina](https://theprforecast.com/north-carolina/) |
[North Dakota](https://theprforecast.com/north-dakota/)                 | [Ohio](https://theprforecast.com/ohio/)                     |
[Oklahoma](https://theprforecast.com/oklahoma/)                         | [Oregon](https://theprforecast.com/oregon/)                 |
[Pennsylvania](https://theprforecast.com/pennsylvania/)                 | [Rhode Island](https://theprforecast.com/rhode-island/)     |
[South Carolina](https://theprforecast.com/south-carolina/)             | [South Dakota](https://theprforecast.com/south-dakota/)     |
[Tennessee](https://theprforecast.com/tennessee/)                       | [Texas](https://theprforecast.com/texas/)                   |
[Utah](https://theprforecast.com/utah/)                                 | [Vermont](https://theprforecast.com/vermont/)               |
[Virginia](https://theprforecast.com/virginia/)                         | [Washington](https://theprforecast.com/washington/)         |
[West Virginia](https://theprforecast.com/west-virginia/)               | [Wisconsin](https://theprforecast.com/wisconsin/)           |
[Wyoming](https://theprforecast.com/wyoming/)                           | [Maine CD-1](https://theprforecast.com/maine-cd-1/)         |
[Maine CD-2](https://theprforecast.com/maine-cd-2/)                     | [Nebraska CD-1](https://theprforecast.com/nebraska-cd-1/)   |
[Nebraska CD-2](https://theprforecast.com/nebraska-cd-2/)               | [Nebraska CD-3](https://theprforecast.com/nebraska-cd-3/)   |

## Senate Forecast
Coming Soon!

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
