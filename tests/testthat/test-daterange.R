context("daterange switch-builder works")

test_that("daterange is NULL if from/to are both NULL", {
    expect_null(daterange("dummy", from = NULL, to = NULL))
})

test_that("daterange is 'between from and to' if both dates exist", {
    expect_identical(
        daterange("dummy", from = 20100101, to = 20111231),
        quote(between(
            dummy,
            to_date(20100101L, "yyyymmdd"),
            to_date(20111231L, "yyyymmdd")))
    )
})

test_that("daterange is '>= from' if only from exists", {
    expect_identical(
        daterange("dummy", from = 20100101, to = NULL),
        quote(dummy >= to_date(20100101L, "yyyymmdd"))
    )
})

test_that("daterange is '<= to' if only to exists", {
    expect_identical(
        daterange("dummy", from = NULL, to = 20100101),
        quote(dummy <= to_date(20100101L, "yyyymmdd"))
    )
})

test_that("daterange errors on bad dates", {
    expect_error(
        daterange("dummy", from = NULL, to = 20100132),
        regexp = "not a valid date"
    )

    expect_error(
        daterange("dummy", from = NULL, to = 201),
        regexp = "not a valid date"
    )

    expect_error(
        daterange("dummy", from = NULL, to = "abcd"),
        regexp = "not a valid date"
    )

    expect_error(
        daterange("dummy", from = 105, to = 275),
        regexp = "not a valid date"
    )
})

test_that("daterange allows weirdo sql instead of a field name", {
    expect_identical(
        daterange(dbplyr::sql("case when x > 0 then 1 else 0 end"),
                  from = 20110101, to = 20121231),
        as.call(list(
            quote(between),
            dbplyr::sql("case when x > 0 then 1 else 0 end"),
            quote(to_date(20110101L, "yyyymmdd")),
            quote(to_date(20121231L, "yyyymmdd"))
        ))
    )
})
