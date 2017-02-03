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


# note: fixed! synonyms that -> multiple codes now grab all
# test_that("A synonym can only map to a single code", {
#     multi <- function(fun) {
#         fun <- get(fun, asNamespace("discoveryengine"))
#         res <- tryCatch(do.call(fun, list(quote(?synonyms))),
#                         error = function(e) NULL)
#         if (is.null(res)) return(0L)
#         if (inherits(res, "listbuilder")) return(0L)
#         if (!inherits(res, "data.frame")) stop("what the?")
#
#         require(dplyr)
#         group_by(res, synonym) %>% filter(n() > 1) %>% nrow
#     }
#
#     widgets_with_duplicate_synonyms <- tbl_df(widget2cdw()) %>%
#         filter(widget != "attended_event") %>%
#         "$"(widget) %>%
#         vapply(multi, integer(1)) %>%
#         Filter(function(dupes) dupes > 0, .)
#
#     expect_length(widgets_with_duplicate_synonyms, 0L)
# })


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
#     # there are some codes that are WRONG in the tms tables,
#     # don't want those to count
#     expected_missing <- bind_rows(
#         data_frame(
#             widget = "participated_in",
#             synonym = "casa_joaquin_murrieta",
#             code = "EIJ"),
#         data_frame(
#             widget = "majored_in",
#             synonym = c("undeclared", "asian_studies_iii_southeast_asia",
#                         "science_math_education"),
#             code = c("000", "098", "24902")
#         ),
#         data_frame(
#             widget = "works_in_industry",
#             synonym = c("promoters_of_performing_arts_sports_an",
#                         "promoters_of_performing_arts_sports_an",
#                         "general_freight_trucking_long_distance",
#                         "general_freight_trucking_long_distance",
#                         "specialized_freight_except_used_goods",
#                         "specialized_freight_except_used_goods"),
#             code = c("711310", "711320",
#                      "484122", "484121",
#                      "484220", "484230")
#         )
#     )
#
#     actual_missing <- widget_map %>%
#         #filter(!widget %in% c("attended_event", "lives_in_msa", "works_in_msa")) %>%
#         mutate(auto_synonyms = lapply(tms, tms_synonyms)) %>%
#         mutate(actual_synonyms = lapply(widget, do.call, list(quote(?synonyms)))) %>%
#         transmute(widget, not_implemented = Map(dplyr::setdiff, auto_synonyms, actual_synonyms)) %>%
#         mutate(ni_cnt = vapply(not_implemented, nrow, integer(1))) %>%
#         filter(ni_cnt > 0) %>% unnest %>% select(widget, synonym, code)
#
#     missing_synonyms <- dplyr::setdiff(actual_missing, expected_missing)
#
#     missing_syn_msg <- paste("these synonyms are missing: ",
#                              paste(missing_synonyms$synonym,
#                                    " (", missing_synonyms$widget, ")",
#                                    collapse = ", "), sep = "")
#     expect(nrow(missing_synonyms) == 0L, missing_syn_msg)
# })
