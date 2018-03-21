context("regex city/comment switches")
source("helpers.R")
library(magrittr)

test_that("can use city in foreign country searches", {
    nocity <- lives_in_foreign_country(KORER)
    city <- lives_in_foreign_country(KORER, city = "Seoul")

    expect_is(nocity, "listbuilder")
    expect_is(city, "listbuilder")

    # "city" should have one extra where clause
    expect_equal(length(city$where), length(nocity$where) + 1)

    extra_clause <- setdiff(city$where, nocity$where)[[1]]
    expect_identical(extra_clause[[1]], quote(REGEXP_LIKE))
    expect_identical(extra_clause[[2]], quote(foreign_cityzip))
    expect_identical(extra_clause[[3]], "((^|\\s|\\W)Seoul($|\\s|\\W))")

    expect_is(works_in_foreign_country(KORER), "listbuilder")
    expect_is(works_in_foreign_country(KORER, city = "Seoul"), "listbuilder")
})

test_that("has_interest comment search works", {
    nocomment <- has_interest(MTA)
    comment <- has_interest(MTA, comment = "judo")

    expect_equal(length(nocomment$where) + 1, length(comment$where))
})
