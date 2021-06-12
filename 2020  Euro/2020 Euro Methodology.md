---
theme: jekyll-theme-cayman
title: "UEFA Euro 2020 Forecast Methodology"
permalink: /euro-forecast-2020/methodology/
---
<meta name="twitter:card" content="summary">
<meta property="og:image" content="https://raw.githubusercontent.com/zecellomaster/the-projection-room/master/websitefavicon3.png">

[<<Back to Home Page<<](https://zecellomaster.github.io/the-projection-room/)

# UEFA Euro 2020 Forecast Methodology

[<<Back to the forecast<<](https://zecellomaster.github.io/the-projection-room/euro-forecast-2020/)

After a year long delay, we can finally watch 24 teams over the course of a month duke it out in the 2020 (errr ... 2021? *shuffling papers* no, wait, [it's still technically "2020"](https://www.uefa.com/uefaeuro-2020/news/025c-0f3dbcbd50d8-e5b818335722-1000/)) Euros.

This forecast is more or less the same as our [MLS Forecast](https://theprforecast.com/mls-forecast-2021/) and [its methodology](/mls-forecast-2021/methodology), but with a few key differences.

1) We use Elo ratings from the [World Football Elo Ratings](https://www.eloratings.net/) instead of a custom made system. For those who might not know, these ratings are basically the *de facto* international soccer Elo rating system and have been [pretty reliable over the years](http://lasek.rexamine.com/football_rankings.pdf). While FIFA has thier own [offical version](https://www.fifa.com/fifa-world-ranking/ranking-table/men/) it uses a method based off an Elo rating scale.

2) We use all international A-team matches (no youth squads) from 2014 onwards for the Poisson regressions. The home Elos are adjusted by adding 100 points to their score.

3) For the knockout rounds, instead of breaking ties using Elo derived win chances we simulate the games more thoroughly.

For extra time, the game is simulated again as 1/3rd of a match (since extra time is 30 minutes, which is 1/3rd of a full game).

If a penalty shootout is required, then the Elos of both teams are used to calculate their predicted conversion rate (i.e. penalties made per attempt). Then each penalty attempt is simulated according to [FIFA standards]( https://en.wikipedia.org/wiki/Penalty_shoot-out_(association_football)) until a winner is determined. This is called a Markov Chain and is inspired by a similar method used by [FiveThirtyEight]( https://fivethirtyeight.com/features/a-chart-for-predicting-penalty-shootout-odds-in-real-time/).

Historically, the average scoring rate for penalty shootouts in the Euros is ~78%, but interestingly, lower Elo teams convert at a slightly better rate than higher ones.

The forecast will be updated before the first game of every match day for the rest of the competition. [Check it out here!](https://zecellomaster.github.io/the-projection-room/euro-forecast-2020/).

## Other Stuff
UEFA Euro 2020 Scores courtesy [SportsReference.com](https://fbref.com/en/comps/676/schedule/UEFA-Euro-Scores-and-Fixtures).

Elo ratings from the [World Football Elo Ratings](https://www.eloratings.net/).

Follow us on Twitter: [@theprforecast](https://twitter.com/theprforecast)

Check out our [other forecasts](https://zecellomaster.github.io/the-projection-room).

Page built by [@zecellomaster](https://twitter.com/zecellomaster).

Found any errors? Want to make a suggestion? Have any comments? Email us: [theprojectionroomdata@gmail.com](mailto:theprojectionroomdata@gmail.com)
