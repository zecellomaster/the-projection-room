# MLS Forecast Methodology
[<<Back to the forecast<<](https://zecellomaster.github.io/the-projection-room/2021-mls-forecast/)

The Projection Room Forecast has previously been restricted to predicting political events, with our other forecasts focused on the [2020 Presidential Election](https://zecellomaster.github.io/the-projection-room/president-2020/) and the [2021 Georgia Senate Runoffs](https://zecellomaster.github.io/the-projection-room/ga-runoffs-2021/).

Now we've decided its high time to fulfill the other promise made in the byline of our website header: *predicting sports*. To do this, we're trying our hands at forecasting the 2020 Major League Soccer (MLS) season.

## Background
The forecast uses an MLS oriented version of the [*Elo rating system*](https://en.wikipedia.org/wiki/Elo_rating_system), a concept created by Hungarian-American physicist [Arpad Elo](https://en.wikipedia.org/wiki/Arpad_Elo) as a method to rank chess players. Specifically, it uses an algorithm based on the [World Football Elo Ratings](https://en.wikipedia.org/wiki/World_Football_Elo_Ratings).

The advantage of such ratings is that it allows for the relative strength of teams to be easily quantified: If a team is above the average rating, then it is a relatively good team. Also, due to the rigorously Bayesian nature of the Elo rating algorithm, well calibrated system is also fairly good at predicting the results of zero sum (i.e. one side loses and the other wins) games.

### Creating The Ratings
To create the ratings for all MLS Teams, a multistep process is utilized.

1) Start every team at a set number of points (for this forecast we use 1500). 
This includes expansion teams as well.

2) For each match, calculate the number of points a team will win/lose (P). This depends on factors such as the difference between the two team's Elo scores, the significance of the match, and the team with home field advantage. 

3) Using the games' results, add/subtract the number of points calculated (rounded to the nearest integer) to the both of the team's ratings. This system is zero sum, meaning that the number of points both teams receive is equal and opposite to each other (e.g. Team A gets 2 points, Team B will lose 2 points).

(See more about Steps 2 and 3 here)

4) This process is done chronologically for every MLS game ever played. After each match, the teams' Elos are updated and used to calculate their next matches and so on. At the end of each season, the ratings are [regressed to the mean](https://en.wikipedia.org/wiki/Regression_toward_the_mean) Elo of 1500 by a factor of 1 to 3. This helps account for personnel changes as well as the fact that a team could have just had a lucky or unlucky season.

But are these ratings legit? Well, Elo ratings are meant to be predictive, and if properly calibrated, an Elo win expectency of 60% means that on average, the team will win about

We can apply this to all MLS games with a winner and a loser that occurred from 1996 to 2020 to create a calibration chart. Each bubble (a.k.a. bin) represents a certain number of match results. The horizontal axis represents a win/loss probability where each bin is centered around multiples of 5% and includes probabilities 2.5% greater or less than its center (i.e. the 60% bin includes probabilities from 57.5% to 62.5%). The vertical axis represents the *actual* result rate, or how many times the prediction result happened.

If a forecast is perfectly calibrated, then all the bins should inhabit a 45 degree line.

[Insert calibration chart]

As


## Turning Ratings Into Predictions
Win expectancy is cool and all, but it only accounts for win/loss, which doesn't help much in a multimodal game such has soccer (since a team can win, lose, **or** draw). For this, a Poisson process is employed.

### Poisson Process
As described by [Will Koehrsen](https://towardsdatascience.com/the-poisson-distribution-and-poisson-process-explained-4e2cb17d459), a Poisson Process is a model for a series of discrete events where the *average* time between events is known, but the *exact* timing of events is random. If these events take place within a finite time, then they can be represented using a *Poisson distribution*.

A [Poisson distribution](https://en.wikipedia.org/wiki/Poisson_distribution) is a type of probability distribution that models the likelihood of a number of events that occur at a known rate within a fixed interval. A soccer match also has a number of events (goals) which occur with in a fixed interval (give or take 90 minutes), making a Poisson distribution a worthy method for modeling it.

This forecast uses a nested Poisson regression to develop the distributions, a technique utilized and described in detail by Lorentz Gilch in his [2019 African Cup of Nations Forecast](https://arxiv.org/pdf/1905.03628.pdf). It uses prior results and Elos from the past 3 seasons to create the distributions.

While it takes a couple of extra steps, it allows for each team's offensive and defensive relative strengths to be accounted for, which it produces [more accurate results than other methods](https://arxiv.org/pdf/1806.01930.pdf) such as two independent distributions.

## Match by Match
Before each match day, all of the team's regressions are calculated and used to simulate the results of each match remaining in the season.

[Show example matrix]

This forecast is run "hot", which means these simulated results get treated like actual results and are used to adjust Elo ratings. This way, a wider range of events can be observed, such as a bad team going on a win streak and overperforming expectations, or a good team playing poorly and underperforming them.

This process is repeated 15,000 times, with various observations (the number of points a team has, whether or not they made the playoffs, etc.) made at the end of each iteration.

### What about expansion teams?
As stated prior, expansion teams (such as Austin FC for the 2021 Season) are given the same Elo rating as any starting team. For their distributions, however, a little creativity is needed.

Generally speaking, teams in their first seasons don't really do so well in their inaugural season.
[insert Expansion Elo Here]
This is to be expected as they haven't fully developed their rosters or coaching staff, which leads them to have lower than average strengths

So for new expansion teams, it is assumed that there strength is *somewhere* in the middle of these teams, meaning the results for the first seasons of all expansion teams since 2005 are used in the start of season regression. As the team plays its games, this average is weighted less for every actual match that the team plays until they have completed 25 matches, whicj

The forecast will be updated at ~3:00 AM EDT after every match day.

