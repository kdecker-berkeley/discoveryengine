context("Manual ID lists")

test_that("Can make handmade lists of funds and entities", {
    ents <- entities(1234, 5679)
    allocs <- funds(AB1234, FW2837)
    expect_is(ents, "listbuilder")
    expect_is(allocs, "listbuilder")
})
