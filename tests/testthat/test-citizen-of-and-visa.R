context("citizenship and visa widgets")
source("helpers.R")
library(magrittr)

test_that("citizen_of meets specifications on standard input", {
    test <- citizen_of(CHINA, SINGA)
    expect_is(test, "listbuilder")

    lhs <- test$lhs
    rhs <- test$rhs
    lhs %>% uses_table("d_entity_mv")
    lhs %>% id_of_type("entity_id")
    lhs %>% id_field_is("entity_id")

    rhs %>% uses_table("d_entity_mv")
    rhs %>% id_of_type("entity_id")
    rhs %>% id_field_is("entity_id")


    lhs %>% has_filters(citizen_cntry_code1 = c("CHINA", "SINGA"))
    rhs %>% has_filters(citizen_cntry_code2 = c("CHINA", "SINGA"))
})

test_that("has_citizenship meets specifications on no input", {
    test <- citizen_of()
    expect_is(test, "listbuilder")

    sql <- to_sql(test)
    expect_match(sql, "TRIM\\(citizen_cntry_code1\\) IS NOT null")
    expect_match(sql, "TRIM\\(citizen_cntry_code2\\) IS NOT null")
})

test_that("has_visa meets specifications on standard input", {
    test <- has_visa(F1)
    expect_is(test, "listbuilder")

    test %>% uses_table("d_entity_mv")
    test %>% id_of_type("entity_id")
    test %>% id_field_is("entity_id")

    test %>% has_filters(religion_code = c("F1"))
})

test_that("has_visa meets specifications on no input", {
    test <- has_visa()
    expect_is(test, "listbuilder")

    sql <- to_sql(test)
    expect_match(sql, "TRIM\\(religion_code\\) IS NOT null")
})

