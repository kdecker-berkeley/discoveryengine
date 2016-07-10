#' Giving widgets
#'
#' Find entities who have given to specific types of funds
#'
#' @param ... Area(s)/Department(s) of giving
#' @param at_least minimum total giving
#' @param from begin and end dates (gave between those dates). Enter as an integer of the form YYYYMMDD
#' @param to begin and end dates (gave between those dates). Enter as an integer of the form YYYYMMDD
#'
#' @examples
#' ## gave at least $5,000 to cal performances during FY 2016
#' gave_to_area(cal_performances, at_least = 5000, from = 20150701, to = 20161231)
#'
#' ## has given at least $100,000 lifetime to engineering
#' gave_to_area(engineering, at_least = 100000)
#'
#' @seealso \code{\link{gave_to_fund}}
#' @name giving
NULL

#' @rdname giving
#' @export
gave_to_area <- function(..., at_least = 0.01, from = NULL,
                         to = NULL) {
    aogs <- prep_dots(...)
    reroute(gave_to_area_(aogs, at_least = at_least,
                          from = from, to = to))
}

gave_to_area_ <- function(aogs, at_least = 0.01, from = NULL, to = NULL) {
    if (!is.numeric(at_least)) stop("at_least must be a number")
    if (length(at_least) != 1L) stop("need a single amount for at_least")

    widget_builder(
        table = "f_transaction_detail_mv",
        id_field = "donor_entity_id_nbr",
        id_type = "entity_id",
        parameter = string_param("alloc_school_code", aogs),
        switches = list(
            daterange("giving_record_dt", from, to),
            string_switch("pledged_basis_flg", "Y")
        ),
        aggregate_switches = sum_switch("benefit_aog_credited_amt",
                                        at_least)
    )
}
