string_param <- function(field_name, arguments, default = NULL, width = NULL,
                         side = "left", pad = "0") {
    validated_arguments <- prep_string_param(arguments, field_name = field_name)

    codelist <- resolve_codes(validated_arguments, type = field_name)

    if (!is.null(width)) {
        assertthat::assert_that(assertthat::is.count(width))
        codelist <- stringr::str_pad(codelist, width = width,
                                     side = side, pad = pad)
    }


    if (length(codelist) <= 0) {
        if (is.language(default)) return(default)
        else codelist <- default
    }


    # string params will be of the form x %in% y
    if (length(codelist) > 0) {
        .call <- list(
            quote(`%in%`),
            as.name(field_name),
            codelist
        )
        return(list(as.call(.call)))
    }

    # null when no parameters
    NULL
}

synonym_list <- function(field_name, search_terms = NULL) {
    vec <- synonyms_for(field_name)
    if (is.null(vec))
        stop("no synonyms defined for ", field_name, call. = FALSE)

    syn_df <- structure(data.frame(synonym = names(vec),
                                   code = unname(vec),
                                   stringsAsFactors = FALSE),
                        class = c("synonym_list", "data.frame"))

    if (is.null(search_terms)) return(syn_df)

    indices <- lapply(search_terms, function(search_term)
        grep(search_term, syn_df[["synonym"]], ignore.case = TRUE))
    indices <- unlist(indices)

    matching_synonyms <- syn_df[indices, , drop = FALSE]
    assertthat::assert_that(inherits(matching_synonyms, "data.frame"))

    if (nrow(matching_synonyms) == 0L) {
        warning("No synonyms contained ",
            paste("'", search_terms, "'", sep = "", collapse = ", "),
                call. = FALSE)
    }

    assertthat::assert_that(inherits(matching_synonyms, "data.frame"))
    matching_synonyms
}

#' @export
print.synonym_list <- function(s, ...) {
    print.data.frame(s, row.names = FALSE)
}
