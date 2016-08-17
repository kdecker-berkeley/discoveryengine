context("received_award specifications")
source("helpers.R")
library(magrittr)

test_that("received_award meets specifications on standard input", {
    test <- received_award(NOBEL, PRIZE)
    test %>% uses_table("d_bio_awards_and_honors_mv")
    test %>% id_of_type("entity_id")
    test %>% id_field_is("entity_id")

    test %>%
        has_filters(awd_honor_code = c("NOBEL", "PRIZE"))

    test %>% has_clause_count(1)
})

test_that("received_award meets specifications on no input", {
    received_award() %>%
        has_clause_count(0)
    received_award() %>% uses_table("d_bio_awards_and_honors_mv")
})

