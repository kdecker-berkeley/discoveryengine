received_award_ <- function(awards, env = parent.frame()) {
  param <- awards
  param <- resolve_codes(param, "awd_honor_code")
  param1 <- substitute(awd_honor_code %in% param)
  bio_("awards_and_honors", list(param1))
}

received_award <- function(..., env = parent.frame()) {
  param <- pryr::dots(...)
  param <- prep_string_param(param, env = env)
  received_award_(param, env = env)
}