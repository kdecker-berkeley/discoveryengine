widget_df <- function() {
    filename <- systemfile("extdata", "widget_finder.csv",
                           package = "discoveryengine")
    readcsv(filename, stringsAsFactors = FALSE)
}

#' Look for widgets using keywords
#'
#' @param search_term a string to search for in the widget registry
#'
#' @examples widget_for("sports")
#'
#' @seealso \code{\link{show_widgets}} for an interactive widget browser
#' @export
widget_for <- function(search_term = ".*") {
    assertthat::assert_that(assertthat::is.string(search_term))
    directory <- widget_df()

    search_fields <- c("widget_name", "description", "key_words")

    indices <- lapply(search_fields, function(search_field)
        grep(search_term, directory[[search_field]], ignore.case = TRUE))

    indices <- Reduce(base::union, indices, init = character(0))

    if (length(indices) == 0L)
        warning("No widgets found for '", search_term, "'",
                call. = FALSE)
    res <- directory[indices, , drop = FALSE]
    structure(dplyr::arrange(res, widget_name),
              class = c("widget_for", class(res)))
}

#' @export
print.widget_for <- function(res, ...) {
    for (index in seq_len(nrow(res))) {
        widget <- res[index, "widget_name", drop = TRUE]
        description <- res[index, "description", drop = TRUE]
        id_type <- res[index, "ID.type", drop = TRUE]
        cat(widget, ":\n    ", description, " (type: ", id_type, ")\n", sep = "")
    }
    invisible(res)
}

#' Browse the widget registry
#'
#' Pops up an interactive table that allows you to sort and search through a
#' listing of all available widgets, with descriptions of each
#'
#' @seealso \code{\link{widget_for}}
#' @export
show_widgets <- function() {
    if (!requireNamespace("DT", quietly = TRUE)) {
        stop('DT package needed for show_widgets to work.\n',
             'To install: install.packages("DT")',
             call. = FALSE)
    }

    widget_list <- widget_df()
    DT::datatable(widget_list, rownames = FALSE, fillContainer = FALSE,
                  options = list(
                      order = list(list(1, "asc"))
                  ))
}
