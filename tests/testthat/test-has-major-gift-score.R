context("has_major_gift_score specifications")
source("helpers.R")
library(magrittr)

test_that("has_major_gift_score meets specifications on standard input", {
    test <- has_major_gift_score(MORE, MOST)
    test %>% uses_table("d_bio_demographic_profile_mv")
    test %>% id_of_type("entity_id")
    test %>% id_field_is("entity_id")

    test %>%
        has_filters(dp_interest_code = c("MORE", "MOST"),
                    dp_rating_type_code = "MGS")

    test %>% has_clause_count(2)

})

test_that("has_major_gift_score meets specifications on no input", {
    has_major_gift_score() %>%
        has_clause_count(1)

    has_major_gift_score() %>%
        has_filters(dp_rating_type_code = "MGS")
})
