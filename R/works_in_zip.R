works_in_zip <- function(..., type = "B", env = parent.frame()) {
    zips <- pryr::dots(...)
    works_in_zip_(zips, type, env)
}

works_in_zip_ <- function(zips, type = "B", env = parent.frame()) {
    address_widget("zipcode5", zips,
                   type = type, env = env)
}


