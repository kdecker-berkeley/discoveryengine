lives_in_zip <- function(..., type = "H") {
    zips <- prep_dots(...)
    lives_in_zip_(zips, type)
}

lives_in_zip_ <- function(zips, type = "H") {
    address_widget("zipcode5", zips, type)
}
