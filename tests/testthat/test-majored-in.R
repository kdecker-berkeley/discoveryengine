context("majored_in specifications")
source("helpers.R")
library(magrittr)

test_that("majored_in meets specifications on standard input", {
    test <- majored_in(540, 651, 084)
    test %>% uses_table("d_bio_degrees_mv")
    test %>% id_of_type("entity_id")
    test %>% id_field_is("entity_id")

    test %>%
        has_filters(local_ind = "Y",
                    major_code1 = c("540", "651", "084"),
                    degree_level_code = c("U", "G"))

    test %>% has_clause_count(3)

})

test_that("majored_in meets specifications on no input", {
    majored_in() %>%
        has_clause_count(2)
    majored_in() %>% uses_table("d_bio_degrees_mv")
    majored_in() %>% has_filters(local_ind = "Y",
                                 degree_level_code = c("U", "G"))
})
