context("has_implied_capacity specifications")
source("helpers.R")
library(magrittr)

test_that("has_implied_capacity meets specifications on standard input", {
    test <- has_implied_capacity(MORE, MOST)
    test %>% uses_table("d_bio_demographic_profile_mv")
    test %>% id_of_type("entity_id")
    test %>% id_field_is("entity_id")

    test %>%
        has_filters(dp_interest_code = c("MORE", "MOST"),
                    dp_rating_type_code = "CAP")

    test %>% has_clause_count(2)

})

test_that("has_implied_capacity meets specifications on no input", {
    has_implied_capacity() %>%
        has_clause_count(1)

    has_implied_capacity() %>%
        has_filters(dp_rating_type_code = "CAP")
})
