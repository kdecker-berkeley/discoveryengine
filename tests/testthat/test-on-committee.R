context("on_committee specifications")
source("helpers.R")
library(magrittr)

test_that("on_committee meets specifications on standard input", {
    test <- on_committee(UC5, BD2)
    test %>% uses_table("d_bio_committee_mv")
    test %>% id_of_type("entity_id")
    test %>% id_field_is("entity_id")

    test %>%
        has_filters(committee_code = c("UC5", "BD2"))

    test %>% has_clause_count(1)

    on_committee(UC5, BD2, include_former = FALSE) %>%
        has_filters(committee_code = c("UC5", "BD2"),
                    committee_status_code = c("C", "T"))

})

test_that("on_committee meets specifications on no input", {
    on_committee() %>%
        has_clause_count(0)
    on_committee(include_former = FALSE) %>%
        has_filters(committee_status_code = c("C", "T"))
})

