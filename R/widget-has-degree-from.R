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
#' @param attendees TRUE/FALSE: should include attendees? Default is FALSE
#' @param current_students TRUE/FALSE: should include current students? Default is FALSE
#' @param degreeholders TRUE/FALSE: should include degreeholders? Default is TRUE
#' @param from (optional) date range: look only for those who graduated between
#' these dates. Enter as an integer of the form YYYYMMDD (see details)
#' @param to (optional) date range: look only for those who graduated between
#' these dates. Enter as an integer of the form YYYYMMDD (see details)
#'
#' @details
#' Note that some major and minor codes start with numbers and include letters
#' (for example: a minor in mathematics is coded as \code{25I071U}). This causes
#' errors when parsing. To get around the issue, either use quotation marks
#' explicitly (as in: \code{minored_in("25I071U")}) or use the synonym
#' (\code{minored_in(mathematics)})
#'
#' When using the daterange (\code{from} and/or \code{to}), the dates will be
#' based on the GRAD DATE for degreeholders and the STOP DATE for attendees
#' (who have no GRAD DATE). Both dates are visible in the Degrees screen in
#' Advance. An alum's "class year" is based on the GRAD DATE. For degreeholders,
#' the two dates are often the same, though they can differ. See examples below.
#' Date options are ignored when looking for current students
#'
#' @examples
#' ## majored in philosophy and/or math between 2001 and 2004
#' ## since attendees are not included by default, this only pulls
#' ## (undergrad and grad) degreeholders. Those with a GRAD DATE in the
#' ## daterange will be included
#' majored_in(mathematics, philosophy, from = 20010101, to = 20041231)
#'
#' ## just math grad degree holders
#' majored_in(mathematics, undergraduates = FALSE)
#'
#' ## here we pull graduate degreeholders and graduate attendees
#' ## neither ungrad degreeholders nor undergrad attendees will be included
#' majored_in(mathematics,
#'            undergraduates = FALSE,
#'            graduates = TRUE,
#'            attendees = TRUE)
#'
#' ## evening/wknd program (haas) people are coded as attendees. note that since
#' ## we're only looking at attendees here, we'll be using the STOP DATE
#' ## this will pull BOTH undergrad and grad attendees, but no degreeholders
#' has_degree_from(haas, attendees = TRUE, degreeholders = FALSE
#'                 from = 20010101, to = 20041231)
#'
#' ## current MBA students
#' has_degree(MBA, current_students = TRUE, degreeholders = FALSE)
#'
#' @name academic
#' @seealso \code{\link{has_reunion_year}}

#' @rdname academic
#' @export

has_degree_from <- function(..., undergraduates = TRUE,
                            graduates = TRUE, attendees= FALSE,
                            current_students = FALSE,
                            degreeholders = TRUE,
                            from = NULL, to = NULL,
                            advisor = NULL) 
    schools <- prep_dots(...)
    reroute(has_degree_from_(schools, undergraduates = undergraduates,
                             graduates = graduates, attendees = attendees,
                             current_students = current_students,
                             degreeholders = degreeholders,
                             from = from, to = to,
                             advisor = advisor))


has_degree_from_ <- function(schools, undergraduates = TRUE,
                             graduates = TRUE, attendees = FALSE,
                             current_students = FALSE,
                             degreeholders = TRUE,
                             from = NULL, to = NULL,
                             advisor = NULL) {

    academic_widget(param = string_param("school_code", schools),
                    undergraduates = undergraduates,
                    graduates = graduates,
                    attendees = attendees,
                    current_students = current_students,
                    degreeholders = degreeholders,
                    from = from, to = to,
                    advisor = advisor)
}
