widget2cdw <- function() {
    widget_field <- function(widget) {
        res <- tryCatch(make_field_request(widget),
                        error = function(e) "")
        if (is.character(res) && length(res) == 1L)
            return(res)
        else return("")
    }

    widget_df <- widget_df()
    widgets <- widget_df$widget_name
    widget_map <- vapply(widgets, widget_field, FUN.VALUE = character(1))
    widget_map <- widget_map[widget_map != ""]
    widget_map <- data.frame(widget = names(widget_map),
                             cdw_column = unname(widget_map),
                             stringsAsFactors = FALSE)
    widget_map <-
        dplyr::inner_join(widget_df, widget_map,
                          by = c("widget_name" = "widget"))
    dplyr::select(widget_map,
                 widget = widget_name,
                 cdw_column,
                 id_type = ID.type,
                 order = Order)
}

every_code <- function() {
    all_tms <- names(code_xref)
    all_tables <- lapply(all_tms, function(tms) getcdw::get_cdw(code_query(tms)))
    res <- Reduce(dplyr::union, all_tables)
    res[, c("code", "description", "table_name", "view_name"), drop = FALSE]
}


#' Suggest widgets and codes based on search terms
#'
#' The \code{brainstorm_bot} takes one or more search terms and searches
#' through all code tables in CADS. If any of the codes it finds happen to be
#' covered by a discoveryengine widget, it brings them back and suggests them.
#'
#' @param ... terms to search for
#'
#' @details Enter any number of search terms. Each search term must appear in
#' quotation marks. A search term can begin or end with an asterisk, which denotes
#' a wildcard character. For instance, "basket" will match the code for "basket weaving"
#' but not "basketball." A search for "basket*" on the other hand will find both.
#'
#' @examples
#' ## search for a single term like this
#' brainstorm_bot("neuroscience")
#'
#' ## can also use wildcards at start and end of words:
#' brainstorm_bot("neuro*")
#'
#' ## or use multiple search terms
#' brainstorm_bot("neuro*", "robotics")
#'
#' @export
brainstorm_bot <- function(...) {
    search_terms <- as.character(unlist(list(...)))

    processed_search_string <- make_regex(search_terms)
    all_codes <- every_code()
    codes <- dplyr::filter(all_codes,
                           stringr::str_detect(description,
                                               stringr::regex(processed_search_string,
                                                     ignore_case = TRUE)))

    errormsg <- paste("Bleep bloop. Sorry, brainstorm bot couldn't find ",
                      paste("'", search_terms, "'", sep = "", collapse = ", "),
                      sep = "")

    if (nrow(codes) == 0L) stop(errormsg, call. = FALSE)

    tmsmap <- tms2cdw(unique(codes$view_name))
    if (nrow(tmsmap) == 0L) stop(errormsg, call. = FALSE)

    tmsmap <- as.data.frame(lapply(tmsmap, tolower), stringsAsFactors = FALSE)
    widgetmap <- widget2cdw()

    bigmap <- dplyr::inner_join(widgetmap, tmsmap,
                                by = c("cdw_column" = "cdw_column_name"))
    bigmap <- dplyr::filter(bigmap, id_type == "entity_id")

    if (nrow(bigmap) == 0L) stop(errormsg, call. = FALSE)

    bigmap <- dplyr::inner_join(bigmap, codes, by = c("tms" = "view_name"))
    bigmap <- dplyr::distinct(dplyr::select(bigmap, widget, code, description))
    bigmap <- split(bigmap, bigmap$widget)

    stopifnot(length(bigmap) > 0L)

    lblist <- Map(function(fun, df)
        do.call(fun, list(df[["code"]])),
        names(bigmap), bigmap)


    lb <- Reduce(`%or%`, lblist)
    structure(lb,
              brainstorm_results = bigmap,
              class = c("brainstorm", class(lb)))
}

tms2cdw <- function(tms_views) {
    stopifnot(inherits(tms_views, "character"))
    stopifnot(length(tms_views) > 0L)

    dictionary <- cdw_tms_dictionary()
    dplyr::filter(dictionary, tms %in% tms_views)
}


cdw_tms_dictionary <- function() {
    filename <- systemfile("extdata", "cdw_tms_dictionary.csv",
                           package = "discoveryengine")
    readcsv(filename, stringsAsFactors = FALSE)
}

#' @export
print.brainstorm <- function(bigmap, ...) {
    printres <- function(df) {
        cat(df[["widget"]][[1]], "\n")
        codes <- df$code
        descr <- df$description
        for (index in seq_along(codes))
            cat("    ", codes[[index]], ": ", descr[[index]], "\n", sep = "")
    }

    lapply(attr(bigmap, "brainstorm_results"), printres)
    invisible(bigmap)
}
