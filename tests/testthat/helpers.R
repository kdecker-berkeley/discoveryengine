library(listbuilder)
uses_table <- function(lb, table) {
    expect_equal(tolower(get_table(lb)), tolower(table))
}

id_field_is <- function(lb, id_type) {
    expect_equal(tolower(get_id_field(lb)), tolower(id_type))
}

id_of_type <- function(lb, id_type) {
    expect_equal(get_id_type(lb), id_type)
}

filters_on <- function(lb, desired_fields) {
    desired_fields <- as.list(desired_fields)
    expect_equal(length(lb$where), length(desired_fields))
    actual_fields <- lapply(lb$where, "[[", 2)

    extra_desired <- setdiff(desired_fields, actual_fields)
    extra_actual <- setdiff(actual_fields, desired_fields)

    expect_identical(extra_desired, list())
    expect_identical(extra_actual, list())
}

has_filters <- function(lb, ...) {
    expected <- list(...)
    expected_field_names <- names(expected)
    if (any(nchar(expected_field_names) < 1))
        stop("all arguments must be named")

    expected_values <- unname(expected)

    logic <- c(get_where(lb), get_having(lb))

    # this test is just for the x %in% y or x == y variety
    testlogic <- Filter(function(x) deparse(x[[1]]) %in% c("%in%", "=="), logic)

    expect_identical(length(expected), length(testlogic))

    for (i in seq_along(expected)) {
        current <- Filter(function(x) deparse(x[[2]]) == expected_field_names[[i]],
                          testlogic)
        if (length(current) > 1) stop("multiple clauses with same field")
        actual_values <- current[[1]][[3]]
        expect_true(setequal(expected_values[[i]], actual_values))
    }
}

has_clause_count <- function(lb, expected) {
    logic <- c(get_where(lb), get_having(lb))
    expect_equal(length(logic), expected)
}
