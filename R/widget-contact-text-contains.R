#' @export
contact_text_contains <- function(...)
    contact_text_contains_(prep_dots(...))

contact_text_contains_ <- function(search_terms) {
    finder_builder(
        table = "f_contact_reports_mv",
        id_field = "report_id",
        id_type = "contact_report_id",
        search_fields = c("description", "summary"),
        search_terms = search_terms
    )
}
