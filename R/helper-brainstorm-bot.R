widget2cdw <- function() {
    widget_field <- function(widget) {
        res <- tryCatch(do.call(widget, list(quote(!field))),
                        error = function(e) "")
        if (is.character(res) && length(res) == 1L)
            return(res)
        else return("")
    }

    widgets <- widget_df()$widget_name
    widget_map <- vapply(widgets, widget_field, FUN.VALUE = character(1))
    widget_map <- widget_map[widget_map != ""]
    data.frame(widget = names(widget_map),
               cdw_column = unname(widget_map),
               stringsAsFactors = FALSE)
}


#' Suggest widgets and codes based on a search term
#'
#' The \code{brainstorm_bot} takes a search term and searches through all code
#' tables in CADS. If any of the codes it finds happen to be covered by a
#' discoveryengine widget, it brings them back and suggests them.
#'
#' @param search_term a single search term
#'
#' @examples brainstorm_bot("neuroscience")
#' @export
brainstorm_bot <- function(search_term) {
    assertthat::assert_that(assertthat::is.string(search_term))
    codes <- getcdw::find_codes(search_term)

    if (nrow(codes) == 0L)
        stop("Bleep bloop. Sorry, brainstorm bot couldn't find '",
             search_term, "'", call. = FALSE)

    tmsmap <- tms2cdw(unique(codes$view_name))
    if (nrow(tmsmap) == 0L)
        stop("Bleep bloop. Sorry, brainstorm bot couldn't find '",
             search_term, "'", call. = FALSE)
    tmsmap <- dplyr::mutate_each(tmsmap, dplyr::funs(tolower))
    widgetmap <- widget2cdw()

    bigmap <- dplyr::inner_join(widgetmap, tmsmap,
                                by = c("cdw_column" = "cdw_column_name"))
    if (nrow(bigmap) == 0L)
        stop("Bleep bloop. Sorry, brainstorm bot couldn't find '",
             search_term, "'", call. = FALSE)

    bigmap <- dplyr::inner_join(bigmap, codes, by = c("tms" = "view_name"))
    bigmap <- dplyr::select(bigmap, widget, code, description)
    bigmap <- split(bigmap, bigmap$widget)
    structure(bigmap, class = c("widget_suggestions", class(bigmap)))
}

tms2cdw <- function(tms_views) {
    stopifnot(inherits(tms_views, "character"))
    stopifnot(length(tms_views) > 0L)

    query <- "
select * from (
select distinct cdw_table_name, cdw_column_name,
trim(regexp_replace(data_description, '(.*)(tms_[a-z_]+)(.*$)', '\\2 ')) as tms
from cdw.d_data_dictionary_mv
where data_description like '%validated%tms_%'
) where tms in "

    tmslist <- paste("'", tms_views, "'", sep = "", collapse = ", ")
    tmslist <- paste("(", tmslist, ")", sep = "")

    query <- paste(query, tmslist)
    getcdw::get_cdw(query)
}

#' @export
print.widget_suggestions <- function(bigmap, ...) {
    printwidget <- function(df) {
        cat(df[["widget"]][[1]], "\n")
        codes <- df$code
        descr <- df$description
        for (index in seq_along(codes))
            cat("    ", codes[[index]], ": ", descr[[index]], "\n", sep = "")
    }

    lapply(bigmap, printwidget)
    invisible(bigmap)
}
