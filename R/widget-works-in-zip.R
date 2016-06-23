#' @export
works_in_zip <- function(..., type = "B") {
    zips <- prep_dots(...)
    reroute(works_in_zip_(zips, type))
}

works_in_zip_ <- function(zips, type = "B") {
    entity_widget("d_bio_address_mv",
                  parameter = zipcode_param("zipcode5", zips),
                  switches = string_switch("addr_type_code", type))
}


