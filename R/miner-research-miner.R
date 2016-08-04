#' @export
research_miner <- function(...) {
    reroute(research_miner_(prep_dots(...)))
}

research_miner_ <- function(search_terms) {
    finder_builder(
        table = "f_notes_mv",
        id_field = "entity_id",
        id_type = "entity_id",
        search_fields = c("description", "brief_note", "note_text"),
        search_terms = search_terms,
        switches = string_switch("note_type", c("RR", "RB", "RN"))
    )
}
