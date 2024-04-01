library(dplyr)
library(arrow)
library(duckdb)

dat <- read.csv(
  here::here(
    "data",
    "2022Release_Nor",
    "50-StopData",
    "50-StopData",
    "1997ToPresent_SurveyWide",
    "Fifty10",
    "fifty10.csv"
  )
)

arrow_dat <- read_csv_arrow(
  here::here(
    "data",
    "2022Release_Nor",
    "50-StopData",
    "50-StopData",
    "1997ToPresent_SurveyWide",
    "Fifty10",
    "fifty10.csv"
  )
)

arrow_dataset <- open_dataset(
  here::here(
    "data",
    "2022Release_Nor",
    "50-StopData",
    "50-StopData",
    "1997ToPresent_SurveyWide",
    "Fifty10"
  ),
  hive_style = F,
  format =  "csv"
)

multi_files <- list.files(
  here::here(
    "data",
    "2022Release_Nor",
    "50-StopData",
    "50-StopData",
    "1997ToPresent_SurveyWide"
  ),
  pattern = ".csv",
  recursive = T,
  full.names = T
)

arrow_multi_files <- open_dataset(multi_files,
                                  format = "csv",
                                  hive_style = F)




all_cnames <- arrow_multi_files |>
  filter(AOU == 02060) |>
  mutate(
    stopTotal = Stop1 + Stop2 + Stop3 + Stop4 + Stop5 + Stop6 + Stop7 + Stop8 + Stop9 + Stop10 + Stop11 + Stop12 + Stop13 + Stop14 + Stop15 + Stop16 + Stop17 + Stop18 + Stop19 + Stop20 + Stop21 + Stop22 + Stop23 + Stop24 + Stop25 + Stop26 + Stop27 + Stop28 + Stop29 + Stop30 + Stop31 + Stop32 + Stop33 + Stop34 + Stop35 + Stop36 + Stop37 + Stop38 + Stop39 + Stop40 + Stop41 + Stop42 + Stop43 + Stop44 + Stop45 + Stop46 + Stop47 + Stop48 + Stop49 + Stop50
  ) |>
  select(StateNum, Route, Year, stopTotal) |>
  group_by(StateNum, Year) |>
  summarize(StateTotal = sum(stopTotal)) |>
  collect()

paste(colnames(all_cnames), collapse = " + ")

library(ggplot2)
ggplot(all_cnames, aes(Year, StateTotal, color = as.factor(StateNum))) +
  geom_point() + geom_line()  + theme_bw() + theme(legend.position = "none") +
  ggtitle("Total Sandhill Cranes observed")
