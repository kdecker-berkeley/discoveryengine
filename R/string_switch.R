string_switch <- function(field_name, codes) {
    .call <- list(
        quote(`%in%`),
        as.name(field_name),
        codes
    )
    as.call(.call)
}
