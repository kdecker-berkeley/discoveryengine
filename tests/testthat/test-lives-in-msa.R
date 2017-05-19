context("lives_in_msa specifications")
source("helpers.R")
library(magrittr)

test_that("lives_in_msa meets specifications on standard input", {
    test <- lives_in_msa(san_francisco)
    test %>% uses_table("d_bio_address_mv")
    test %>% id_of_type("entity_id")
    test %>% id_field_is("entity_id")

    test %>%
        has_filters(geo_metro_area_code = "41860",
                    addr_type_code = "H")

    test %>% has_clause_count(2)

})

test_that("lives_in_msa meets specifications on no input", {
    lives_in_msa() %>%
        has_clause_count(2)

    lives_in_msa() %>%
        has_filters(addr_type_code = "H")
})

