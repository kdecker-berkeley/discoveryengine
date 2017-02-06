context("synonym correctness")

library(dplyr)
library(magrittr)
library(getcdw)
library(tidyr)

test_that("All widgets have synonym lists", {
    safecall <- function(fun, args) {
        fun <- get(fun, asNamespace("discoveryengine"))
        res <- tryCatch(do.call(fun, args),
                        error = function(e) NULL)

        if (is.null(res)) return("No synonyms")
        if (inherits(res, "listbuilder")) return("listbuilder")
        if (inherits(res, "data.frame")) return("synonymlist")
    }

    missing_synonyms <- tbl_df(widget2cdw()) %>%
        "$"(widget) %>%
        vapply(safecall, FUN.VALUE = character(1), list(quote(?synonyms))) %>%
        Filter(function(widget) widget != "synonymlist", .)

    expect_length(missing_synonyms, 0)
})

test_that("Synonym tables include all current tms codes", {
    # build widget_map, which shows widget names along with
    # associated tms_view name
    widget_to_col <- tbl_df(widget2cdw())
    col_to_tms <- tbl_df(cdw_tms_dictionary())

    col_to_tms %<>% mutate(cdw_column_name = tolower(cdw_column_name))

    widget_map <- widget_to_col %>%
        inner_join(col_to_tms, by = c("cdw_column" = "cdw_column_name")) %>%
        select(widget, tms) %>% distinct

    # tms_synonyms() builds a synonym table using tms table
    build_synonyms_for <- parameterize_template("tms-synonym-builder.sql")


    tms_synonyms <- function(tms) {
        get_cdw(build_synonyms_for(tms)) %>%
            rename(synonym = syn)}

    actual_missing <- widget_map %>%
        mutate(auto_synonyms = lapply(tms, tms_synonyms)) %>%
        mutate(actual_synonyms = lapply(widget, do.call, list(quote(?synonyms)))) %>%
        transmute(widget, not_implemented = Map(dplyr::setdiff, auto_synonyms, actual_synonyms)) %>%
        mutate(ni_cnt = vapply(not_implemented, nrow, integer(1))) %>%
        unnest %>% select(widget, synonym, code)

    msg <- paste("missing", nrow(actual_missing), "synonyms")

    expect(nrow(actual_missing) == 0L, msg)
})
