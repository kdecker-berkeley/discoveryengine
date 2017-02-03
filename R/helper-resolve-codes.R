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
    if (length(dt) > 1L)
        stop("I can only handle a single date a time. You entered:\n",
             paste(dt, collapse = "; "))

    if (is.null(dt)) return(dt)
    parsed_dt <- as.integer(dt)

    if (is.na(parsed_dt))
        stop(dt, " is not a valid date", call. = FALSE)

    validate_date(parsed_dt)
    parsed_dt

}

validate_date <- function(parsed_dt) {
    if (parsed_dt < 19000101)
        stop(parsed_dt, " is not a valid date", call. = FALSE)
    if (parsed_dt > 29991231)
        stop(parsed_dt, " is not a valid date", call. = FALSE)
    test <- as.Date(as.character(parsed_dt), format = "%Y%m%d")
    if (is.na(test))
        stop(parsed_dt, " is not a valid date", call. = FALSE)
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

    matching <- which(names(synonym_list) %in% terms)

    codes <- synonym_list[matching[!is.na(matching)]]
    unknown <- !terms %in% names(codes)

    if (any(unknown))
        stop("unrecognized ", type, "(s): ",
             paste(terms[unknown], collapse = ", "), call. = FALSE)
    unname(codes)
}
