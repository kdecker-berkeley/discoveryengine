context("fund widgets")
source("helpers.R")
library(magrittr)

test_that("fund widgets create definitions of type 'allocation code'", {
    expect_is(fund_area(ABC), "listbuilder")
    expect_is(fund_department(ABC), "listbuilder")
    expect_is(fund_text_contains("ABC"), "listbuilder")
    expect_is(fund_type(ABC), "listbuilder")
    expect_is(fund_purpose(ABC), "listbuilder")

    expect_equal(listbuilder::get_id_type(fund_area(ABC)), "allocation_code")
    expect_equal(listbuilder::get_id_type(fund_department(ABC)), "allocation_code")
    expect_equal(listbuilder::get_id_type(fund_text_contains("ABC")), "allocation_code")
    expect_equal(listbuilder::get_id_type(fund_type(ABC)), "allocation_code")
    expect_equal(listbuilder::get_id_type(fund_purpose(ABC)), "allocation_code")
})

test_that("", {
    fund_area(ABC) %>%
        has_filters(area_of_giving_code = "ABC")

    fund_department(ABC) %>%
        has_filters(alloc_dept_code = "ABC")

    fund_type(ABC) %>%
        has_filters(fund_type_code = "ABC")

    fund_purpose(ABC) %>%
        has_filters(primary_purpose_code = "ABC")
})
