context("Reject unknown parameters")

test_that("in_development_officer does not respond to include_active", {
    expect_error(
        in_development_officer_portfolio(1234,
                                         include_inactive = FALSE,
                                         include_active = TRUE),
        regexp = "Unrecognized argument")

})

test_that("in_unit_portfolio does not respond to include_active", {
    expect_error(
        in_unit_portfolio(SW, LW,
                          include_inactive = FALSE,
                          include_active = TRUE),
        regexp = "Unrecognized argument")

})
