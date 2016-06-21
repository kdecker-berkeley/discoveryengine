context("lives_in_county specifications")
source("helpers.R")
library(magrittr)

test_that("lives_in_county meets specifications on standard input", {
    test <- lives_in_county(CA007)
    test %>% uses_table("d_bio_address_mv")
    test %>% id_of_type("entity_id")
    test %>% id_field_is("entity_id")

    test %>%
        has_filters(county_code = "CA007",
                    addr_type_code = "H")

    test %>% has_clause_count(2)

})

test_that("lives_in_county meets specifications on no input", {
    lives_in_county() %>%
        has_clause_count(1)

    lives_in_county() %>%
        has_filters(addr_type_code = "H")
})

