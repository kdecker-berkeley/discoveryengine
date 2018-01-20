context("synonym correctness")

library(dplyr)
library(magrittr)
library(getcdw)
library(tidyr)

test_that("All widgets have synonym lists", {
    dict <- cdw_tms_dictionary()
    safecall <- function(fun) {
        tryCatch(make_field_request(fun),
                 error = function(e) "ignore")
    }

    code_cols <- tbl_df(widget2cdw()) %>%
        mutate(field = vapply(widget, safecall, FUN.VALUE = character(1),
                              USE.NAMES = FALSE))

    comp <- code_cols %>%
        left_join(dict %>% mutate(cdw_column_name = tolower(cdw_column_name) ),
                  by = c("field" = "cdw_column_name"))

    problems <- comp %>%
        select(widget, tms) %>%
        distinct %>% group_by(widget) %>% summarise(tms_cnt = n_distinct(tms)) %>%
        filter(tms_cnt != 1)

    expect_equal(nrow(problems), 0)
})

# this test is no longer necessary, since this is how the syn. tables are built
# test_that("Synonym tables include all current tms codes", {
#     # build widget_map, which shows widget names along with
#     # associated tms_view name
#     widget_to_col <- tbl_df(widget2cdw())
#     col_to_tms <- tbl_df(cdw_tms_dictionary())
#
#     col_to_tms %<>% mutate(cdw_column_name = tolower(cdw_column_name))
#
#     widget_map <- widget_to_col %>%
#         inner_join(col_to_tms, by = c("cdw_column" = "cdw_column_name")) %>%
#         select(widget, tms) %>% distinct
#
#     # tms_synonyms() builds a synonym table using tms table
#     build_synonyms_for <- parameterize_template("tms-synonym-builder.sql")
#
#
#     tms_synonyms <- function(tms) {
#         get_cdw(build_synonyms_for(tms)) %>%
#             rename(synonym = syn)}
#
#     actual_missing <- widget_map %>%
#         mutate(auto_synonyms = lapply(tms, tms_synonyms)) %>%
#         mutate(actual_synonyms = lapply(widget, do.call, list(quote(?synonyms)))) %>%
#         transmute(widget, not_implemented = Map(dplyr::setdiff, auto_synonyms, actual_synonyms)) %>%
#         mutate(ni_cnt = vapply(not_implemented, nrow, integer(1))) %>%
#         unnest %>% select(widget, synonym, code)
#
#     msg <- paste("missing", nrow(actual_missing), "synonyms")
#
#     expect(nrow(actual_missing) == 0L, msg)
# })
