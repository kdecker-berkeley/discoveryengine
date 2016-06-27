context("has_philanthropic_affinity specifications")
source("helpers.R")
library(magrittr)

test_that("has_philanthropic_affinity meets specifications on standard input", {
    test <- has_philanthropic_affinity(SCE, TEC)
    test %>% uses_table("d_oth_phil_affinity_mv")
    test %>% id_of_type("entity_id")
    test %>% id_field_is("entity_id")

    test %>%
        has_filters(other_affinity_type = c("SCE", "TEC"))

    test %>% has_clause_count(2)

})

test_that("has_philanthropic_affinity meets specifications on no input", {
    has_philanthropic_affinity() %>%
        has_clause_count(1)
})
