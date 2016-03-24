on_committee_ <- function(committees, levels = c("A", "D"), env = parent.frame()) {
  param <- committees
  param <- resolve_codes(param, "committee_code")
  p2 <- levels
  param1 <- substitute(committee_code %in% param)
  param2 <- substitute(status_code %in% p2)
  bio_("committee", list(param1))
}

on_committee <- function(..., levels = c("A", "D"), env = parent.frame()) {
  param <- pryr::dots(...)
  param <- prep_string_param(param, env = env)
  on_committee_(param, levels = levels, env = env)
}