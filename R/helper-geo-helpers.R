check_geocode_cache_dir <- function() {
    dirpath <- geocode_cache_dir()
    if (!dir.exists(dirpath)) dir.create(dirpath)
}

geocode_cache_dir <- function() {
    path <- normalizePath("~/")
    file.path(path, ".disco-geocode-cache")
}

nominatim_curl <- ratelimitr::limit_rate(curl::curl, ratelimitr::rate(1, 1.1))
nominatim_dl <- function(url) {
    con <- nominatim_curl(url)
    on.exit(close(con))

    json <- readLines(con, warn = FALSE)
    lst <- jsonlite::fromJSON(json, simplifyVector = FALSE)
    if (length(lst) < 1)
        stop("There was a problem geocoding '", location, "'")

    lst[[1]]
}
memo_nominatim_dl <- memoise::memoise(nominatim_dl, cache = memoise::cache_filesystem(geocode_cache_dir()))

geocode_location_base <- function(location) {
    check_geocode_cache_dir()
    url <- "https://nominatim.openstreetmap.org/search/?q="

    if (!inherits(location, "AsIs")) {
        qry <- curl::curl_escape(location)
    } else {
        qry <- location
    }

    url <- paste0(url, qry, "&format=json")
    geo <- memo_nominatim_dl(url)

    lat <- as.numeric(geo$lat)
    lon <- as.numeric(geo$lon)

    if (length(lat) != 1L || length(lon) != 1L)
        stop("There was a problem :(")

    loc_used <- geo$display_name
    if (is.null(loc_used)) loc_used <- NA


    msg <- paste0(
        "Basing results on: ",
        loc_used, " (", round(lat, 4), ", ", round(lon, 4), ")")

    return(list(
        latitude = lat, longitude = lon, msg = msg
    ))
}

geocode_location <- memoise::memoise(geocode_location_base, cache = memoise::cache_filesystem("~/"))

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


    if (is.null(latitude) || is.null(longitude)) {
        assertthat::assert_that(assertthat::is.string(location))
        geo <- geocode_location(location)
        message(geo$msg)
        latitude <- geo$latitude
        longitude <- geo$longitude
    }

    near_geo(lat = latitude, long = longitude,
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
            string_switch("addr_status_code", status),
            quote(trim(latitude) != ' '),
            quote(trim(longitude) != ' '),
            substitute(latitude >=  lat - (miles / 69)),
            substitute(latitude <=  lat + (miles / 69)),
            substitute(longitude >= long - (miles / (69 * cos(lat * 0.01745329)))),
            substitute(longitude <= long + (miles / (69 * cos(lat * 0.01745329))))
        )
    )
}
