library("tidyverse")


## 2018 Data source https://www.hockey-reference.com/leagues/NHL_2018_skaters.html

points <- read.csv("stats_2018.csv", header = TRUE, stringsAsFactors = FALSE)

## Create team weight
percent <- read.csv("odds_2018.csv", header = TRUE, stringsAsFactors = FALSE)

data <- merge(x = points, y = percent, by.x = "Tm", by.y = "team", all = FALSE)

data %>%
#    na.omit(.) %>%
    transform(index = (one * 0.5 * PTS) + (final * PTS)) %>%
    filter(GP > 30) %>%
    arrange(desc(index)) %>%
    select(Tm, Player, PTS, GP, index) %>%
    write.table(file = "picklist.csv", append = FALSE, quote = FALSE, sep = "\t",
            eol = "\n", na = "NA", dec = ".", row.names = TRUE,
            col.names = TRUE, qmethod = c("escape", "double"),
            fileEncoding = "")



