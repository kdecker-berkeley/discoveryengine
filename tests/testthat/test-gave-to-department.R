context("gave_to_department specifications")
source("helpers.R")
library(magrittr)

test_that("gave_to_department meets specifications on standard input", {
    test <- gave_to_department(LHS, CALBAND)
    test %>% uses_table("f_transaction_detail_mv")
    test %>% id_of_type("entity_id")
    test %>% id_field_is("donor_entity_id_nbr")

    test %>%
        has_filters(alloc_dept_code = c("LHS", "CALBAND"),
                    pledged_basis_flg = "Y")

    test %>% has_clause_count(3)

})

test_that("gave_to_department meets specifications on no input", {
    gave_to_department(at_least = 1000, from = 20150101) %>%
        has_clause_count(3)

    gave_to_department() %>%
        has_clause_count(2)

    gave_to_department() %>%
        has_filters(pledged_basis_flg = "Y")
})
