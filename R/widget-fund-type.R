#' Find funds with a particular fund type code
#'
#' This widget does not look for donors to specific types of funds, but rather
#' creates a definition of type \code{allocation_code} of funds with the specified
#' fund type code(s), e.g. capital or endowment
#'
#' @return A discoveryengine list definition of type \code{allocation_code}
#'
#' @seealso \code{\link{fund_department}}, \code{\link{fund_area}}
#' \code{\link{gave_to_area}}, \code{\link{gave_to_fund}}
#'
#' @examples
#' ## looking for capital funds
#' capital_fund = fund_type(capital)
#'
#' ## see the allocation codes:
#' display(capital_fund)
#'
#' ## find 100K+ donors:
#' gave_to_fund(capital_fund, at_least = 100000)
#'
#' @export
fund_type <- function(...) {
    reroute(fund_type_(prep_dots(...)))
}

fund_type_ <- function(types) {
    widget_builder(
        table = "f_allocation_mv",
        id_field = "allocation_code",
        id_type = "allocation_code",
        parameter = string_param("fund_type_code", types)
    )
}
