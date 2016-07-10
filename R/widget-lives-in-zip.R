#' @rdname address
#' @export
lives_in_zip <- function(..., type = "H") {
    zips <- prep_dots(...)
    reroute(lives_in_zip_(zips, type))
}

lives_in_zip_ <- function(zips, type = "H") {
    entity_widget("d_bio_address_mv",
                  parameter = zipcode_param("zipcode5", zips),
                  switches = string_switch("addr_type_code", type))
}
