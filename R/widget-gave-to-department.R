#' @rdname giving
#' @export
gave_to_department <- function(..., at_least = 0.01, from = NULL,
                         to = NULL) {
    depts <- prep_dots(...)
    reroute(gave_to_department_(depts, at_least = at_least,
                                from = from, to = to))
}

gave_to_department_ <- function(depts, at_least = 0.01, from = NULL, to = NULL) {
    funds <- fund_area_(depts)
    gave_to_fund(funds, at_least = at_least, from = from, to = to)
}
