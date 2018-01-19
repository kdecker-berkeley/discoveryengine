#' Find funds with a particular fund purpose
#'
#' This widget does not look for donors to specific types of funds, but rather
#' creates a definition of type \code{allocation_code} of funds with the specified
#' fund purpose code(s), e.g. 'Undergrad Student Support' (undergrad scholarships).
#' Use \code{\link{gave_to_fund}} to find donors to particular funds or types of funds
#'
#' @return A discoveryengine list definition of type \code{allocation_code}
#'
#' @seealso \code{\link{fund_department}}, \code{\link{fund_area}},
#' \code{\link{fund_type}}, \code{\link{gave_to_fund}},
#' \code{\link{gave_to_purpose}}
#'
#' @examples
#' ## looking for scholarship funds
#' schol_fund = fund_purpose(USS, GSS, BSS)
#'
#' ## see the allocation codes:
#' display(schol_fund)
#'
#' ## find 100K+ donors:
#' gave_to_fund(schol_fund, at_least = 100000)
#'
#' @export
fund_purpose <- function(...) {
    reroute(fund_purpose_(prep_dots(...)))
}

fund_purpose_ <- function(purps) {
    widget_builder(
        table = "f_allocation_mv",
        id_field = "allocation_code",
        id_type = "allocation_code",
        parameter = string_param("primary_purpose_code", purps)
    )
}
