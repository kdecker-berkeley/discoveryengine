#' @rdname address
#' @export
works_in_zip <- function(..., type = "B") {
    zips <- prep_dots(...)
    reroute(works_in_zip_(zips, type))
}

works_in_zip_ <- function(zips, type = "B") {
    address_widget("zipcode5", zips, type = type, param_fn = zipcode_param)
}


