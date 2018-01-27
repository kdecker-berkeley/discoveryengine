#' Geographic radius search
#'
#' Use this widget to find people who live or work "near" a given location, for
#' instance to aid with event planning or when a development officer is about to
#' take a trip. Note: this widget uses a web-based geocoder to geocode the
#' "location" that you type in. If you encounter issues, or just want to be sure,
#' you can always use the \code{latitude} and \code{longitude} arguments to specify
#' exactly where the center of your search should be.
#'
#' @param location A (quoted) string describing a place (see examples)
#' @param miles The radius of the search, all addresses within this many
#' miles of \code{location} will be returned
#' @param latitude If you already know the lat/long of your search location,
#' then you can enter them directly rather than entering an address in \code{location}
#' @param longitude (see above)
#' @param include_past include past/former addresses? Defaults to FALSE
#' @param include_self_employed for works_near: include self-employed business addresses? Defaults to TRUE
#' @param include_seasonal for lives_near: include seasonal addresses? Defaults to FALSE
#' @param include_student_local for lives_near: include student local address? Defaults to FALSE
#' @param include_student_permanent for lives_near: include student permanent address? Defaults to FALSE
#' @param type Will be either "home" or "business". Advanced users can specify individual address type codes
#'
#' @return A disco definition of type \code{entity_id}
#'
#' @seealso \code{\link{address}}
#'
#' @examples
#' ## find everyone within 10 miles of campus
#' lives_near("UC Berkeley", miles = 10)
#'
#' ## can always use exact addresses
#' lives_near("1995 University Ave., Berkeley, CA 94720", miles = 15.5)
#'
#' ## if you already know the lat/long, you can enter them directly:
#' works_near(lat = 37.87238, lon = -122.2542, miles = 10)
#'
#' @name radius
#' @export
lives_near <- function(location, miles,
                       latitude = NULL, longitude = NULL,
                       include_alternate = TRUE,
                       include_past = FALSE,
                       include_seasonal = FALSE,
                       include_student_local = FALSE,
                       include_student_permanent = FALSE,
                       type = "home") {
    near_geo_helper(
        location = location,
        miles = miles,
        latitude = latitude,
        longitude = longitude,
        type = type,
        include_alternate = include_alternate,
        include_past = include_past,
        include_seasonal = include_seasonal,
        include_student_local = include_student_local,
        include_student_permanent = include_student_permanent
    )
}
