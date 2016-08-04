#' @export
contacted_entity_of <- function(savedlist) {
    is_contact_entity <-
        converter_builder(savedlist,
                          table = "f_contact_reports_mv",
                          from = "report_id",
                          from_type = "contact_report_id",
                          to = "contact_entity_id",
                          to_type = "entity_id")

    is_contact_alt_entity <-
        converter_builder(savedlist,
                          table = "f_contact_reports_mv",
                          from = "report_id",
                          from_type = "contact_report_id",
                          to = "contact_alt_entity_id",
                          to_type = "entity_id",
                          switches = quote(contact_alt_entity_id %is not% null))

    is_contact_entity %or% is_contact_alt_entity
}
