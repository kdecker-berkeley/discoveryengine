context("has_affiliation specifications")
source("helpers.R")
library(magrittr)

test_that("has_affiliation meets specifications on standard input", {
    test <- has_affiliation(MB1, XR2, include_former = TRUE)
    test %>% uses_table("d_bio_affiliation_mv")
    test %>% id_of_type("entity_id")
    test %>% id_field_is("entity_id")

    test %>%
        has_filters(affil_code = c("MB1", "XR2"),
                    affil_status_code = c("C", "F"))

    test %>% has_clause_count(2)

})

test_that("has_affiliation meets specifications on no input", {
    has_affiliation() %>%
        has_filters(affil_status_code = c("C", "F"))
    has_affiliation() %>% has_clause_count(1)
    has_affiliation(include_former = FALSE) %>%
        has_filters(affil_status_code = "C")
})
