make_field_request <- function(widget) {
    do.call(widget, list(quote(!field)))
}

synonym_request_instruction <- function(field_name, search_terms) {
    condition(c("synonym_request", "special_instruction"),
              message = "",
              call = NULL,
              field_name = field_name,
              search_terms = search_terms)
}

field_request_instruction <- function(field_name) {
    condition(c("field_request", "special_instruction"),
              message = "",
              call = NULL,
              field_name = field_name)
}

check_for_instructions <- function(field_name, param) {
    if (any(is_synonym_request(param))) {
        requests <- param[is_synonym_request(param)]
        search_terms <- extract_terms(requests, "synonyms")
        signalCondition(synonym_request_instruction(field_name, search_terms))
    }

    if (any(is_field_request(param))) {
        signalCondition(field_request_instruction(field_name))
    }
}

extract_terms <- function(requests, everything_term) {
    terms <- vapply(requests,
                    function(x) deparse(x$expr[[2]]),
                    FUN.VALUE = character(1))
    terms <- unname(terms)
    if (any(terms == everything_term)) terms <- NULL
    terms

}

is_synonym_request <- function(param) {
    parses <- lapply(param, function(x) as.list(x$expr))
    vapply(parses, function(x) identical(x[[1]], quote(`?`)) &&
               length(x) == 2L &&
               is.symbol(x[[2]]),
           FUN.VALUE = logical(1))
}

is_field_request <- function(param) {
    parses <- lapply(param, function(x) as.list(x$expr))
    vapply(parses, function(x) identical(x[[1]], quote(`!`)) &&
               length(x) == 2L &&
               is.symbol(x[[2]]),
           FUN.VALUE = logical(1))
}

condition <- function(subclass, message, call = sys.call(-1), ...) {
    structure(
        class = c(subclass, "condition"),
        list(message = message, call = call, ...)
    )
}

