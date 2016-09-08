#' @export
contact_unit <- function(...) {
    reroute(contact_unit_(prep_dots(...)))
}

contact_unit_ <- function(units) {
    widget_builder(
        table = "f_contact_reports_mv",
        id_field = "report_id",
        id_type = "contact_report_id",
        parameter = string_param("unit_code", units)
    )
}
