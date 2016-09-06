#' @export
fund_area <- function(...) {
    reroute(fund_area_(prep_dots(...)))
}

fund_area_ <- function(aogs) {
    widget_builder(
        table = "f_allocation_mv",
        id_field = "allocation_code",
        id_type = "allocation_code",
        parameter = string_param("area_of_giving_code", aogs)
    )
}
