context("has_capacity")
source("helpers.R")
library(magrittr)

test_that("has_capacity meets specifications on standard input", {
    test <- has_capacity(1:5)

    # has_capacity should pull entity_ids from d_entity_mv
    test %>% uses_table("d_entity_mv")
    test %>% id_of_type("entity_id")

    # has_capacity should filter on the field capacity_rating_code
    test %>% filters_on("capacity_rating_code")
})

test_that("has_capacity meets specifications on no input", {
    test <- has_capacity()

    # should still filter on capacity_rating_code
    test %>% filters_on("capacity_rating_code")

    # in this case has_capacity should look for all valid (1:14) capacity codes
    condition <- test$where[[1]]
    expect_identical(condition[[3]], 1:14)
})
