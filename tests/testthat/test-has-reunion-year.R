context("has_reunion_year specifications")
source("helpers.R")
library(magrittr)

test_that("has_reunion_year meets specifications on standard input", {
    test <- has_reunion_year(1985, 1999:2001)
    test %>% uses_table("d_entity_mv")
    test %>% id_of_type("entity_id")
    test %>% id_field_is("entity_id")

    test %>%
        has_filters(class_campaign_year = c(1985, 1999:2001))
})

test_that("has_reunion_year meets specifications on no input", {
    has_reunion_year() %>%
        has_filters()
})
