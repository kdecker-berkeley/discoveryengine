#' @rdname radius
#' @export
works_near <- function(location, miles,
                       latitude = NULL, longitude = NULL,
                       include_alternate = FALSE,
                       include_past = FALSE,
                       include_self_employed = TRUE,
                       type = "business") {
    near_geo_helper(
        location = location,
        miles = miles,
        latitude = latitude,
        longitude = longitude,
        type = type,
        include_alternate = include_alternate,
        include_past = include_past,
        include_seasonal = FALSE,
        include_student_local = FALSE,
        include_student_permanent = FALSE
    )
}
