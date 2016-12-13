#' @rdname radius
#' @export
works_near <- function(location, miles,
                       latitude = NULL, longitude = NULL,
                       type = "B") {
    near_geo_helper(
        location = location,
        miles = miles,
        latitude = latitude,
        longitude = longitude,
        type = type
    )
}
