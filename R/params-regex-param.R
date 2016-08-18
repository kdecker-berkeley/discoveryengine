regex_param <- function(field_name, search_strings, default = NULL) {
    search_strings <- partial_sub(search_strings)

    if (length(search_strings) <= 0) {
        if (is.language(default)) return(default)
        else search_strings <- default
    }

    single_search_string <- make_regex(search_strings)

    match_parameter <- "i"
    .call <- list(quote(regexp_like),
                  as.name(field_name),
                  single_search_string,
                  match_parameter)
    as.call(.call)
}
