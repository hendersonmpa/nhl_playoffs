library("tidyverse")


## 2018 Data source https://www.hockey-reference.com/leagues/NHL_2018_skaters.html

points <- read.csv("stats_2018.csv", header = TRUE, stringsAsFactors = FALSE)

## Create team weight
percent <- read.csv("odds_2018.csv", header = TRUE, stringsAsFactors = FALSE)

data <- merge(x = points, y = percent, by.x = "Tm", by.y = "team", all = FALSE)

contribution <- function(pquarter,psemi,pfinal, PTS, GP){
    ppg <- PTS / GP
    pps <- ppg * 6 ## points per series, used in first round
    quarter <- pquarter * pps
    semi <- pquarter * psemi * pps
    final <- pquarter * psemi * pfinal *  pps
    return(round(x = pps + quarter + semi + final, digits = 2)) 
}




data %>%
##    na.omit(.) %>%
    transform(index = contribution(pquarter, psemi, pfinal,PTS,GP)) %>%
##    transform(index = PTS) %>%
    filter(GP > 30) %>%
    arrange(desc(index)) %>%
    select(Player, Tm, PTS, GP, index) %>%
    write.table(file = "picklist.csv", append = FALSE, quote = FALSE, sep = "\t\t",
            eol = "\n", na = "NA", dec = ".", row.names = FALSE,
            col.names = TRUE, qmethod = c("escape", "double"),
            fileEncoding = "")



