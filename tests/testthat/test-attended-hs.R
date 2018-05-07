context("attended_hs specifications")
source("helpers.R")
library(magrittr)

test_that("attended_hs meets specifications on standard input", {
    test <- attended_hs(050656)
    test %>% uses_table("d_bio_degrees_mv")
    test %>% id_of_type("entity_id")
    test %>% id_field_is("entity_id")

    test %>%
        has_filters(degree_code = c("HS"),
                    institution_code = "050656")
})

test_that("attended_hs meets specifications on no input", {
    attended_hs() %>%
        has_filters(degree_code = "HS")
})
