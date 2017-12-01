#' @name contact_reports
#' @export
contact_credit <- function(...) {
    ent_id <- entity_id_param(...)
    converter_builder(
        ent_id,
        table = "f_contact_reports_mv",
        from = "contact_credit_entity_id",
        from_type = "entity_id",
        to = "report_id",
        to_type = "contact_report_id"
    )
}
