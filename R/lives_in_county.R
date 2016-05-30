lives_in_county <- function(..., type = "H", env = parent.frame()) {
    counties <- pryr::dots(...)
    lives_in_county_(counties, type = type, env = env)
}


lives_in_county_ <- function(counties, type = "H", env = parent.frame()) {
    address_widget("county_code", counties, type = type, env = env)
}
