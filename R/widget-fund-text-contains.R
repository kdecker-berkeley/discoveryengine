#' @export
fund_text_contains <- function(...)
    fund_text_contains_(prep_dots(...))

fund_text_contains_ <- function(search_terms) {
    has_in_name <- finder_builder(
        table = "f_allocation_mv",
        id_field = "allocation_code",
        id_type = "allocation_code",
        search_fields = "long_name",
        search_terms = search_terms
    )

    has_in_text <- finder_builder(
        table = "f_notes_mv",
        id_field = "allocation_code",
        id_type = "allocation_code",
        search_fields = c("description", "brief_note", "note_text"),
        search_terms = search_terms,
        switches = string_switch("note_type", c("FT", "FB"))
    )

    has_in_name %or% has_in_text
}
