#' Find contact reports that contain specific keywords/phrases
#'
#' This widget is comparable to the Contact Report Miner in CADSMart. Enter one
#' or more search strings. If you enter multiple search strings, the search will
#' be for contact reports that contain any one of the searches. Wildcards (*)
#' are allowed at the beginning or end of each search term (but not in the
#' middle). This widget creates a definition of type \code{contact_report_id}.
#' To find the relevant contacted entities, use
#' \code{\link{contacted_entity_of}}. For advanced searches, use the \code{ora}
#' function to use an arbitrary Oracle-style regex as the search term.
#'
#' @return A discoveryengine list definition of type \code{contact_report_id}
#'
#' @param ... One or more search terms, in quotation marks
#'
#' @examples
#' ## contact reports related to neuroscience
#' contact_text_contains("neuroscience")
#'
#' ## but what about neurobiology, neuroeconomics, etc?
#' contact_text_contains("neuro*")
#'
#' ## can use as many search terms as you want. widget will search for
#' ## contact reports containing any one of the search terms
#' contact_text_contains("neuro*", "brains")
#'
#' @seealso \code{\link{contacted_entity_of}}, \code{\link{contact_reports}}
#'
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
