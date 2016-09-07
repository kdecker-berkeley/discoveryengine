#' Find donors to funds by keyword/phrase search on the funds
#'
#' This widget is equivalent to running \code{\link{fund_text_contains}} and
#' \code{\link{gave_to_fund}}.
#'
#' @param ... Search string(s)
#' @param at_least minimum giving to the selected funds
#' @param from (optional) start date for looking at giving
#' @param to (optional) end date for giving
#'
#' @seealso \code{\link{gave_to_fund}}, \code{\link{fund_text_contains}}
#'
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
