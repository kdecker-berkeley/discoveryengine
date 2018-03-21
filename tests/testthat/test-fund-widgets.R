context("fund widgets")
source("helpers.R")
library(magrittr)

test_that("fund widgets create definitions of type 'allocation code'", {
    expect_is(fund_area(MPS), "listbuilder")
    expect_is(fund_department(JAZZ), "listbuilder")
    expect_is(fund_text_contains("ABC"), "listbuilder")
    expect_is(fund_type(E), "listbuilder")
    expect_is(fund_purpose(USS, BSS, GSS), "listbuilder")

    expect_equal(listbuilder::get_id_type(fund_area(MPS)), "allocation_code")
    expect_equal(listbuilder::get_id_type(fund_department(JAZZ)), "allocation_code")
    expect_equal(listbuilder::get_id_type(fund_text_contains("ABC")), "allocation_code")
    expect_equal(listbuilder::get_id_type(fund_type(E)), "allocation_code")
    expect_equal(listbuilder::get_id_type(fund_purpose(USS)), "allocation_code")
})

test_that("", {
    fund_area(MPS) %>%
        has_filters(area_of_giving_code = "MPS")

    fund_department(JAZZ) %>%
        has_filters(alloc_dept_code = "JAZZ")

    fund_type(E) %>%
        has_filters(fund_type_code = "E")

    fund_purpose(GSS) %>%
        has_filters(primary_purpose_code = "GSS")
})
