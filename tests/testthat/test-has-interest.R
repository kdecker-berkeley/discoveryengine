context("has_interest specifications")
source("helpers.R")
library(magrittr)

test_that("has_interest meets specifications on standard input", {
    test <- has_interest(DAN, ABC)
    test %>% uses_table("d_bio_interest_mv")
    test %>% id_of_type("entity_id")
    test %>% id_field_is("entity_id")

    test %>%
        has_filters(interest_code = c("DAN", "ABC"))

    test %>% has_clause_count(1)

})

test_that("has_interest meets specifications on no input", {
    has_interest() %>%
        has_clause_count(0)
    has_interest() %>% uses_table("d_bio_interest_mv")
})
