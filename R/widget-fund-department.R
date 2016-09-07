#' @export
fund_department <- function(...) {
    reroute(fund_department_(prep_dots(...)))
}

fund_department_ <- function(depts) {
    widget_builder(
        table = "f_allocation_mv",
        id_field = "allocation_code",
        id_type = "allocation_code",
        parameter = string_param("alloc_dept_code", depts)
    )
}
