played_sport_ <- function(sports, env = parent.frame()) {
  param <- sports
  param <- resolve_codes(param, "sport_code")
  param1 <- substitute(sport_code %in% param)
  bio_("sport", list(param1))
}

played_sport <- function(..., env = parent.frame()) {
  param <- pryr::dots(...)
  param <- prep_string_param(param, env = env)
  played_sport_(param, env = env)
}
