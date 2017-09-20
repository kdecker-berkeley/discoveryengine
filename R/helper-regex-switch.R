regex_switch <- function(field_name, search_strings) {
    if (is.null(search_strings)) return(NULL)
    single_search_string <- make_regex(search_strings)
    match_parameter <- "i"

    .call <- list(
        quote(REGEXP_LIKE),
        as.name(field_name),
        single_search_string,
        match_parameter
    )

    as.call(.call)
}
