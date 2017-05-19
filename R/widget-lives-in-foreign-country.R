#' @rdname address
#' @export
lives_in_foreign_country <- function(..., type = "H") {
    countries <- prep_dots(...)
    reroute(lives_in_foreign_country_(countries, type = type))
}


lives_in_foreign_country_ <- function(countries, type = "H") {
    address_widget("country_code", countries, type = type)
}


# tms_country
