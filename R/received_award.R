received_award_ <- function(awards, env = parent.frame()) {
  param <- awards
  param <- resolve_codes(param, "awd_honor_code")
  param1 <- substitute(awd_honor_code %in% param)
  if (length(param) > 0) params <- list(param1)
  else params <- NULL
  bio_("awards_and_honors", params)
}

received_award <- function(..., env = parent.frame()) {
  param <- pryr::dots(...)
  param <- prep_string_param(param, env = env)
  received_award_(param, env = env)
}
