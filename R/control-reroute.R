reroute <- function(...) {
    tryCatch(
        ...,
        synonym_request = function(req) {
            signalCondition(req)
            synonym_list(req$field_name, req$search_terms)
        },
        field_request = function(req) {
            signalCondition(req)
            req$field_name
        },
        error = function(e) stop(e$message, call. = FALSE)
    )
}
