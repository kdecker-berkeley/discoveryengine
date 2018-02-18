#' @rdname giving
#' @export
gave_to_purpose <- function(..., at_least = 0.01, from = NULL,
                              to = NULL) {
    purps <- prep_dots(...)
    reroute(gave_to_purpose_(purps, at_least = at_least,
                             from = from, to = to))
}

gave_to_purpose_ <- function(purps, at_least = 0.01, from = NULL, to = NULL) {
    funds <- fund_purpose_(purps)
    gave_to_fund(funds, at_least = at_least, from = from, to = to)
}
