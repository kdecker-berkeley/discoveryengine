#' Retrieve a list of IDs from a listbuilder definition
#'
#' @param include_organizations Should the list include organizations? (Defaults to FALSE)
#' @param include_deceased Should the list include the deceased? (Defaults to FALSE)
#' @param household Should the list be householded? (Defaults to FALSE)
#' @param file If you want to export the IDs to a text file, enter the name of the
#' file you wish to create. If NULL (the default), then the IDs will not be written
#' to a file.
#'
#' @export
display <- function(savedlist, ...) UseMethod("display")

#' @export
#' @rdname display
display.listbuilder <- function(savedlist, ...,
                    include_organizations = FALSE,
                    include_deceased = FALSE,
                    household = FALSE,
                    file = NULL) {

    # ignore "include" options if list not entity IDs
    if (listbuilder::get_id_type(savedlist) != "entity_id")
        spec <- savedlist
    else
        spec <- modify(savedlist, include_organizations,
                       include_deceased, household)

    res <- get_cdw(spec, ...)
    if (is.null(file)) return(res)

    assertthat::assert_that(assertthat::is.string(file))

    # if filename does not have a ".csv" extension, add one
    if (!grepl("\\.csv$", file))
        filename <- paste0(file, ".csv")
    else filename <- file

    write.csv(res, filename, row.names = FALSE)
}

#' @export
#' @rdname display
display.report <- function(report, ...,
                           include_organizations = FALSE,
                           include_deceased = FALSE,
                           household = FALSE,
                           file = NULL) {

    if (listbuilder::get_id_type(report) != "entity_id")
        spec <- report
    else
        spec <- modify(report, include_organizations,
                       include_deceased, household)

    res <- get_cdw(spec, ...)

    column_formats <- attr(report, "column_formats")
    res <- reformat_columns(res, column_formats)

    if (is.null(file)) return(res)

    assertthat::assert_that(assertthat::is.string(file))

    # if filename does not have a ".csv" extension, add one
    if (!grepl("\\.csv$", file))
        filename <- paste0(file, ".csv")
    else filename <- file
    write.csv(res, filename, row.names = FALSE)
}

modify <- function(savedlist, include_organizations,
                      include_deceased, household) {
    if (include_organizations)
        entity_type <- c("P", "O")
    else entity_type <- "P"

    added_piece <- is_a_(entity_type, include_deceased = include_deceased)
    individuals <- savedlist %and% added_piece

    if (household) return(household(individuals))
    else return(individuals)
}
