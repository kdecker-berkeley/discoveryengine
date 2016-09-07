#' Find funds with a particular area of giving code
#'
#' This widget does not look for donors to specific types of funds, but rather
#' creates a definition of type \code{allocation_code} of funds with a particular
#' area of giving.
#'
#' @return A discoveryengine list definition of type \code{allocation_code}
#'
#' @seealso \code{\link{fund_department}}, \code{\link{gave_to_area}}, \code{\link{gave_to_fund}}
#'
#' @examples
#' ## looking for funds supporting diversity in CED
#' ced_diversity_fund = fund_text_contains("diversity") %and%
#'     fund_area(environmental_design)
#'
#' ## see the allocation codes:
#' display(ced_diversity_fund)
#'
#' ## find 1K+ donors:
#' gave_to_fund(ced_diversity_fund, at_least = 1000)
#'
#' @export
fund_area <- function(...) {
    reroute(fund_area_(prep_dots(...)))
}

fund_area_ <- function(aogs) {
    widget_builder(
        table = "f_allocation_mv",
        id_field = "allocation_code",
        id_type = "allocation_code",
        parameter = string_param("area_of_giving_code", aogs)
    )
}
