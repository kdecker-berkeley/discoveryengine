#' @rdname contact_reports
#' @export
contact_date <- function(from = NULL, to = NULL) {
    widget_builder(
        table = "f_contact_reports_mv",
        id_field = "report_id",
        id_type = "contact_report_id",
        switches = daterange("contact_date", from, to)
    )
}
