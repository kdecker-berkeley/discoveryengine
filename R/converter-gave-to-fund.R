#' Giving to fund(s)
#'
#' Find entities who have given to a custom list of funds
#'
#' @param savedlist A list/definition of allocation codes
#' @param at_least minimum total giving
#' @param from begin and end dates (gave between those dates). Enter as an integer of the form YYYYMMDD
#' @param to begin and end dates (gave between those dates). Enter as an integer of the form YYYYMMDD
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
#' @seealso \code{\link{gave_to_area}}, \code{\link{gave_to_department}}
#' @export
gave_to_fund <- function(savedlist, at_least = .01, from = NULL, to = NULL) {
    converter_builder(savedlist,
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
