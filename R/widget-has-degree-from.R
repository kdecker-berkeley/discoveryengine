#' Academic widgets
#'
#' Find entities who graduated with a particular major(s) or from a particular
#' school(s). By default, attendees are not included, use \code{attendees = TRUE}
#' to include attendees.
#'
#' @param ... Schools/majors
#' @param undergraduates TRUE/FALSE: should include undergraduates? Default is TRUE
#' @param graduates TRUE/FALSE: should include graduates? Default is TRUE
#' @param attendees TRUE/FALSE: should include attendees (TRUE) or just degreeholders (FALSE). Default is FALSE
#' @name academic
#' @seealso \code{\link{has_reunion_year}}
NULL

#' @rdname academic
#' @export
has_degree_from <- function(..., undergraduates = TRUE,
                            graduates = TRUE, attendees= FALSE) {
    schools <- prep_dots(...)
    reroute(has_degree_from_(schools, undergraduates = undergraduates,
                             graduates = graduates, attendees = attendees))
}

has_degree_from_ <- function(schools, undergraduates = TRUE,
                             graduates = TRUE, attendees = FALSE) {
    levels = NULL
    if (undergraduates) {
        levels <- c(levels, "U")
        if (attendees) levels <- c(levels, "A")
    }

    if (graduates) {
        levels <- c(levels, "G")
        if (attendees) levels <- c(levels, "L")
    }

    entity_widget("d_bio_degrees_mv",
                 parameter = string_param("school_code", schools),
                 switches = list(
                     string_switch("degree_level_code", levels),
                     quote(local_ind == "Y")
                 ))
}
