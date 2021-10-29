#' Find entities based on keyword searches of their wealth and assets
#'
#' Searches through wealth and assets for the given keywords/phrases, and returns
#' the relevant entities. Searches the "Description" of an asset along with the
#' "Comment." Enter one
#' or more search strings. If you enter multiple search strings, the search will
#' be for notes that contain any one of the searches. Wildcards (*)
#' are allowed at the beginning or end of each search term (but not in the
#' middle). For advanced searches, use the \code{ora}
#' function to use an arbitrary Oracle-style regex as the search term.
#'
#' @param ... Search string(s)
#' @param author Optionally, include an entity ID of a prospect researcher to only
#' look at notes written by that researcher.
#'
#' @return A discoveryengine list definition of type \code{entity_id}
#'
#' @examples
#' ## broad search for those with a trust as a listed asset
#' asset_miner("trust")
#'
#' @export
asset_miner <- function(..., author = NULL) {
    search_terms <- prep_regex_param(...)

    finder_builder(
        table = "d_wealth_assets_mv",
        id_field = "entity_id",
        id_type = "entity_id",
        search_fields = c("asset_description", "xcomment"),
        search_terms = search_terms,
        switches = list(
            integer_switch("author_entity_id", author)
        )
    )
}
