works_in_county <- function(..., type = "B", env = parent.frame()) {
    counties <- pryr::dots(...)
    works_in_county_(counties, type, env)
}

works_in_county_ <- function(counties, type = "B", env = parent.frame()) {
    address_widget("county_code", counties,
                   type = type, env = env)
}
