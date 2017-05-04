context("matrix bot returns expected results")

test_that("matrix bot returns something when something is expected", {
    res <- matrix_bot(majored_in(mathematics))
    expect_is(res, "listbuilder")
})

test_that("matrix bot errors with a message when nothing should come up", {
    expect_error(matrix_bot(gave_to_area(CHAN), "didn't find anything"))
})
