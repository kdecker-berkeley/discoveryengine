reroute <- function(...) {
    tryCatch(
        ...,
        synonym_request = function(req) {
            signalCondition(req)
            synonym_list(req$field_name, req$search_terms)
        },
        error = function(e) stop(e$message, call. = FALSE)
    )
}
