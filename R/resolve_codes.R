resolve_codes <- function(codes, type) {
    codes
}

resolve_date <- function(dt) {
    if (!is.null(dt)) as.integer(dt)
    else dt
}
