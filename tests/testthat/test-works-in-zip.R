context("works_in_zip specifications")
source("helpers.R")
library(magrittr)

test_that("works_in_zip meets specifications on standard input", {
    test <- works_in_zip(94720, 00123)
    test %>% uses_table("d_bio_address_mv")
    test %>% id_of_type("entity_id")
    test %>% id_field_is("entity_id")

    test %>%
        has_filters(zipcode5 = c("94720", "00123"),
                    addr_type_code = "B")

    test %>% has_clause_count(2)

})

test_that("works_in_zip handles zipcodes with various formats", {
    works_in_zip(947041234, 00123-0001, "94744-1234", NA) %>%
        has_filters(zipcode5 = c("94704", "00123", "94744"),
                    addr_type_code = "B")
})

test_that("works_in_zip meets specifications on no input", {
    works_in_zip() %>%
        has_clause_count(1)

    works_in_zip() %>%
        has_filters(addr_type_code = "B")
})

