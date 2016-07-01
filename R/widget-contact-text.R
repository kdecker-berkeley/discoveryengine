#' @export
contact_text <- function(...)
    contact_text_(prep_dots(...))

contact_text_ <- function(search_terms) {
    finder_builder(
        table = "f_contact_reports_mv",
        id_field = "report_id",
        id_type = "contact_report_id",
        search_fields = c("description", "summary"),
        search_terms = search_terms
    )
}
