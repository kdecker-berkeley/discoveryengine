#' @name contact_reports
#' @export
contact_purpose <- function(...) {
    reroute(contact_purpose_(prep_dots(...)))
}

contact_purpose_ <- function(purposes) {
    widget_builder(
        table = "f_contact_reports_mv",
        id_field = "report_id",
        id_type = "contact_report_id",
        parameter = string_param("contact_purpose_code", purposes)
    )
}
