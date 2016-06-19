find_synonyms <- function(widget, search_terms = NULL) {
    if (is.null(search_terms)) search_terms <- "synonyms"

    make_call <- function(x)
        as.call(list(quote(`?`),
                     as.name(x)))

    .calls <- lapply(search_terms, make_call)

    do.call(widget, .calls)
}
