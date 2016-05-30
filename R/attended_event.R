#' Event attendance widget
#'
#' @param ... event codes
#' @param participation event participation codes
#' @importFrom pryr dots
#' @export
attended_event <- function(..., participation = c("P", "ST", "SP", "V", "H", "S", "C", "KN", "MD", "E"),
                           env = parent.frame()) {
    events = pryr::dots(...)
    attended_event_(events, participation, env)
}

#' @export
#' @rdname attended_event
attended_event_ <- function(events, participation = c("P", "ST", "SP", "V", "H", "S", "C", "KN", "MD", "E"),
                            env = parent.frame()) {
    d_bio_widget("activity",
                 parameter = string_param("activity_code", events,
                                          default = NULL, env = env),
                 switches = list(
                     string_switch("activity_participation_code", participation)
                 ),
                 env = env)
}
