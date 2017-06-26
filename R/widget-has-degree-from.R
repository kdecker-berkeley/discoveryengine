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
#' these dates. Enter as an integer of the form YYYYMMDD (see details)
#' @param to (optional) date range: look only for those who graduated between
#' these dates. Enter as an integer of the form YYYYMMDD (see details)
#'
#' @details
#' When using the daterange (\code{from} and/or \code{to}), the dates will be
#' based on the GRAD DATE for degreeholders and the STOP DATE for attendees
#' (who have no GRAD DATE). Both dates are visible in the Degrees screen in
#' Advance. An alum's "class year" is based on the GRAD DATE. For degreeholders,
#' the two dates are often the same, though they can differ. See examples below.
#'
#' Attendees can be either graduate or undergraduate attendees. Whether one or
#' both of those types of attendees are selected when \code{attendees = TRUE} is
#' based on the values of \code{graduates} and \code{undergraduates} -- see
#' examples.
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
#' has_degree_from(haas, attendees = TRUE,
#'                 graduates = FALSE, undergraduates = FALSE,
#'                 from = 20010101, to = 20041231)
#'
#' ## if pulling both attendees and degreeholders together, then the date used
#' ## will be GRAD DATE for degreeholders and STOP DATE for attendees. this query
#' ## pulls haas degreeholders who graduated on or before Dec. 21, 1999, along
#' ## with non-degreeholders (attendees) who ended their attendance before
#' ## 12/31/1999
#' has_degree_from(haas, graduates = TRUE, undergraduates = TRUE,
#'                 attendees = TRUE, to = 19991231)
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

    ## can't use the normal daterange tool here,
    ## because we want conditional date field: use grad_dt for alumni,
    ## use stop_dt for attendees

    date_switch <- daterange(
        dbplyr::sql("case when degree_level_code in ('U', 'G') then grad_dt else stop_dt end"),
        from = from, to = to
    )

    if (undergraduates) {
        levels <- c(levels, "U")
        if (attendees) levels <- c(levels, "A")
    }

    if (graduates) {
        levels <- c(levels, "G")
        if (attendees) levels <- c(levels, "L")
    }

    if (!graduates && !undergraduates && attendees) {
        warning("has_degree_from: you selected attendees but not undergraduates or graduates. Both undergrad and grad attendees (but not degreeholders) will be selected", call. = FALSE)
        levels <- c("L", "A")
    }

    entity_widget("d_bio_degrees_mv",
                 parameter = string_param("school_code", schools),
                 switches = list(
                     string_switch("degree_level_code", levels),
                     date_switch,
                     quote(local_ind == "Y")
                 ))
}
