attended_event_ <- function(events, levels = c("P"), env = parent.frame()) {
  param <- events
  param <- resolve_codes(param, "activity_code")
  p2 <- levels
  param1 <- substitute(activity_code %in% param)
  param2 <- substitute(activity_participation_code %in% p2)
  bio_("activity", list(param1))
}

attended_event <- function(..., levels = c("P"), env = parent.frame()) {
  param <- pryr::dots(...)
  param <- prep_string_param(param, env = env)
  attended_event_(param, levels = levels, env = env)
}