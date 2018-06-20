context("ca_gave_to_candidate specifications")
source("helpers.R")
library(magrittr)

test_that("ca_gave_to_candidate meets specifications on standard input", {
    test <- ca_gave_to_candidate(CA919925929, CA2604502777, CA1303768232)
    test %>% uses_table("ca_campaign")
    test %>% id_of_type("entity_id")
    test %>% id_field_is("entity_id")

    test$rhs %>%
        has_filters(candidate_id = c("CA919925929", "CA2604502777", "CA1303768232"))
})
