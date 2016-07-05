context("contact_text_contains specifications")
source("helpers.R")
library(magrittr)

test_that("contact_text_contains meets specifications on standard input", {
    test <- contact_text_contains("neuro*", "brain")
    expect_is(test, "listbuilder")
    expect_is(test$lhs, "listbuilder")
    expect_is(test$rhs, "listbuilder")

    lhs <- test$lhs
    rhs <- test$rhs
    lhs %>% uses_table("f_contact_reports_mv")
    rhs %>% uses_table("f_contact_reports_mv")
    lhs %>% id_field_is("report_id")
    rhs %>% id_field_is("report_id")
    lhs %>% id_of_type("contact_report_id")
    rhs %>% id_of_type("contact_report_id")

    lhs %>% has_clause_count(1)
    rhs %>% has_clause_count(1)

    expect_null(lhs$having)
    expect_null(rhs$having)

    logic <- c(lhs$where, rhs$where)

    expect_identical(unique(lapply(logic, "[[", 1)), list(quote(regexp_like)))
})

test_that("contact_text_contains handles bad input", {
    expect_error(contact_text_contains(), "was unable to process")
    expect_error(contact_text_contains(""), "unable")
    expect_warning(contact_text_contains("ab*de", "hello"), "ignored")
    expect_error(contact_text_contains(" "), "was unable to process")
})
