#' Retrieve the contacted entities from a list of contact reports
#'
#' This widget allows you to take an existing definition of type
#' \code{contact_report_id} and convert it to a definition of type \code{entity_id},
#' by finding the contacted entities of the contact reports.
#'
#' @param savedlist A discoveryengine definition of type \code{contact_report_id}
#'
#' @examples
#' ## find contact reports that mention neuroscience
#' neuro_contact = contact_text_contains("neuroscience")
#'
#' ## and the respective contacted entities
#' contacted_entity_of(neuro_contact)
#'
#' @seealso \code{\link{contact_reports}}, \code{\link{contact_text_contains}}
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
