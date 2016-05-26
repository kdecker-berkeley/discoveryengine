context("has_degree_from specifications")

test_that("has_degree_from meets specifications on standard input", {
    test <- has_degree_from(BU, NR)

    # should pull entity_ids from d_bio_degrees_mv
    expect_equal(test$table, "d_bio_degrees_mv")
    expect_equal(test$id_field, "entity_id")
    expect_equal(test$id_type, "entity_id")

    # should have two where clauses, one for the degree school,
    # one for the degree_level
    expect_equal(length(test$where), 2L)

    actual <- lapply(test$where, "[[", 2)
    desired <- list(quote(school_code), quote(degree_level_code))

    expect_equal(setdiff(actual, desired), list())
    expect_equal(setdiff(desired, actual), list())
})

test_that("has_degree_from meets specifications on no input", {
    test <- has_degree_from()

    # in this case has_degree should only filter on degree_level_code
    expect_equal(length(test$where), 1L)
    filter_field <- test$where[[1]][[2]]
    expect_identical(filter_field, quote(degree_level_code))
})
