#' Department of giving widget
#' Find entities who have given to specific departments
#' @param ... Department(s) of giving
#' @param at_least minimum total giving
#' @param from, to begin and end dates (gave between those dates)
#' @export
gave_to_department <- function(..., at_least = 0.01, from = NULL,
                         to = NULL) {
    depts <- prep_dots(...)
    reroute(gave_to_department_(depts, at_least = at_least,
                                from = from, to = to))
}

gave_to_department_ <- function(depts, at_least = 0.01, from = NULL, to = NULL) {
    if (!is.numeric(at_least)) stop("at_least must be a number")
    if (length(at_least) != 1L) stop("need a single amount for at_least")

    widget_builder(
        table = "f_transaction_detail_mv",
        id_field = "donor_entity_id_nbr",
        id_type = "entity_id",
        parameter = string_param("alloc_dept_code", depts),
        switches = list(
            daterange("giving_record_dt", from, to),
            string_switch("pledged_basis_flg", "Y")
        ),
        aggregate_switches = sum_switch("benefit_dept_credited_amt",
                                        at_least)
    )
}
