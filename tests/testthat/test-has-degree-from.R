context("has_degree_from specifications")
source("helpers.R")
library(magrittr)

test_that("has_degree_from meets specifications on standard input", {
    test <- has_degree_from(BU, NR, undergraduates = TRUE, graduates = TRUE,
                            attendees = FALSE)
    test %>% uses_table("d_bio_degrees_mv")
    test %>% id_of_type("entity_id")
    test %>% id_field_is("entity_id")

    test %>%
        has_filters(school_code = c("NR", "BU"),
                    degree_level_code = c("U", "G"),
                    institution_code = c("004833", "0A4833"))

    has_degree_from(chemistry, undergraduates = TRUE,
                    graduates = FALSE, attendees = TRUE) %>%
        has_filters(school_code = "CH",
                    institution_code = c("004833", "0A4833"),
                    degree_level_code = c("U", "A"))

})

test_that("has_degree_from meets specifications on no input", {
    has_degree_from() %>%
        has_filters(institution_code = c("004833", "0A4833"),
                    degree_level_code = c("U", "G"))

    has_degree_from(graduates = FALSE) %>%
        has_filters(institution_code = c("004833", "0A4833"),
                    degree_level_code = "U")

    has_degree_from(attendees = TRUE) %>%
        has_filters(institution_code = c("004833", "0A4833"),
                    degree_level_code = c("U", "A", "G", "L", "V", "P"))
})
