context("participated_in specifications")
source("helpers.R")
library(magrittr)

test_that("participated_in meets specifications on standard input", {
    test <- participated_in(USOJ, USJP)
    test %>% uses_table("d_bio_student_activity_mv")
    test %>% id_of_type("entity_id")
    test %>% id_field_is("entity_id")

    test %>%
        has_filters(student_activity_code = c("USOJ", "USJP"),
                    student_particip_code = c("P", "L"))

    test %>% has_clause_count(2)
})

test_that("participated_in meets specifications on no input", {
    participated_in() %>%
        has_clause_count(1)
    participated_in() %>%
        has_filters(student_particip_code = c("P", "L"))
})

