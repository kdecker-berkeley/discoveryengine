#' Find entities based on keyword searches of their research profiles
#'
#' Searches through research notes for the given keywords/phrases, and returns
#' the relevant entities. Searches the "Text" of a research note along with the
#' "Brief Note" and the "Description." Enter one
#' or more search strings. If you enter multiple search strings, the search will
#' be for notes that contain any one of the searches. Wildcards (*)
#' are allowed at the beginning or end of each search term (but not in the
#' middle). For advanced searches, use the \code{ora}
#' function to use an arbitrary Oracle-style regex as the search term.
#'
#' @param ... Search string(s)
#'
#' @return A discoveryengine list definition of type \code{entity_id}
#'
#' @examples
#' research_miner("education")
#'
#' ## broad search for education supporters
#' research_miner("education") %or%
#'     has_interest(education) %or%
#'     has_philanthropic_affinity(higher_education, secondary_education)
#'
#' @export
research_miner <- function(...) {
    search_terms <- as.character(unlist(list(...)))
    finder_builder(
        table = "f_notes_mv",
        id_field = "entity_id",
        id_type = "entity_id",
        search_fields = c("description", "brief_note", "note_text"),
        search_terms = search_terms,
        switches = string_switch("note_type", c("RR", "RB", "RN"))
    )
}
