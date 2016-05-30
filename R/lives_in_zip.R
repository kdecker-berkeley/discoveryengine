lives_in_zip <- function(..., type = "H", env = parent.frame()) {
    zips <- pryr::dots(...)
    lives_in_zip_(zips, type, env)
}

lives_in_zip_ <- function(zips, type = "H", env = parent.frame()) {
    address_widget("zipcode5", zips, type, env)
}
