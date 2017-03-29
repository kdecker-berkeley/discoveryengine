#' Academic widgets
#'
#' Find entities who graduated with a particular major(s) or from a particular
#' school(s). By default, attendees are not included, use \code{attendees = TRUE}
#' to include attendees. If no majors/schools are entered, the widget will look
#' for anyone with a Cal degree (or if \code{attendees = TRUE}, anyone who has
#' attended Cal). Will not retrieve anyone with non-Berkeley degrees.
#'
#' @return A definition of type \code{entity_id}
#'
#' @param ... Schools/majors
#' @param undergraduates TRUE/FALSE: should include undergraduates? Default is TRUE
#' @param graduates TRUE/FALSE: should include graduates? Default is TRUE
#' @param attendees TRUE/FALSE: should include attendees (TRUE) or just degreeholders (FALSE). Default is FALSE
#' @param from (optional) date range: look only for those who graduated between
#' these dates. Enter as an integer of the form YYYYMMDD
#' @param to (optional) date range: look only for those who graduated between
#' these dates. Enter as an integer of the form YYYYMMDD

#'
#' @examples
#' ## majored in philosophy and/or math
#' majored_in(mathematics, philosophy)
#'
#' ## just math grad degree holders
#' majored_in(mathematics, undergraduates = FALSE)
#'
#' ## with haas, we often want to include attendees because of the evening/wknd program:
#' has_degree_from(haas, attendees = TRUE)
#'
#' @name academic
#' @seealso \code{\link{has_reunion_year}}
NULL

#' @rdname academic
#' @export
has_degree_from <- function(..., undergraduates = TRUE,
                            graduates = TRUE, attendees= FALSE,
                            from = NULL, to = NULL) {
    schools <- prep_dots(...)
    reroute(has_degree_from_(schools, undergraduates = undergraduates,
                             graduates = graduates, attendees = attendees,
                             from = from, to = to))
}

has_degree_from_ <- function(schools, undergraduates = TRUE,
                             graduates = TRUE, attendees = FALSE,
                             from = NULL, to = NULL) {
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
                     daterange("grad_dt", from, to),
                     quote(local_ind == "Y")
                 ))
}
