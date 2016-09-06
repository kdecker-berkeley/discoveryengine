#' @export
fund_miner <- function(..., at_least = .01, from = NULL, to = NULL) {
    reroute(fund_miner_(prep_dots(...),
            at_least = at_least, from = from, to = to))
}

fund_miner_ <- function(search_terms, at_least = .01,
                        from = NULL, to = NULL) {
    gave_to_fund(fund_text_contains_(search_terms),
                 at_least = at_least, from = from, to = to)

}
