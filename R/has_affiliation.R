has_affiliation_ <- function(affils, env = parent.frame()) {
  param <- affils
  param <- resolve_codes(param, "affil_code")
  param1 <- substitute(affil_code %in% param)
  bio_("affiliation", list(param1))
}

has_affiliation <- function(..., env = parent.frame()) {
  param <- pryr::dots(...)
  param <- prep_string_param(param, env = env)
  has_affiliation_(param, env = env)
}
