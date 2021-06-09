---
theme: jekyll-theme-cayman
title: "MLS Forecast Methodology Page"
permalink: /mls-forecast-2021/methodology
---
<meta name="twitter:card" content="summary">
<meta property="og:image" content="https://raw.githubusercontent.com/zecellomaster/the-projection-room/master/websitefavicon3.png">

# MLS Forecast Methodology

[<<Back to the forecast<<](https://zecellomaster.github.io/the-projection-room/mls-forecast-2021/)

The Projection Room Forecast has previously been restricted to predicting political events, with our other forecasts focused on the [2020 Presidential Election](https://zecellomaster.github.io/the-projection-room/president-2020/) and the [2021 Georgia Senate Runoffs](https://zecellomaster.github.io/the-projection-room/ga-runoffs-2021/).

Now we've decided its high time to fulfill the other promise made in the byline of our website header: *predicting sports*. To do this, we're trying our hands at forecasting the 2021 Major League Soccer (MLS) season.

## Background
The forecast uses an MLS oriented version of the [*Elo rating system*](https://en.wikipedia.org/wiki/Elo_rating_system), a concept created by Hungarian-American physicist [Arpad Elo](https://en.wikipedia.org/wiki/Arpad_Elo) as a method to rank chess players. Specifically, it uses an algorithm based on the [World Football Elo Ratings](https://en.wikipedia.org/wiki/World_Football_Elo_Ratings), but has a few adjustments which will be discussed later.

The advantage of such ratings is that it allows for the relative strength of teams to be easily quantified: If a team is above the average rating, then it is a relatively good team. Also, due to the rigorously Bayesian nature of the Elo rating algorithm, well calibrated system is also fairly good at predicting the results of zero sum (i.e. one side loses and the other wins) games.

### Creating The Ratings
To create the ratings for all MLS Teams, a multistep process is utilized.

1) Start every team at a set number of points (for this forecast we use 1500). 
This includes expansion teams as well.

2) For each match, calculate the number of points a team will win/lose (P). This depends on factors such as the difference between the two team's Elo scores, the significance of the match, and the team with home field advantage. P is calculated as

<center>

P = KG(R - W)

</center>

K is the match weight, G is the goal difference weight, R is the result of the match (R is 0 for loss, 0.5 for a draw, 1 for a win), and W is the predicted win expectancy for a team.

To find the match weight (K) the following values are used:

| Match Type                                     | Value |
|------------------------------------------------|-------|
| Regular Season Game                            | 20    |
| Play-In Round                                  | 25    |
| Playoffs; First Round/Conference Quarterfinals | 30    |
| Playoffs; Conference Semifinals                | 40    |
| Playoffs; Conference Finals                    | 50    |
| MLS Cup                                        | 60    |

Note: For the *2020 MLS is Back Tournament*, the semifinals are weighted as conference finals, the quarterfinals are weighted as conference semifinals, and so on.

To find the goal difference weight (G) the following values are used:
  
| Goal Difference (x) | Value      |
|---------------------|------------|
| Less or equal to 1  | 1          |
| Equal to 2          | 1.5        |
| Greater than 3      | (11 + x)/8 |

Win expectancy is calculated using the formula:

<center>

W = 1/(10^(dr/400) + 1)

</center>

Where dr is the difference in Elo ratings. The home team has 100 points added onto their rating.

3) Using the games' results, add/subtract the number of points calculated (rounded to the nearest integer) to the both of the team's ratings. This system is zero sum, meaning that the number of points both teams receive is equal and opposite to each other (e.g. Team A gets 2 points, Team B will lose 2 points). If a team is expected to win, the number of points they gain is *less* than the number that they would drop if they lost (or in some cases, draw) the match. Conversely, if a team is expected to lose, they would shed a fewer number of points than what they would gain if they won (or in some cases, draw).

4) This process is done chronologically for every MLS game ever played. After each match, the teams' Elos are updated and used to calculate their next matches and so on. At the end of each season, the ratings are [regressed to the mean](https://en.wikipedia.org/wiki/Regression_toward_the_mean) Elo of 1500 by a factor of 1 to 3. This helps account for personnel changes as well as the fact that a team could have just had a lucky or unlucky season.

But are these ratings legit? Well, Elo ratings are meant to be predictive, and if properly calibrated, an Elo win expectancy of 60% means that on average the team will win about 60% of the time.

We can apply this to all MLS games with a winner and a loser that occurred from 1996 to 2020 to create a calibration chart. Each bubble (a.k.a. bin) represents a certain number of match results. The horizontal axis represents a win/loss probability where each bin is centered around multiples of 5% and includes probabilities 2.5% greater or less than its center (i.e. the 60% bin includes probabilities from 57.5% to 62.5%). The vertical axis represents the *actual* result rate, or how many times the prediction result happened.

If a forecast is perfectly calibrated, then all the bins should inhabit a 45 degree line.

