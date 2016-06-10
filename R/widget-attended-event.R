#' Event attendance widget
#'
#' @param ... event codes
#' @param participation event participation codes
#' @export
attended_event <- function(..., participation = c("P", "ST", "SP", "V", "H", "S", "C", "KN", "MD", "E")) {
    events = prep_dots(...)
    attended_event_(events, participation)
}

#' @export
#' @rdname attended_event
attended_event_ <- function(events, participation = c("P", "ST", "SP", "V", "H", "S", "C", "KN", "MD", "E")) {
    entity_widget("d_bio_activity_mv",
                  parameter = string_param("activity_code", events),
                  switches = list(
                      string_switch("activity_participation_code", participation)
                  ))
}
