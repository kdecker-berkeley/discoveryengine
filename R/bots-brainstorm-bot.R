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


#' Suggest widgets and codes based on search terms
#'
#' The \code{brainstorm_bot} takes one or more search terms and searches
#' through all code tables in CADS. If any of the codes it finds happen to be
#' covered by a discoveryengine widget, it brings them back and suggests them.
#'
#' @param ... terms to search for
#'
#' @examples
#' ## search for a single term like this
#' brainstorm_bot("neuroscience")
#'
#' ## can also use wildcards at start and end of words:
#' brainstorm_bot("neruo*")
#'
#' ## or use multiple search terms
#' brainstorm_bot("neuro*", "robotics")
#'
#' @export
brainstorm_bot <- function(...) {
    brainstorm_bot_(prep_dots(...))
}

brainstorm_bot_ <- function(search_terms) {
    search_terms <- partial_sub(search_terms)
    search_terms <- trimws(search_terms)

    processed_search_string <- make_regex(search_terms)
    codes <- getcdw::find_codes(processed_search_string)

    errormsg <- paste("Bleep bloop. Sorry, brainstorm bot couldn't find ",
                      paste("'", search_terms, "'", sep = "", collapse = ", "),
                      sep = "")

    if (nrow(codes) == 0L) stop(errormsg, call. = FALSE)

    tmsmap <- tms2cdw(unique(codes$view_name))
    if (nrow(tmsmap) == 0L) stop(errormsg, call. = FALSE)

    tmsmap <- dplyr::mutate_each(tmsmap, dplyr::funs(tolower))
    widgetmap <- widget2cdw()

    bigmap <- dplyr::inner_join(widgetmap, tmsmap,
                                by = c("cdw_column" = "cdw_column_name"))

    if (nrow(bigmap) == 0L) stop(errormsg, call. = FALSE)

    bigmap <- dplyr::inner_join(bigmap, codes, by = c("tms" = "view_name"))
    bigmap <- dplyr::distinct(dplyr::select(bigmap, widget, code, description))
    bigmap <- split(bigmap, bigmap$widget)

    stopifnot(length(bigmap) > 0L)

    lblist <- Map(function(fun, df)
        do.call(fun, list(df[["code"]])),
        names(bigmap), bigmap)

    lb <- lblist[[1]]
    lb <- Reduce(`%or%`, lblist[-1], init = lb)
    structure(lb,
              brainstorm_results = bigmap,
              class = c("brainstorm", "listbuilder", class(bigmap)))
}

tms2cdw <- function(tms_views) {
    stopifnot(inherits(tms_views, "character"))
    stopifnot(length(tms_views) > 0L)

    dictionary <- cdw_tms_dictionary()
    dplyr::filter(dictionary, tms %in% tms_views)
}


cdw_tms_dictionary <- function() {
    filename <- system.file("extdata", "cdw_tms_dictionary.csv",
                            package = "discoveryengine")
    read.csv(filename, stringsAsFactors = FALSE)
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
