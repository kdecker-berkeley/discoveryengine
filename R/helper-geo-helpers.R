geocode_location <- function(location) {

    if (!requireNamespace("rmapzen", quietly = TRUE)) {
        stop('This feature requires the package rmapzen\n',
             'To install: devtools::install_github("tarakc02/rmapzen")',
             call. = FALSE)
    }

    geo <- rmapzen::mz_geocode(location)
    latlon <- rmapzen::as.mz_location(geo)

    lat <- latlon[["lat"]]
    lon <- latlon[["lon"]]
    loc_used <- geo$geocode_address
    if (is.null(loc_used)) loc_used <- NA
    confidence <- geo$geocode_confidence
    if (is.null(confidence)) confidence <- NA

    if (nrow(geo) > 1 || is.na(lat) || is.na(lon))
        stop("There was a problem :(")

    msg <- paste0(
        "Basing results on: ",
        loc_used, " (", round(lat, 2), ", ", round(lon, 2),
        ")\n(confidence that this is the right location: ", confidence, ")")

    message(msg)
    return(list(
        latitude = lat, longitude = lon
    ))
}

near_geo_helper <- function(location, miles, latitude, longitude, type,
                            include_alternate = TRUE,
                            include_past = FALSE,
                            include_self_employed = TRUE,
                            include_seasonal = FALSE,
                            include_student_local = FALSE,
                            include_student_permanent = FALSE) {
    assertthat::assert_that(
        assertthat::is.number(miles)
    )

    if (!include_past) status <- c("A", "K")
    else status <- NULL

    type <- address_type_builder(
        type = type,
        include_alternate = include_alternate,
        include_past = include_past,
        include_self_employed = include_self_employed,
        include_seasonal = include_seasonal,
        include_student_local = include_student_local,
        include_student_permanent = include_student_permanent
    )


    if (!is.null(latitude) && !is.null(longitude)) {
        assertthat::assert_that(
            assertthat::is.number(latitude),
            assertthat::is.number(longitude)
        )
        return(near_geo(
            lat = latitude,
            long = longitude,
            miles = miles,
            type = type
        ))
    }

    assertthat::assert_that(
        assertthat::is.string(location)
    )
    geo <- geocode_location(location)
    lat <- geo$latitude
    long <- geo$longitude
    near_geo(lat = lat, long = long,
             miles = miles, type = type, status = status)
}

near_geo <- function(lat, long, miles, type, status) {
    lat <- force(lat)
    long <- force(long)
    miles <- force(miles)
    type <- force(type)

    widget_builder(
        table = "d_bio_address_mv",
        id_field = "entity_id",
        id_type = "entity_id",
        parameter = substitute(
            3963.1 * 2 * atan2( sqrt (
                power( sin ( (latitude - lat) * 0.01745329 / 2), 2) +
                    cos(latitude * 0.01745329 ) *
                    cos(lat * 0.01745329 ) *
                    power( sin ( (longitude - long) * 0.01745329 / 2), 2)
            ), sqrt (1 - (
                power( sin ( (latitude - lat) * 0.01745329 / 2), 2) +
                    cos(latitude * 0.01745329 ) *
                    cos(lat * 0.01745329 ) *
                    power( sin ( (longitude - long) * 0.01745329 / 2), 2)
            ))) < miles),
        switches = list(
            string_switch("contact_type_desc", "ADDRESS"),
            string_switch("addr_type_code", type),
            string_switch("addr_status_code", status_switch),
            quote(trim(latitude) != ' '),
            quote(trim(longitude) != ' '),
            substitute(latitude >=  lat - (miles / 69)),
            substitute(latitude <=  lat + (miles / 69)),
            substitute(longitude >= long - (miles / (69 * cos(lat * 0.01745329)))),
            substitute(longitude <= long + (miles / (69 * cos(lat * 0.01745329))))
        )
    )
}
