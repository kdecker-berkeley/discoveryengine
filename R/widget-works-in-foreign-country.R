#' @rdname address
#' @export
works_in_foreign_country <- function(..., type = "B") {
    countries <- prep_dots(...)
    reroute(works_in_foreign_country_(countries, type = type))
}


works_in_foreign_country_ <- function(countries, type = "B") {
    address_widget("country_code", countries, type = type)
}
