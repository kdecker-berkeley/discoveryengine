#' Event attendance widget
#'
#' Find entities who attended (an) event(s).
#'
#' Enter one or more event codes, and decide whether you want to include people
#' who were on the invite list but did not attend (by default, they are excluded).
#' If you don't enter any event codes, then you will get people who attended any
#' event.
#'
#' @return A discoveryengine list definition of type \code{entity_id}
#'
#'
#' @param ... event codes
#' @param from begin and end dates (attended event between those dates). Enter as an integer of the form YYYYMMDD
#' @param to begin and end dates (attended event between those dates). Enter as an integer of the form YYYYMMDD
#' @param include_non_attendees do you want to include people who were invited,
#' but did not attend (regrets, no-show, invited but did not attend) defaults to FALSE
#' @param comment (Optional) Supply one or more search terms to search through
#' the comment field
#'
#' @examples
#' attended_event(3965, 1263)
#'
#' @export
attended_event <- function(..., from = NULL, to = NULL,
                           include_non_attendees = FALSE, comment = NULL) {
    events = prep_dots(...)
    reroute(attended_event_(events, from = from, to = to,
                            include_non_attendees = include_non_attendees,
                            comment = comment))
}

attended_event_ <- function(events, from = NULL, to = NULL,
                            include_non_attendees = FALSE, comment = NULL) {
    participation = c("P", "ST", "SP", "V", "H", "S", "C", "KN", "MD", "E", "OL")
    if (include_non_attendees)
        participation <- c(participation, "ID", "RG", "NS", "RU")

    entity_widget("d_bio_activity_mv",
                  parameter = string_param("activity_code", events),
                  switches = list(
                      string_switch("activity_participation_code", participation),
                      daterange("start_dt", from = from, to = to),
                      regex_switch("xcomment", comment)
                  ))
}
