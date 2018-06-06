#' Find entities based on keyword searches of their job titles
#'
#' \code{\link{has_occupation}}, \code{\link{works_in_industry}}, and
#' \code{\link{has_position}} are all based on specific employment codes.
#' This widget, on the other hand, searches the text of job titles in the
#' employment table, and finds just those that match the search string(s). As
#' with any other text-searching widget, search strings must appear within
#' quotation marks.
#' If you enter multiple search strings, the search will
#' be for notes that contain any one of the searches. Wildcards (*)
#' are allowed at the beginning or end of each search term (but not in the
#' middle). For advanced searches, use the \code{ora}
#' function to use an arbitrary Oracle-style regex as the search term.
#'
#' @param ... Search string(s)
#' @param include_former Should non-current employment data be included in the
#' search? If FALSE (the default) only current employment will be searched
#'
#' @return A discoveryengine list definition of type \code{entity_id}
#'
#' @examples
#' ## search for jobs that include the word "data"
#' job_title_like("data")
#'
#' ## the previous search would not include jobs with the word "database",
#' ## but by adding an asterisk, we can capture those jobs also:
#' job_title_like("data*")
#'
#' ## a search for data analysts:
#' job_title_like("data*", "analy*")
#'
#' @export
job_title_like <- function(..., include_former = FALSE) {
    search_terms <- prep_regex_param(...)
    if (include_former) my_switch <- NULL
    else my_switch <- string_switch("job_status_code", "C")

    finder_builder(
        table = "d_bio_employment_mv",
        id_field = "entity_id",
        id_type = "entity_id",
        search_fields = "job_title",
        search_terms = search_terms,
        switches = my_switch
    )
}
