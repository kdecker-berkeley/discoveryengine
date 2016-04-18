attended_event_ <- function(events, participation = c("P", "ST", "SP", "V", "H", "S", "C", "KN", "MD", "E"),
                            env = parent.frame()) {
  param <- events
  param <- resolve_codes(param, "activity_code")
  p2 <- participation
  param1 <- substitute(activity_code %in% param)
  param2 <- substitute(activity_participation_code %in% p2)
  if (length(param) > 0) params <- list(param1, param2)
  else params <- list(param2)
  bio_("activity", params)
}

#' @export
attended_event <- function(..., participation = c("P", "ST", "SP", "V", "H", "S", "C", "KN", "MD", "E"),
                           env = parent.frame()) {
  param <- pryr::dots(...)
  param <- prep_string_param(param, env = env)
  attended_event_(param, participation = participation, env = env)
}
