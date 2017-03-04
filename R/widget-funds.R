#' @rdname manual
#' @export
funds <- function(...) {
    reroute(funds_(prep_dots(...)))
}

funds_ <- function(ids) {
    ids <- partial_sub(ids)
    listbuilder::idlist(
        ids = as.character(ids),
        id_type = "allocation_code",
        quoted = TRUE
    )
}
