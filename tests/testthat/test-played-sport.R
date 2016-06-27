context("played_sport specifications")
source("helpers.R")
library(magrittr)

test_that("played_sport meets specifications on standard input", {
    test <- played_sport(MIA, WIA)
    test %>% uses_table("d_bio_sport_mv")
    test %>% id_of_type("entity_id")
    test %>% id_field_is("entity_id")

    test %>%
        has_filters(sport_code = c("MIA", "WIA"))

    test %>% has_clause_count(1)
})

test_that("played_sport meets specifications on no input", {
    played_sport() %>%
        has_clause_count(0)
    played_sport() %>% uses_table("d_bio_sport_mv")
})

