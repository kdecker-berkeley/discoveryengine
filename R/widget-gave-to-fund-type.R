#' @rdname giving
#' @export
gave_to_fund_type <- function(..., at_least = 0.01, from = NULL,
                              to = NULL) {
    types <- prep_dots(...)
    reroute(gave_to_fund_type_(types, at_least = at_least,
                               from = from, to = to))
}

gave_to_fund_type_ <- function(types, at_least = 0.01, from = NULL, to = NULL) {
    if (!is.numeric(at_least)) stop("at_least must be a number")
    if (length(at_least) != 1L) stop("need a single amount for at_least")

    funds <- fund_type_(types)
    gave_to_fund(funds, at_least = at_least, from = from, to = to)
}
