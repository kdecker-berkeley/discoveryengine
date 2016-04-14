lives_in_county_ <- function(county, type = c("H"), env = parent.frame()) {
  param <- county
  param <- resolve_codes(param, "county_code")
  p2 <- type
  param1 <- substitute(county_code %in% param)
  param2 <- substitute(addr_type_code %in% p2)
  bio_("address", list(param1))
}

lives_in_county <- function(..., type = c("H"), env = parent.frame()) {
  param <- pryr::dots(...)
  param <- prep_string_param(param, env = env)
  lives_in_county_(param, status = status, env = env)
}
