#' Find funds by keyword/phrase search
#'
#' This widget is comparable to the Fundfinder report in CADSMart. It will
#' search the fund terms, fund biography, and name of every fund. Enter one
#' or more search strings. If you enter multiple search strings, the search will
#' be for funds that contain any one of the searches. Wildcards (*)
#' are allowed at the beginning or end of each search term (but not in the
#' middle). This widget creates a definition of type \code{allocation_code}.
#' To find the donors to a list of funds, use
#' \code{\link{gave_to_fund}}. For advanced searches, use the \code{ora}
#' function to use an arbitrary Oracle-style regex as the search term.
#'
#' @return A discoveryengine list definition of type \code{allocation_code}
#'
#' @examples
#' ## find funds supporting diversity
#' diversity_funds = fund_text_contains("divers*", "underrepresented")
#'
#' ## donors to those funds
#' gave_to_fund(diversity_funds)
#'
#' ## just donors over $10K to those funds
#' gave_to_fund(diversity_funds, at_least = 10000)
#'
#' ## just donors over $10K during calendar year 2015
#' gave_to_fund(diversity_funds, at_least = 10000, from = 20150101, to = 20151231)
#'
#' ## donors who had given at least $100K to diversity funds before 2012
#' gave_to_fund(diversity_funds, at_least = 100000, to = 20111231)
#'
#' @seealso \code{\link{gave_to_fund}}
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
