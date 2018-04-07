library("tidyverse")


## 2018 Data source https://www.hockey-reference.com/leagues/NHL_2018_skaters.html

points <- read.csv("stats_raw.csv", header = TRUE, stringsAsFactors = FALSE)

## Create team weight
percent <- read.csv("odds.csv", header = TRUE, stringsAsFactors = FALSE)

data <- merge(x = points, y = percent, by = "team", all = TRUE)

data %>%
    na.omit(.) %>%
    transform(index = percent * ppg) %>%
    filter(gp > 30) %>%
    arrange(desc(index)) %>%
    select(team, name, gp, index)



