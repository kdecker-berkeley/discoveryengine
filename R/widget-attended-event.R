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
#' @param include_non_attendees do you want to include people who were invited,
#' but did not attend (regrets, no-show, invited but did not attend) defaults to FALSE
#'
#' @examples
#' attended_event(3965, 1263)
#'
#' @export
attended_event <- function(..., include_non_attendees = FALSE) {
    events = prep_dots(...)
    reroute(attended_event_(events, include_non_attendees))
}

attended_event_ <- function(events, include_non_attendees = FALSE) {
    participation = c("P", "ST", "SP", "V", "H", "S", "C", "KN", "MD", "E")
    if (include_non_attendees)
        participation <- c(participation, "ID", "RG", "NS")

    entity_widget("d_bio_activity_mv",
                  parameter = string_param("activity_code", events),
                  switches = list(
                      string_switch("activity_participation_code", participation)
                  ))
}
