context("matrix bot returns expected results")

test_that("matrix bot returns something when something is expected", {
    #skip("skipping matrix bot test")
    res <- matrix_bot(majored_in(mathematics))
    expect_is(res, "listbuilder")
})

test_that("matrix bot errors with a message when nothing should come up", {
    #skip("skipping matrix bot test")
    expect_error(matrix_bot(gave_to_area(CHAN), "didn't find anything"))
})

test_that("matrix bot gives meaningful error message when non-entity definition is supplied", {
    #skip("skipping matrix bot test")
    expect_error(matrix_bot(contact_text_contains("neuro*")), "entity_id")
})
