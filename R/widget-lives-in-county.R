lives_in_county <- function(..., type = "H") {
    counties <- prep_dots(...)
    lives_in_county_(counties, type = type)
}


lives_in_county_ <- function(counties, type = "H") {
    address_widget("county_code", counties, type = type)
}
