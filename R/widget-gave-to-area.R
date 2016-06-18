#' Area of giving widget
#' Find entities who have given to specific areas
#' @param ... Area(s) of giving
#' @param atleast minimum total giving
#' @param from, to begin and end dates (gave between those dates)
#' @export
gave_to_area <- function(..., atleast = 0.01, from = NULL,
                         to = NULL) {
    aogs <- prep_dots(...)
    reroute(gave_to_area_(aogs, atleast = atleast,
                          from = from, to = to))
}

#' @rdname gave_to_area
#' @export
gave_to_area_ <- function(aogs, atleast = 0.01, from = NULL, to = NULL) {

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
                                        atleast)
    )
}
