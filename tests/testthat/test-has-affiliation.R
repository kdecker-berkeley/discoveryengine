context("has_affiliation specifications")
source("helpers.R")
library(magrittr)

test_that("has_affiliation meets specifications on standard input", {
    test <- has_affiliation(MA4, RC2, include_former = TRUE)
    test %>% uses_table("d_bio_affiliation_mv")
    test %>% id_of_type("entity_id")
    test %>% id_field_is("entity_id")

    test %>%
        has_filters(affil_code = c("MA4", "RC2"))

    test %>% has_clause_count(1)

})

test_that("has_affiliation meets specifications on no input", {
    has_affiliation() %>% has_clause_count(0)
    has_affiliation(include_former = FALSE) %>%
        has_filters(affil_status_code = c("A", "C", "T", "P"))
})
