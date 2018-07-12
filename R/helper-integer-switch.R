integer_switch <- function(field_name, codes) {
    if (is.null(codes)) return(NULL)
    ints <- as.integer(codes)
    if (any(codes != ints)) stop(field_name, " must be an integer")

    .call <- list(
        quote(`%in%`),
        as.name(field_name),
        ints
    )
    as.call(.call)
}
