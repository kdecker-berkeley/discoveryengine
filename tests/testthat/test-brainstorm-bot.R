context("brainstorm_bot")

test_that("brainstorm_bot returns a list", {
    expect_is(brainstorm_bot("neuroscience"), "listbuilder")
    expect_is(brainstorm_bot("neuroscience"), "brainstorm")
})

test_that("brainstorm_bot is case insensitive", {
    expect_identical(brainstorm_bot("neuroscience"),
                     brainstorm_bot("NEUROSCIENCE"))
})

test_that("brainstorm_bot gives error when no matches", {
    expect_error(brainstorm_bot("xyz"), "couldn't find")
})

test_that("brainstorm_bot knows about MSAs", {
    x <- brainstorm_bot("sacramento")
    res <- attr(x, "brainstorm_results")
    expect_true("works_in_msa" %in% names(res))
    expect_true("lives_in_msa" %in% names(res))
})
