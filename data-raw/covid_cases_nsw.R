library(dplyr)

if (!file.exists("data-raw/confirmed_cases_table1_location_agg.csv")) {
  cases_url <- "https://data.nsw.gov.au/data/dataset/aefcde60-3b0c-4bc0-9af1-6fe652944ec2/resource/5d63b527-e2b8-4c42-ad6f-677f14433520/download/confirmed_cases_table1_location_agg.csv"
  download.file(cases_url, destfile = "data-raw/confirmed_cases_table1_location_agg.csv")
}

location_agg <- readr::read_csv("data-raw/confirmed_cases_table1_location_agg.csv")

set.seed(202210)

covid_cases_nsw <- location_agg %>%
  transmute(
    postcode,
    lga = stringr::str_remove(lga_name19, " \\(.*\\)$"),
    lhd = lhd_2010_name,
    year = as.integer(format(notification_date, "%Y")),
    type = c("A", "B")[as.integer(format(notification_date, "%m")) %% 2 + 1],
  ) %>%
  filter(lga %in% c("Walgett", "Mid-Coast", "Blacktown")) %>%
  slice_sample(n = 100)

usethis::use_data(covid_cases_nsw, overwrite = TRUE)
