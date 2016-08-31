#' Address based widgets
#'
#' By default the "lives in" widgets use an address type code of "H" (Home)
#' and the "works in" widgets use "B" (Business). Use the \code{type} argument
#' to change included address types.
#'
#' @return A definition of type \code{entity_id}
#'
#' @param ... the counties/msas/zips
#' @param type The address type code included (eg "H" for "Home")
#'
#' @examples
#' ## find anyone who lives or works in the san francisco MSA
#' lives_in_msa(san_francisco) %or% works_in_msa(san_francisco)
#'
#' ## don't forget about synonym search if you're not sure about a code
#' lives_in_county(?alameda)
#'
#' ## find people who live in any of these counties
#' lives_in_county(alameda_ca, san_mateo_ca)
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
