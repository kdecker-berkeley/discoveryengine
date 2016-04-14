works_in_msa_ <- function(msa, type = c("B"), env = parent.frame()) {
  param <- msa
  param <- resolve_codes(param, "geo_metro_area_code")
  p2 <- type
  param1 <- substitute(geo_metro_area_code %in% param)
  param2 <- substitute(addr_type_code %in% p2)
  bio_("address", list(param1))
}

works_in_msa <- function(..., type = c("B"), env = parent.frame()) {
  param <- pryr::dots(...)
  param <- prep_string_param(param, env = env)
  works_in_msa_(param, status = status, env = env)
}


