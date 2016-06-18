resolve_codes <- function(codes, type) {
    stopifnot(length(type) == 1L)

    ready_to_go <- is_upper_case(codes)
    needs_translation <- setdiff(codes, ready_to_go)
    if (length(needs_translation) > 0)
        translated <- recover_codes(needs_translation, type)
    else translated <- NULL

    unique(c(ready_to_go, translated))
}

resolve_date <- function(dt) {
    if (!is.null(dt)) as.integer(dt)
    else dt
}

is_upper_case <- function(codes) {
    all_capitalized <- toupper(codes)
    codes[codes == all_capitalized]
}

recover_codes <- function(terms, type) {
    synonym_list <- tryCatch(
        synonyms_for(type),
        error = function(e) stop(e$message, "\nunable to parse: ", paste(terms, collapse = ", "),
                     call. = FALSE)
    )

    codes <- synonym_list[terms]
    unknown <- is.na(codes)

    if (any(unknown))
        stop("unrecognized ", type, "(s): ",
             paste(terms[unknown], collapse = ", "), call. = FALSE)
    unname(codes)
}
