context("code validation within string widgets")
source("helpers.R")
library(magrittr)

test_that("can't use a non-existent ", {
    testthat::expect_error(contact_purpose(VISIT), "unrecognized contact_purpose_code")
})
