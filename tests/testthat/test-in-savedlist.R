context("savedlist specifications")

checker <- function(lb, lists) {
    test_sql <- stringr::str_to_lower(stringr::str_replace_all(to_sql(lb), "\\s+", " "))

    expected_sql <- getcdw::parameterize_template("select distinct entity_id from (
                                                  select entity_id as entity_id
                                                  from (
                                                  select list_id, to_number(trim(subject_id)) as entity_id
                                                  from cdw.sa_subject_key_mv
                                                  where subject_type = 'E' and regexp_like(trim(subject_id), '^[0-9]+$')
                                                  ) ##wherepart##
    )")

    if (length(lists) == 0L) wherepart <- "" else wherepart = paste0("where list_id IN (", paste(lists, collapse = ", "), ")")
    expected_sql <- expected_sql(wherepart = wherepart)
    expected_sql <- stringr::str_to_lower(stringr::str_replace_all(
        expected_sql, "\\s+", " "
    ))
    expect_identical(test_sql, expected_sql)
}

test_that("in_savedlist meets specifications", {
    test <- in_savedlist(25730, 23346)
    checker(test, c(25730, 23346))

    test <- in_savedlist()
    checker(test, NULL)

    test <- in_savedlist(24867)
    checker(test, 24867)
})
