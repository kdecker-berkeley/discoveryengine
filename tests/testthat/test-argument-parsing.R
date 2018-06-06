context("argument parsing in widgets")

test_that("entity id param-based widgets error on unrecognized arguments", {
    # see issue 69
    expect_error(entity_id_param(1234, arg = "hi"), "Unrecognized argument")
    expect_error(contact_credit(1234, from = 20150101), "Unrecognized argument")
})

test_that("regex param based widgets error on unrecognized arguments", {
    # see issue 69
    expect_error(contact_text_contains("peace", from = 20150101), "Unrecognized argument")
    expect_error(fund_text_contains("abcd", from = 20150101), "Unrecognized argument")
    expect_error(job_title_like("doctor", arg = "bloop"), "Unrecognized argument")
})

test_that("other widgets error on unrecognized arguments", {
    expect_error(has_interest(music, arg = "bloop"), "Unrecognized argument")
    expect_error(has_reunion_year(1998, arg = "bloop"), "Unrecognized argument")
    expect_error(gave_to_fund(F773737, arg = "bloop"), "Unrecognized argument")
})
