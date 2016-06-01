context("widgets return the expected data")
library(magrittr)
library(getcdw)
library(listbuilder)

should_contain <- function(predicate, ids) {
    expect_true(
        all(ids %in% predicate[[1]])
    )
}

should_not_contain <- function(predicate, ids) {
    expect_false(
        any(ids %in% predicate[[1]])
    )
}

test_that("has_capacity gets the right people", {
    hicap <- has_capacity(1) %>% get_cdw
    hicap %>% should_contain(22653)
    hicap %>% should_not_contain(640993)
})

test_that("has_degree_from gets the right people", {
    lsdegs <- has_degree_from(letters_and_science) %>% get_cdw
    lsdegs %>% should_contain(640993)
    lsdegs %>% should_not_contain(22653)
})

