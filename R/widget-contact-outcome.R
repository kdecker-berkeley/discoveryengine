#' @name contact_reports
#' @export
contact_outcome <- function(...) {
    reroute(contact_outcome_(prep_dots(...)))
}

contact_outcome_ <- function(purposes) {
    widget_builder(
        table = "f_contact_reports_mv",
        id_field = "report_id",
        id_type = "contact_report_id",
        parameter = string_param("contact_outcome_cd", purposes)
    )
}
