#' Affiliation widget
#'
#' Find entities with a given affiliation(s). If no affiliation codes are entered,
#' widget will find entities who have any affiliation code.
#'
#' @return A definition of type \code{entity_id}
#'
#' @param ... affiliation code(s)
#' @param include_former TRUE/FALSE should include former affiliations? Defaults to TRUE
#' @param comment (Optional) Supply one or more search terms to search through
#' the comment field
#'
#' @examples
#' ## let's find some SF elites
#' has_affiliation(san_francisco_grid_club, bohemian_club)
#'
#' ## look for just current homecoming volunteers
#' has_affiliation(caa_homecoming_volunteer, include_former = FALSE)
#'
#' @export
has_affiliation <- function(..., include_former = TRUE, comment = NULL) {
    affiliations <- prep_dots(...)
    reroute(has_affiliation_(affiliations, include_former, comment = comment))
}

has_affiliation_ <- function(affiliations, include_former = TRUE, comment = NULL) {
    if (include_former) status <- c("C", "F")
    else status <- "C"
    entity_widget("d_bio_affiliation_mv",
                  parameter = string_param("affil_code", affiliations),
                  switches = list(
                      string_switch("affil_status_code", status),
                      regex_switch("comment1 || comment2", comment)))
}
