context("sec_filed specifications")
source("helpers.R")
library(magrittr)

checker <- function(lb, wherestuff) {
    test_sql <- stringr::str_to_lower(stringr::str_replace_all(to_sql(lb), "\\s+", " "))

    expected_sql <- getcdw::parameterize_template("select distinct entity_id from (
        select sec_cik_dict.entity_id as entity_id
    from rdata.sec_cik_dict where cik in (
    select sec_hdr.cik as sec_cik
    from rdata.sec_hdr
    ##where##
    )
    )")

    if (nchar(trimws(paste(wherestuff, collapse = ""))) == 0L) where <- wherestuff else where <- paste0("where ", paste(wherestuff, collapse = " and "))
    expected_sql <- expected_sql(where = where)
    expected_sql <- stringr::str_to_lower(stringr::str_replace_all(
        expected_sql, "\\s+", " "
    ))
    expect_identical(test_sql, expected_sql)
}

test_that("sec_filed meets specifications on standard input", {
    test <- sec_filed(1418091, 1326801)
    checker(test, "issuer_cik in ('1418091', '1326801')")

    test <- sec_filed(1418091, ten_percenter = TRUE)
    checker(test, c("issuer_cik in ('1418091')",
                    "is_ten_percenter in (1)"))

    test <- sec_filed(1326801, title_text = "chairman")
    checker(test, c("issuer_cik in ('1326801')",
                    "regexp_like(officer_title || ' ' || other_text, '((^|\\\\s|\\\\W)chairman($|\\\\s|\\\\W))', 'i')"))
})

test_that("sec_filed meets specifications on no input", {
    test <- sec_filed()
    checker(test, "")

    test <- sec_filed(officer = TRUE)
    checker(test, "is_officer in (1)")

    test <- sec_filed(other = TRUE, title_text = "chairman")
    checker(test, c("is_other in (1)",
                    "regexp_like(officer_title || ' ' || other_text, '((^|\\\\s|\\\\W)chairman($|\\\\s|\\\\W))', 'i')"))
})
