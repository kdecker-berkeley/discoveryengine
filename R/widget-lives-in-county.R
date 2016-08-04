#' Address based widgets
#'
#' By default the "lives in" widgets use an address type code of "H" (Home)
#' and the "works in" widgets use "B" (Business). Use the \code{type} argument
#' to change included address types.
#'
#' @param ... the counties/msas/zips
#' @param type The address type code included (eg "H" for "Home")
#'
#' @name address
NULL

#' @rdname address
#' @export
lives_in_county <- function(..., type = "H") {
    counties <- prep_dots(...)
    reroute(lives_in_county_(counties, type = type))
}


lives_in_county_ <- function(counties, type = "H") {
    address_widget("county_code", counties, type = type)
}
