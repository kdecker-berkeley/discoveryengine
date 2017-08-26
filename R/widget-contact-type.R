#' @name contact_reports
#' @export
contact_type <- function(...) {
    reroute(contact_type_(prep_dots(...)))
}

contact_type_ <- function(types) {
    widget_builder(
        table = "f_contact_reports_mv",
        id_field = "report_id",
        id_type = "contact_report_id",
        parameter = string_param("contact_type", types)
    )
}
