#' @rdname manual
#' @export
funds <- function(...) {
    reroute(funds_(prep_dots(...)))
}

funds_ <- function(ids) {
    ids <- partial_sub(ids)
    if (length(ids) <= 0) return(
        widget_builder(
            table = "f_allocation_mv",
            id_field = "allocation_code",
            id_type = "allocation_code"
        ))
    listbuilder::idlist(
        ids = as.character(unlist(ids)),
        id_type = "allocation_code",
        quoted = TRUE
    )
}
