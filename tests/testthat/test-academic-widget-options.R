context("academic widget options")
source("helpers.R")
library(magrittr)

test_that("can pull current students", {
    has_degree_from(current_students = TRUE, degreeholders = FALSE) %>%
        has_filters(institution_code = c("004833", "0A4833"),
                    non_grad_code = c("C", "N", "R"),
                    degree_level_code = c("A", "L"))

    has_degree_from(current_students = TRUE, degreeholders = FALSE,
                    graduates = FALSE) %>%
        has_filters(institution_code = c("004833", "0A4833"),
                    non_grad_code = c("C", "N", "R"),
                    degree_level_code = "A")

    majored_in(attendees = TRUE) %>%
        has_filters(institution_code = c("004833", "0A4833"),
                    degree_level_code = c("U", "A", "G", "L", "V", "P"))

    has_degree(attendees = TRUE, degreeholders = FALSE) %>%
        has_filters(institution_code = c("004833", "0A4833"),
                    degree_level_code = c("A", "L", "V", "P"))
})
