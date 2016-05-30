#' Area of giving widget
#' Find entities who have given to specific areas
#' @param ... Area(s) of giving
#' @param atleast minimum total giving
#' @param from, to begin and end dates (gave between those dates)
#' @importFrom pryr dots
#' @export
gave_to_area <- function(..., atleast = 0.01, from = NULL,
                         to = NULL, env = parent.frame()) {
    aogs <- pryr::dots(...)
    gave_to_area_(aogs, atleast = atleast, from = from,
                  to = to, env = env)
}

#' @rdname gave_to_area
#' @export
gave_to_area_ <- function(aogs, atleast = 0.01, from = NULL, to = NULL,
                         env = parent.frame()) {

    widget_builder(
        table = "f_transaction_detail_mv",
        id_field = "donor_entity_id_nbr",
        id_type = "entity_id",
        parameter = string_param("alloc_school_code", aogs, default = NULL),
        switches = list(
            daterange("giving_record_dt", from, to),
            string_switch("pledged_basis_flg", "Y")
        ),
        aggregate_switches = sum_switch("benefit_aog_credited_amt",
                                        atleast),
        env = env
    )
}
