lives_in_zip_ <- function(zip, type = c("H"), env = parent.frame()) {
  param <- zip
  param <- resolve_codes(param, "zipdcode5")
  p2 <- type
  param1 <- substitute(zipcode5 %in% param)
  param2 <- substitute(addr_type_code %in% p2)
  bio_("address", list(param1))
}

lives_in_zip <- function(..., type = c("H"), env = parent.frame()) {
  param <- pryr::dots(...)
  param <- prep_string_param(param, env = env)
  lives_in_zip_(param, status = status, env = env)
}
