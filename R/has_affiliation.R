has_affiliation_ <- function(affils, levels = c("C", "F"), env = parent.frame()) {
  param <- affils
  param <- resolve_codes(param, "affil_code")
  p2 <- levels
  param1 <- substitute(affil_code %in% param)
  param2 <- substitute(affil_status_code %in% p2)
  bio_("affiliation", list(param1))
}

has_affiliation <- function(..., levels = c("C", "F"), env = parent.frame()) {
  param <- pryr::dots(...)
  param <- prep_string_param(param, env = env)
  has_affiliation_(param, levels = levels, env = env)
}