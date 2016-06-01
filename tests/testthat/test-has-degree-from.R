context("has_degree_from specifications")

test_that("has_degree_from meets specifications on standard input", {
    test <- has_degree_from(BU, NR)

    # should pull entity_ids from d_bio_degrees_mv
    expect_equal(test$table, "d_bio_degrees_mv")
    expect_equal(test$id_field, "entity_id")
    expect_equal(test$id_type, "entity_id")

    # should have three where clauses, one for the degree school,
    # one for the degree_level, one for local_ind
    expect_equal(length(test$where), 3L)

    actual <- lapply(test$where, "[[", 2)
    desired <- list(quote(school_code), quote(degree_level_code), quote(local_ind))

    expect_true(setequal(actual, desired))
})

test_that("has_degree_from meets specifications on no input", {
    test <- has_degree_from()

    # in this case has_degree should only filter on degree_level_code
    # along with default local_ind == "Y"
    expect_equal(length(test$where), 2L)
})
