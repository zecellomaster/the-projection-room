# Welcome to The Projection Room!

After much delay, the forecast is finally ready! Before we dive in, however, is important to note a couple of things:

1) This forecast is based a lot on polling data, and while better quality polls are weighted more than worse ones, it is still subject to pollster error and is only a snapshot in time.

2) It is important to note the fact that as with most numerical predictions, this only tells the *likelihood* of an event and therefore not a guarentee of what is **going** to happen.

3) The model assumes an election where all the votes cast are counted and the election overall is run fairly. Recent [events](https://ballotpedia.org/Changes_to_election_dates,_procedures,_and_administration_in_response_to_the_coronavirus_(COVID-19)_pandemic,_2020), [comments](https://www.vox.com/policy-and-politics/2020/9/30/21454325/trump-2020-peaceful-transition-election-stealing), and [actions](https://fivethirtyeight.com/features/five-ways-trump-and-gop-officials-are-undermining-the-election-process/) have cast some doubt on whether or not that will happen this year or at least to the extent it did in past elections, so uncertainty may be more than expected.

**Update (10/25/20)**: The election is ~8 days away and the website is at 65% completeness, but most of the major things I want to implement are here. The issue at the moment is Florida, the model shows about an 80% chance for Biden, but it has a [glaring lack of high quality (B+ or higher) polls taken recently](https://projects.fivethirtyeight.com/polls/president-general/florida/). The model is instructed to ignore low quality polls for higher ones, even if they are older, but only for a short time, after which a dropoff causes the weight to decrease faster. We might see this one get much closer, which will certainly have major implications for the election, unless a good poll is taken recently that shows the margin holding steady for Biden.

## Presidential Election Forecast
### Forecasted Chance of Winning
<iframe width="600" height="212" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vQT7zI2PyREKcBTf5CJflh-Y0O-B_E0DExA0AQJICXH9gMMJia4ugx6LezMPtNZ3qWxozhOZFA_zbL6/pubchart?oid=1003958298&amp;format=interactive"></iframe>
This tells the *probability* that a candidate will win the election via the electoral college. The higher the chance, the more pathways that candidate has to 270.

### Chance of Winning Over Time
<iframe width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vQT7zI2PyREKcBTf5CJflh-Y0O-B_E0DExA0AQJICXH9gMMJia4ugx6LezMPtNZ3qWxozhOZFA_zbL6/pubchart?oid=1593274173&amp;format=interactive"></iframe>
This shows how the chances of winning have modified over time.

### Electoral College Map
<iframe width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vRsb4OQeyJBX2P0Od5zN1-S6EGaB4ChjwERt_hbjkp9ck_4XTCZx_SgDzaDxgietocK2hPAtlgFdS6d/pubchart?oid=2086820880&amp;format=interactive"></iframe>
The percent values represent the chance of victory for the incumbent, Donald J. Trump. Red indicates the *likelihood* of a Trump win while blue indicates a *likelihood* of a Biden win. The darker the shade, the higher the chance, with white being a 50%-50% tossup

### Electoral Votes Over Time
<iframe width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vQT7zI2PyREKcBTf5CJflh-Y0O-B_E0DExA0AQJICXH9gMMJia4ugx6LezMPtNZ3qWxozhOZFA_zbL6/pubchart?oid=993494504&amp;format=interactive"></iframe>
A look at how the range of forecasted electoral votes have changed over the course of time. Remember, 270 votes are required to win. A 269-269 tie results in a much more [complicated process to choose the president](https://www.270towin.com/content/electoral-college-ties/).

### Forecasted Vote Share
<iframe width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vQT7zI2PyREKcBTf5CJflh-Y0O-B_E0DExA0AQJICXH9gMMJia4ugx6LezMPtNZ3qWxozhOZFA_zbL6/pubchart?oid=1119499338&amp;format=interactive"></iframe>
This is a look at what the vote share could look like on election day using historical data and polling averages.

### Popular Vote Over Time
<iframe width="600" height="371" seamless frameborder="0" scrolling="no" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vQT7zI2PyREKcBTf5CJflh-Y0O-B_E0DExA0AQJICXH9gMMJia4ugx6LezMPtNZ3qWxozhOZFA_zbL6/pubchart?oid=687436770&amp;format=interactive"></iframe>
A look at how the range of the forecasted vote share has changed over the course of time.

### Battleground Races
These are the races that are either the most interesting or most likely to get interesting 

[Arizona](https://zecellomaster.github.io/the-projection-room/arizona/)     

[Colorado](https://zecellomaster.github.io/the-projection-room/colorado/)

[Florida](https://zecellomaster.github.io/the-projection-room/florida/)

[Georgia](https://zecellomaster.github.io/the-projection-room/georgia/)

[Iowa](https://zecellomaster.github.io/the-projection-room/iowa/)

[Michigan](https://zecellomaster.github.io/the-projection-room/michigan/)

[Minnesota](https://zecellomaster.github.io/the-projection-room/minnesota/)

[Nevada](https://zecellomaster.github.io/the-projection-room/nevada/)

[New Hampshire](https://zecellomaster.github.io/the-projection-room/new_hampshire/)

[New Mexico](https://zecellomaster.github.io/the-projection-room/new_mexico/)

[North Carolina](https://zecellomaster.github.io/the-projection-room/north_carolina/)

[Ohio](https://zecellomaster.github.io/the-projection-room/ohio/)

[Pennsylvania](https://zecellomaster.github.io/the-projection-room/pennsylvania/)

[Texas](https://zecellomaster.github.io/the-projection-room/texas/)

[Wisconsin](https://zecellomaster.github.io/the-projection-room/wisconsin/)

[Maine CD-2](https://zecellomaster.github.io/the-projection-room/maine_cd_2/)

[Nebraska CD-2](https://zecellomaster.github.io/the-projection-room/nebraska_cd_2/)

### Tipping Point
The tipping point is defined as the state that gets the eventual winner their 270th electoral vote. Here is a list of the races that are most likely to do just that, along with the forecasted margins of victory.
<iframe width="500" height="371" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vQT7zI2PyREKcBTf5CJflh-Y0O-B_E0DExA0AQJICXH9gMMJia4ugx6LezMPtNZ3qWxozhOZFA_zbL6/pubhtml?gid=1871926673&amp;single=true&amp;widget=true&amp;headers=false"></iframe>


### All States
<iframe width="500" height="371" src="https://docs.google.com/spreadsheets/d/e/2PACX-1vRsb4OQeyJBX2P0Od5zN1-S6EGaB4ChjwERt_hbjkp9ck_4XTCZx_SgDzaDxgietocK2hPAtlgFdS6d/pubhtml?gid=160042951&amp;single=true&amp;widget=true&amp;headers=false"></iframe>
Highlighted bold states are battleground races. Note that the margin of victory is negative if Biden leads and positive if Trump leads. Note that Nebraska and Maine use a [slightly different system](https://www.270towin.com/content/split-electoral-votes-maine-and-nebraska/) to allocate electors than winner-take-all, so the statewide vote for both is denoted with a (S) while the congressional districts are labeled individually.

## Senate Forecast
Coming Soon!

Polling data from [538.com](https://projects.fivethirtyeight.com/polls/?ex_cid=irpromo).

Charts created using [Google Sheets](https://www.google.com/sheets/about/).

The [Pre-Election Estimation System](https://github.com/zecellomaster/the-projection-room.git) is powered by a group of MATLAB scripts I designed myself.

All data presented can be found on the [official online repository](https://drive.google.com/drive/folders/1kHx-x_HtC0uqQKqF8HZOrfzr62zd8wP6?usp=sharing).

If you find errors or have potential sugestions, please do not hesiate to let me know! 

<!-- Begin 270towin.com 2020 Presidential Election Countdown Widget -->
<iframe src="https://www.270towin.com/2020-countdown-clock/widget300x200.php" width="300" height="215" border="0" frameBorder="0">
    Browser not supported. Visit <a href="https://www.270towin.com/">www.270towin.com</a>
</iframe>
<!-- End 270towin.com 2020 Presidential Election Countdown widget -->

<!--<meta http-equiv="refresh" content="360" />-->
