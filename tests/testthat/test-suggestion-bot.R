context("suggestion_bot")

test_that("suggestion_bot returns a list", {
    expect_is(suggestion_bot("neuroscience"), "list")
})

test_that("suggestion_bot is case insensitive", {
    expect_identical(suggestion_bot("neuroscience"),
                     suggestion_bot("NEUROSCIENCE"))
})

test_that("suggestion_bot gives error when no matches", {
    expect_error(suggestion_bot("xyz"), "couldn't find")
})
