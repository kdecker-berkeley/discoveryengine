string_switch <- function(field_name, codes) {
    if (is.null(codes)) return(NULL)
    .call <- list(
        quote(`%in%`),
        as.name(field_name),
        codes
    )
    as.call(.call)
}
