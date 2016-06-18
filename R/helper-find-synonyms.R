find_synonyms <- function(widget, search_terms = NULL) {
    do.call(widget, list(paste("?", search_terms, sep = "")))
}
