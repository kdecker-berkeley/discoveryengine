#' Geographic radius search
#'
#' Use this widget to find people who live or work "near" a given location, for
#' instance to aid with event planning or when a development officer is about to
#' take a trip.
#'
#' @param location A (quoted) string describing a place (see examples)
#' @param miles The radius of the search, all addresses within this many
#' miles of \code{location} will be returned
#' @param latitude If you already know the lat/long of your search location,
#' then you can enter them directly rather than entering an address in \code{location}
#' @param longitude (see above)
#' @param type The address type to search for. By default, \code{lives_near}
#' looks for addresses of type "H" and \code{works_near} uses addresses of type "B"
#'
#' @return A disco definition of type \code{entity_id}
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
                       latitude = NULL, longitude = NULL, type = "H") {
    near_geo_helper(
        location = location,
        miles = miles,
        latitude = latitude,
        longitude = longitude,
        type = type
    )
}
