synonym_request_instruction <- function(field_name, search_terms) {
    condition(c("synonym_request", "special_instruction"),
              message = "",
              call = NULL,
              field_name = field_name,
              search_terms = search_terms)
}

check_for_instructions <- function(field_name, arguments) {
    if (any(grepl("\\?", arguments))) {
        queries <- grep("\\?", arguments)
        if (length(queries) > 0)
            search_terms <- gsub("[^a-z]", "", arguments[queries])
        else search_terms <- NULL
        signalCondition(synonym_request_instruction(field_name, search_terms))
    }
}

condition <- function(subclass, message, call = sys.call(-1), ...) {
    structure(
        class = c(subclass, "condition"),
        list(message = message, call = call, ...)
    )
}

