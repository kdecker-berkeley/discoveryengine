#' Find funds with a particular department code
#'
#' This widget does not look for donors to specific types of funds, but rather
#' creates a definition of type \code{allocation_code} of funds with a particular
#' department.
#'
#' @return A discoveryengine list definition of type \code{allocation_code}
#'
#' @seealso \code{\link{fund_area}}, \code{\link{gave_to_area}}, \code{\link{gave_to_fund}}
#'
#' @examples
#' ## are there any PACS funds related to Mahatma Gandhi?
#' pacs_gandhi_fund = fund_text_contains("gandhi") %and%
#'     fund_department(peace_and_conflict_studies)
#'
#' ## see the allocation codes:
#' display(pacs_gandhi_fund)
#'
#' ## find 1K+ donors:
#' gave_to_fund(pacs_gandhi_fund, at_least = 1000)
#'
#' @export
fund_department <- function(...) {
    reroute(fund_department_(prep_dots(...)))
}

fund_department_ <- function(depts) {
    widget_builder(
        table = "f_allocation_mv",
        id_field = "allocation_code",
        id_type = "allocation_code",
        parameter = string_param("alloc_dept_code", depts)
    )
}
