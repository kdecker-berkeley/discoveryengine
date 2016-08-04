#' @rdname address
#' @export
works_in_county <- function(..., type = "B") {
    counties <- prep_dots(...)
    reroute(works_in_county_(counties, type))
}

works_in_county_ <- function(counties, type = "B") {
    address_widget("county_code", counties, type = type)
}
