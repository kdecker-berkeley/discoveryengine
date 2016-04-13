played_sport_ <- function(sports, env = parent.frame()) {
  param <- sports
  param <- resolve_codes(param, "sport_code")
  param1 <- substitute(sport_code %in% param)
  if (length(param) > 0) params <- list(param1)
  else params <- NULL
  bio_("sport", params)
}

played_sport <- function(..., env = parent.frame()) {
  param <- pryr::dots(...)
  param <- prep_string_param(param, env = env)
  played_sport_(param, env = env)
}
