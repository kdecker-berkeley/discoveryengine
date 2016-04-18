resolve_codes <- function(codes, type) {
    stopifnot(length(type) == 1L)

    ready_to_go <- upper_case(codes)
    needs_translation <- setdiff(codes, ready_to_go)

    translated <- recover_codes(needs_translation, type)
    c(ready_to_go, translated)
}

resolve_date <- function(dt) {
    if (!is.null(dt)) as.integer(dt)
    else dt
}

upper_case <- function(codes) {
    all_capitalized <- toupper(codes)
    codes[codes == all_capitalized]
}

recover_codes <- function(terms, type) {
    synonym_list <- synonyms_for(type)
    if (is.null(synonym_list)) return(terms)
    codes <- synonym_list[terms]
    unknown <- is.na(codes)

    if (any(unknown))
        stop("unrecognized ", type, "(s): ",
             paste(terms[unknown], collapse = ", "), call. = FALSE)
    unname(codes)
}
