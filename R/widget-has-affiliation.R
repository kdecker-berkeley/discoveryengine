#' Affiliation widget
#'
#' Find entities with a given affiliation(s). If no affiliation codes are entered,
#' widget will find entities who have any affiliation code.
#'
#' @return A definition of type \code{entity_id}
#'
#' @param ... affiliation code(s)
#' @param include_former TRUE/FALSE should include former affiliations? Defaults to TRUE
#'
#' @examples
#' ## let's find some SF elites
#' has_affiliation(san_francisco_grid_club, bohemian_club)
#'
#' ## look for just current homecoming volunteers
#' has_affiliation(caa_homecoming_volunteer, include_former = FALSE)
#'
#' @export
has_affiliation <- function(..., include_former = TRUE) {
    affiliations <- prep_dots(...)
    reroute(has_affiliation_(affiliations, include_former))
}

has_affiliation_ <- function(affiliations, include_former = TRUE) {
    if (include_former) status <- c("C", "F")
    else status <- "C"
    entity_widget("d_bio_affiliation_mv",
                  parameter = string_param("affil_code", affiliations),
                  switches = string_switch("affil_status_code", status))
}
