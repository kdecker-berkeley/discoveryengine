has_affiliation_ <- function(affils, status = c("C", "F"), env = parent.frame()) {
  param <- affils
  param <- resolve_codes(param, "affil_code")
  p2 <- status
  param1 <- substitute(affil_code %in% param)
  param2 <- substitute(affil_status_code %in% p2)
  if (length(param) > 0)
      params <- list(param1, param2)
  else params <- list(param2)
  bio_("affiliation", params)
}

has_affiliation <- function(..., status = c("C", "F"), env = parent.frame()) {
  param <- pryr::dots(...)
  param <- prep_string_param(param, env = env)
  has_affiliation_(param, status = status, env = env)
}
