uses_table <- function(lb, table) {
    expect_equal(lb$table, table)
}

id_of_type <- function(lb, id_type) {
    expect_equal(listbuilder::get_id_type(lb), id_type)
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
