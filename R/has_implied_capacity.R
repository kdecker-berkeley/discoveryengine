has_implied_capacity_ <- function(likelihood, type = c("CAP"), env = parent.frame()) {
  param <- likelihood
  param <- resolve_codes(param, "dp_interest_code")
  p2 <- type
  param1 <- substitute(dp_interest_code %in% param)
  param2 <- substitute(dp_rating_type_code %in% p2)
  bio_("demographic_profile", list(param1))
}

has_implied_capacity <- function(..., type = c("CAP"), env = parent.frame()) {
  param <- pryr::dots(...)
  param <- prep_string_param(param, env = env)
  has_implied_capacity_(param, type = type, env = env)
}