![MLS Elo Cal Chart](https://user-images.githubusercontent.com/67310349/120088731-b1d9e380-c0c1-11eb-9e5c-07267354034e.jpg)

This is a fairly well calibrated rating system, although it is a bit bearish on teams that have a >50% chance of winning, while bullish on their opponents. Moreover, the tight spread of distributions emphasize how competitive the MLS is; it's rare to have matches where a team is an overwhelming favorite.

## Turning Ratings Into Predictions
Win expectancy is cool and all, but it only accounts for win/loss, which doesn't help much in a trinary game such has soccer (since a team can win, lose, **or** draw). For this, a Poisson process is employed.

### Poisson Process
As described by [Will Koehrsen](https://towardsdatascience.com/the-poisson-distribution-and-poisson-process-explained-4e2cb17d459), a Poisson Process is a model for a series of discrete events where the *average* time between events is known, but the *exact* timing of events is random. If these events take place within a finite time, then they can be represented using a *Poisson distribution*.

A [Poisson distribution](https://en.wikipedia.org/wiki/Poisson_distribution) is a type of probability distribution that models the likelihood of a number of events that occur at a known rate within a fixed interval. A soccer match also has a number of events (goals) which occur with in a fixed interval (give or take 90 minutes), making a Poisson distribution a worthy method for modeling it.

This forecast uses a nested Poisson regression, a technique utilized and described in detail by Lorentz Gilch in his [2019 African Cup of Nations Forecast](https://arxiv.org/pdf/1905.03628.pdf). It uses prior results and Elos from the past 3 seasons of matches (including ones played this year) to create the distributions.

While it takes a couple of extra steps, it allows for each team's offensive and defensive relative strengths to be accounted for, which produces [more accurate results than other methods](https://arxiv.org/pdf/1806.01930.pdf) such as two independent Poisson distributions.

### Match by Match
The Poisson regressions can be used in tandem with the Elo ratings (adjusted for home field advantage) to create values for the average number of goals either team is expected to score on each other if the match was played multiple times under the same conditions. Using these values, the probability of a each team will score a certain number of goals can be calculated.

For example, here are the distributions for the Orlando City vs FC Cincinnati match on May 1st, 2021

![FC Cincinnati](https://user-images.githubusercontent.com/67310349/119240183-1920f200-bb1c-11eb-99f6-2b6c453816bc.jpg)
![Orlando City](https://user-images.githubusercontent.com/67310349/119240205-335ad000-bb1c-11eb-8794-5d2f8dc6b3d8.jpg)

These distributions can combined to make a score probability matrix of the match. Below is a visualization of that.

![MatchMatrix](https://user-images.githubusercontent.com/67310349/119240232-52f1f880-bb1c-11eb-91d4-73d2f37c9098.jpg)

From this, the probability of all match results (win, loss, or draw) can be quantified. In the above match, due to the larger range of projected goal distributions for Orlando City, the model saw them as the overwhelming favorites with a 74% chance of victory. They won 3-0.

The same process is done for every future match in the season. This forecast is run "hot", which means these simulated results get treated like actual results and are used to adjust Elo ratings. This way, a wider range of events can be observed, such as a bad team going on a win streak and overperforming expectations, or a good team playing poorly and underperforming them.

This process is repeated 15,000 times, with various observations (the number of points a team has, whether or not they made the playoffs, etc.) made at the end of each iteration. By dividing the number of times those events occurred, we can calculate the probability of those events happening in real life.

For playoff matches, draws are not possible, so in the occurrence of a simulated draw, the Elo calculated win probability is used to break it.

### What about expansion teams?
As stated prior, expansion teams (such as Austin FC for the 2021 Season) are given the same Elo rating as any starting team. For their distributions, however, a little creativity is needed.

Generally speaking, expansion teams don't really do so well in their inaugural season.
![Expansion Elos](https://user-images.githubusercontent.com/67310349/119240242-61401480-bb1c-11eb-9678-b11856f9e129.jpg)

This can be due to a variety of reasons, such as the squad lacking chemistry, the youth teams/development system still being structured, an inexperienced coaching staff, etc. So for expansion teams, it is assumed that there strength is somewhere in between that of past expansion teams, meaning the results for the first seasons of all expansion teams since 2005 are used for the Poisson regression. This is changed to their actual match based regressions after they have played enough of them.

The forecast will be updated before the first game of every match day for the rest of the season. [Check it out here!](https://zecellomaster.github.io/the-projection-room/2021-mls-forecast/)

## Other Stuff
2021 MLS scores courtesy [SportsReference.com](https://fbref.com/en/comps/22/schedule/Major-League-Soccer-Scores-and-Fixtures).

MLS Archive Data courtesy [Joseph Mohr](https://www.kaggle.com/josephvm/major-league-soccer-dataset?select=matches.csv).

This forecast uses the scripts and data found in our [MLS Elo Forecast](https://github.com/zecellomaster/MLSEloForecast) repository.

Follow us on Twitter: [@theprforecast](https://twitter.com/theprforecast)

Check out our [other forecasts](https://zecellomaster.github.io/the-projection-room).

Page built by [@zecellomaster](https://twitter.com/zecellomaster).

Found any errors? Want to make a suggestion? Have any comments? Email us: [theprojectionroomdata@gmail.com](mailto:theprojectionroomdata@gmail.com)
