#' Address based widgets
#'
#' By default the "lives in" widgets use an address type code of "H" (Home)
#' and the "works in" widgets use "B" (Business). Use the \code{type} argument
#' to change included address types.
#'
#' @return A definition of type \code{entity_id}
#'
#' @param ... the counties/msas/zips
#' @param include_alternate include addresses coded as "alternate?" Defaults to FALSE
#' @param include_past include past/former addresses? Defaults to FALSE
#' @param include_self_employed for works_in_*: include self-employed business addresses? Defaults to TRUE
#' @param include_seasonal for lives_in_*: include seasonal addresses? Defaults to FALSE
#' @param include_student_local for lives_in_*: include student local address? Defaults to FALSE
#' @param include_student_permanent for lives_in_*: include student permanent address? Defaults to FALSE
#' @param city For foreign addresses, a search string to find individual cities (see details and examples)
#' @param type Will be either "home" or "business". Advanced users can specify individual address type codes (see examples)
#'
#' @details Foreign addresses do not have associated county or MSA codes, and
#' currently (as of March 2018) are not geocoded in CADS, so will not be found to
#' the \code{\link{lives_near}} and \code{\link{works_near}} widgets. There are
#' no strict code tables associated with cities, but the \code{city} argument in
#' the foreign country widgets allow you to search for a particular city by name
#' (see examples)
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
#' ## the best way to find people working in Seoul
#' works_in_foreign_country(KORER, city = "Seoul")
#'
#' ## people who live abroad or used to live abroad:
#' lives_in_foreign_country(include_past = TRUE)
#'
#' ## you shouldn't need to, but if necessary
#' ## you can directly specify address type codes:
#' ## make sure you know what you're doing!
#' lives_in_msa(san_francisco, type = "S")
#'
#' @name address
NULL

#' @rdname address
#' @export
lives_in_county <- function(...,
                            include_alternate = FALSE,
                            include_past = FALSE,
                            include_seasonal = FALSE,
                            include_student_local = FALSE,
                            include_student_permanent = FALSE,
                            type = "home") {
    counties <- prep_dots(...)
    reroute(lives_in_county_(counties,
                             include_alternate = include_alternate,
                             include_past = include_past,
                             include_seasonal = include_seasonal,
                             include_student_local = include_student_local,
                             include_student_permanent = include_student_permanent,
                             type = type))
}


lives_in_county_ <- function(counties,
                             include_alternate = FALSE,
                             include_past = FALSE,
                             include_seasonal = FALSE,
                             include_student_local = FALSE,
                             include_student_permanent = FALSE,
                             type = "home") {
    address_widget("county_code", counties,
                   type = type,
                   include_alternate = include_alternate,
                   include_past = include_past,
                   include_seasonal = include_seasonal,
                   include_student_local = include_student_local,
                   include_student_permanent = include_student_permanent)
}
