---
theme: jekyll-theme-cayman
title: "International Soccer Methodology"
description: The nuts and bolts behind our new Elo ratings and forecast.
permalink: /int-soccer-methodology/
---

[<<Back to Home Page<<](https://zecellomaster.github.io/the-projection-room/)

The Projection Room Forecast is back at it again with a custom Elo rating system and TWO new models, one each for UEFA Euro 2024 and 2024 Copa América!

The system uses a variation of the [*Elo rating system*](https://en.wikipedia.org/wiki/Elo_rating_system), a concept created by Hungarian-American physicist [Arpad Elo](https://en.wikipedia.org/wiki/Arpad_Elo) as a method to rank chess players. The advantage of such ratings is that it allows for the relative strength of teams to be easily quantified: If a team is above the average rating, then it is a relatively good team, and if they are below it, they are below average. Also, due to the rigorously Bayesian nature of the Elo rating algorithm, well calibrated system is also fairly good at predicting the results of binary (i.e. one side loses and the other wins) games.

Since soccer is *not* always zero sum (it's usually *ternary*; a team could win, lose, or draw), this system diverges from a true Elo rating system in several ways, including the fact that there are **offensive** and **defensive** **Elo** components for each team.

## Creating the ratings

To create the ratings for all international soccer teams, a multistage process is utilized.

1)  <ins> Start every team at a set number of points</ins> In this system, we assigned the first international teams to offensive and defensive Elo ratings of 1500 to England, Wales and Scotland, due to the fact that played each other frequently during those early years. New teams are assigned Elo ratings at a certain percentile of their starting confederation's rating distribution, or the international one if their confederation does not have enough teams. This accounts for the fact that new teams in the distant past, such as [Brazil](https://en.wikipedia.org/wiki/Brazil_national_football_team) in 1914, likely played at a level closer to their peers at the time than [South Sudan](https://en.wikipedia.org/wiki/South_Sudan_national_football_team), who played their first match in 2012.

Note that whenever a new team is added, their Elos are below average, so the difference between both their offense and defense Elo rating and the average Elo of 1500 is evenly split between their own respective ratings as well as every other teams'. This is designed to keep the average Elo rating at 1500, and as explained below, since we utilize the difference in the Elo ratings themselves.

2)  <ins> For a matchup, calculate the predicted number of goals each team will score.</ins> Think of this number not as an *exact* number of goals that a team would score, but rather the *average* number they would score if the match were repeated an infinite number of times. This system works on the intuition that a match between two teams can be subdivided into a match between a team's offense vs their opponent's defense and vice versa. As such, the difference between a team's offensive Elo and their opponent's defensive Elo determines the average number of goals they are predicted to score. At the core of basically every Elo rating system is an S-curve function used to calculate win expectancy. In this system, we use it to calculate the predicted number of goals ($pG$) that a team will score. Our system uses a joint function defined using the equations

$$x \le 0, pG=\frac{2.9536}{ {10}^{\frac{dr}{400}+1} }$$

and

$$x \ge 0, log(10) * \frac{2.9536}{100} * dr + \frac{2.9536}{2}$$

This is what the model uses to determine $pG$. Its main variable is the offense-defense rating difference between the two teams facing off, $dr$. $dr$ is adjusted based on home field advantage (HFA) if the match is being played in a non-neutral venue. The exact number of Elo points HFA is worth changes year to year using a method similar to [ClubElo.com](https://web.archive.org/web/20140326034352/http://clubelo.com/Articles/AdaptiveHomeFieldAdvantage.html), but it is currently about 65 points and is added to both the home team's offense and defense Elos.[^1]

4)  <ins>For each match, calculate the number of points ($P$) to be exchanged. </ins> This depends on factors such as the difference between the two team's Elo scores, the significance of the match, and the team with home field advantage. $P$ is calculated as:

$$P\ =K\ast\ W \ast R \ast G$$

$K$ is the k constant and is set at 20. $G$ is the goal difference weight, $R$ is the result of the match ($R$ is -1 for "loss", 1 for a "win'). W is the match weight for the competition being played, which is anywhere from between 1 and 3 depending on the significance as shown below.

| Competition Type                           | Examples                                                              | W   |
|------------------------|------------------------|------------------------|
| International Friendly (IF)                | Friendly matches                                                      | 1   |
| Other Tournaments (OT)                     | Kirin Challenge Cup, FIFA Series                                      | 1.5 |
| Major Tournament Qualifiers (MTQ)          | CONCACAF Nations League qualification, AFF Championship qualification | 1.5 |
| Major Tournament (MT)                      | AFC Challenge Cup, Arab Cup                                           | 2   |
| Confederation Championship Qualifier (CCQ) | CAF African Cup of Nations Qualifiers, UEFA Euro Qualifiers           | 2   |
| Confederation Championship (CC)            | CONCACAF Gold Cup, AFC Asian Cup                                      | 2.5 |
| Major Inter-confederation Tournament (MIT) | Confederations Cup, Finalissima                                       | 2.5 |
| World Championship (WC)                    | FIFA World Cup, Pre-1992 Olympic Games[^2]                            | 3   |

$G$ is the goal difference weight, which has an adjustment for [autocorrelation](https://www.investopedia.com/terms/a/autocorrelation.asp). Basically, in Elo ratings, autocorrelation is caused by the fact that it utilizes the score in order to determine points exchanged in each match. Good teams facing weaker teams tend to win games by larger margins than they would facing a more equal opponent. $G$ uses the formula

$$G = 0.69349 * (g_{d})^{0.7} + \frac{1.42118}{1.42118 + (dr_{w} * 0.001)}$$

where $dr_w$ is the difference between winning and the losing team's Elo rating while $g_d$ is the absolute value of goal difference between the predicted goals scored and the actual goals scored. Obviously, a larger $g_d$ corresponds to a larger $G$ and therefore a larger exchange of points, but there are diminishing returns with greater values. Moreover, the magnitude of this increase is reduced when a team with an Elo advantage wins and increased when the underdog does instead.

In this system, a "win" for the offense is when it scores more goals than expected while a defense "wins" when it allows fewer goals than expected. A "loss" therefore happens when the offense scores fewer goals than expected or when the defense concedes more goals than expected.

This system is zero sum, meaning that the number of points both teams receive is equal and opposite to each other (e.g. If a team's offensive Elo rating gains 10 Elo points, their opponent's defensive Elo rating will lose 10 points). If a team is expected to "win", the number of points they gain is *less* than the number that they would drop if they "lost". Conversely, if a team is expected to "lose", they would shed a fewer number of points than what they would gain if they "won". This system means that a team won't always gain points for winning the match overall; teams which under-perform expectations are still liable to lose Elo points.

6)  <ins>Rinse and repeat.</ins> This process is done chronologically for every international game we have available, courtesy [Mart Jürisoo](https://github.com/martj42/international_results)'s extensive database.

[^1]: More specifically, the concept is based on the idea that if the estimate for HFA is perfect, then on average no points should be exchanged between the home and away teams. After the end of each year, the average number of points exchanged between home and away teams, weighted by the importance of the competition, is added onto the current estimate of HFA. If the estimate was too low, the difference will be positive, so the HFA will be increased. The opposite is true if the estimate is too high.

[^2]: Since 1992, the Olympic soccer tournament has been limited to Under-23 teams with 3 overage players allowed. Hence, they are not included as international matches after this point.

## Tournament Predictions

For our [UEFA Euro 2024](https://theprforecast.com/euro-forecast-2024/) and [2024 Copa América](https://theprforecast.com/copa-forecast-2024/) Forecasts, we harness out Elo ratings to predict the outcome of each game as well as the tournament.

### Poisson Processes

A [Poisson process](https://towardsdatascience.com/the-poisson-distribution-and-poisson-process-explained-4e2cb17d459), is a model for a series of discrete events where the *average* time between events is known, but the *exact* timing of events is random. If these events take place within a finite time, then they can be represented using a *Poisson distribution*.

A [Poisson distribution](https://en.wikipedia.org/wiki/Poisson_distribution) is a type of probability distribution that models the likelihood of a number of events that occur at a known rate within a fixed interval. A soccer match also has a number of events (goals) which occur with in a fixed interval (give or take 90 minutes), making a Poisson distribution a worthy method for modeling it.

### Match by Match

The $pG$ for each team in a match can be used to create two independent Poisson distributions, from which the probability that each team will score a certain number of goals can be calculated.

Take for example the match between France and Romania in Euro 2016.

![](https://raw.githubusercontent.com/zecellomaster/the-projection-room/master/Methodology/GoalDist.jpg)

You can see that France is more likely to score a higher number of goals than Romania is, so therefore they are more likely to win (our model gave them a 61% chance to do just that). By combining the two distributions, we can make a score matrix as shown below.

![](https://raw.githubusercontent.com/zecellomaster/the-projection-room/master/Methodology/ScoreMatrix.jpg)

Finding out the result chances is as simple as adding up chances of the scorelines where each team wins, loses, or draws (France beat Romania 2-1 in this match).

We can simulate a game by randomly generating a scoreline, which is then done for every future match in the tournament. This forecast is run "hot", which means these simulated results get treated like actual results and are used to adjust Elo ratings. This way, a wider range of events can be observed, such as a bad team going on a win streak and over-performing expectations.

This process is repeated 15,000 times, with various observations (the number of points a team has, whether or not they made the knockout stages, etc.) made at the end of each iteration. By dividing the number of times those events occurred with the number of simulations performed, we can calculate the probability of those events happening in real life.

Knockout matches add another wrinkle since draws are not possible. For this, a little creativity is needed. If the match will have extra time in the case of a draw, then we re-simulate the score with the original $pG$ multiplied by 0.33. If the extra time simulation resulted in another draw, we utilize a [logistic regression](https://en.wikipedia.org/wiki/Logistic_regression) trained on the pre-match **overall** **Elo** difference[^3] to estimate the chances of a shootout win. From this, we can simulate the winner of the game.

[^3]: The **overall** rating is simply the combined number of offensive and defensive Elo points a team is above or below an average team (one with an offensive and defensive Elo rating of 1500) added to 1500. For example a team with an offensive Elo of 1600 and a defensive Elo of 1550 would have an overal Elo of 1650.

You may notite that the offensive and defensive Elos are not present on the main tournament progression forecast table. For simplicity, we convert them to **offensive** and **defensive ratings**, which represent the number of goals that a team would score and concede respectively to an average international team on a neutral field.

And that's it! Once again, do make sure you check out our updatring models for [UEFA Euro 2024](https://theprforecast.com/euro-forecast-2024/) and [2024 Copa América](https://theprforecast.com/copa-forecast-2024/).

## Credits/Other Stuff

Thanks to Nate Silver, Jay Boice, and Neil Paine (all formerly of FiveThirtyEight) for their splendid work on Elo ratings in several sports that inspired this one.

Also thanks to the [World Football Elo Ratings](https://www.eloratings.net/) and [Club Elo](http://clubelo.com/) for being the pioneers of Elo rating systems in soccer.

Another show of appreciation for [Mart Jürisoo](https://github.com/martj42) for having what is perhaps the most extensive readily available match database for international soccer anywhere.

Follow us on Twitter: [\@theprforecast](https://twitter.com/theprforecast)

Check out our [other work](https://zecellomaster.github.io/the-projection-room).

Page built by [\@zecellomaster](https://twitter.com/zecellomaster).

Found any errors? Want to make a suggestion? Have any comments? Email us: [theprojectionroomdata\@gmail.com](mailto:theprojectionroomdata@gmail.com)
