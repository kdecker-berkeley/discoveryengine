address_in_ <- function(msa, status = c("A"), env = parent.frame()) {
  param <- msa
  param <- resolve_codes(param, "geo_metro_area_code")
  p2 <- status
  param1 <- substitute(geo_metro_area_code %in% param)
  param2 <- substitute(addr_status_code %in% p2)
  bio_("address", list(param1))
}

address_in <- function(..., status = c("A"), env = parent.frame()) {
  param <- pryr::dots(...)
  param <- prep_string_param(param, env = env)
  address_in_(param, status = status, env = env)
}
