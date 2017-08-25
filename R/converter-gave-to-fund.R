#' Giving to fund(s)
#'
#' Find entities who have given to a custom list of funds
#'
#' @param ... Allocation code(s) or a disco definition of type \code{allocation_code}
#' @param at_least minimum total giving (defaults to .01)
#' @param from begin and end dates (gave between those dates). Enter as an integer of the form YYYYMMDD
#' @param to begin and end dates (gave between those dates). Enter as an integer of the form YYYYMMDD
#'
#' @details
#' \code{from} and \code{to} are optional, not entering them will leave that end
#' of the date range open. So for example a year-to-date cutoff can be achieved
#' by using \code{from} but not \code{to}. Leaving both blank will look for
#' donors at any time. Giving is aggregated to all funds specified in the ... --
#' so you're not looking for someone who gave \code{at_least} to one of the funds
#' on the list, but rather someone who gave in total \code{at_least} to all/any
#' of the funds that appear on that list.
#'
#' @return A discoveryengine list definition of type \code{entity_id}
#'
#' @examples
#' ## find funds supporting diversity
#' diversity_funds = fund_text_contains("diversity")
#'
#' ## donors to those funds
#' gave_to_fund(diversity_funds)
#'
#' ## just donors over $10K to those funds
#' gave_to_fund(diversity_funds, at_least = 10000)
#'
#' ## just donors over $10K during calendar year 2015
#' gave_to_fund(diversity_funds, at_least = 10000, from = 20150101, to = 20151231)
#'
#' ## donors who had given at least $100K to diversity funds before 2012
#' gave_to_fund(diversity_funds, at_least = 100000, to = 20111231)
#'
#' ## can also provide individual allocation IDs as-is
#' gave_to_fund(FH2031000, FW6644000, at_least = 1000)
#'
#' @seealso \code{\link{gave_to_area}}, \code{\link{gave_to_department}},
#' \code{\link{fund_text_contains}}, \code{\link{funds}}
#' @export
gave_to_fund <- function(..., at_least = .01, from = NULL, to = NULL) {
    reroute(gave_to_fund_(
        prep_dots(...),
        at_least = at_least, from = from, to = to))
}

gave_to_fund_ <- function(savedlist, at_least = .01, from = NULL, to = NULL) {
    converter_builder(allocation_id_param(savedlist),
                      table = "f_transaction_detail_mv",
                      from = "allocation_cd",
                      from_type = "allocation_code",
                      to = "donor_entity_id_nbr",
                      to_type = "entity_id",
                      switches = list(
                          daterange("giving_record_dt", from, to),
                          string_switch("pledged_basis_flg", "Y")
                      ),
                      aggregate_switches = sum_switch("benefit_dept_credited_amt",
                                                      at_least))
}
