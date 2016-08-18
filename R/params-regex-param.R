regex_param <- function(field_name, search_strings, default = NULL) {
    search_strings <- partial_sub(search_strings)
    search_strings <- trimws(search_strings)

    if (length(search_strings) <= 0) {
        if (is.language(default)) return(default)
        else search_strings <- default
    }
    classer <- function(obj, class) structure(obj, class = c(class,class(obj)))
    ora <- function(obj) classer(obj, "ora_regex")
    pd <- function(obj) classer(obj, "pd_regex")
    regex_types <- list(ora = ora, pd = pd)

    as_ora_regex <- function(search_strings) UseMethod("as_ora_regex")

    as_ora_regex.ora_regex <- function(search_strings) search_strings
    as_ora_regex.default <- function(search_strings) {
        is_valid <- grepl("^\\*?[^\\*]+\\*?$", search_strings)

        if (any(!is_valid))
            warning("the following search strings were ignored: ",
                    paste(search_strings[!is_valid], collapse = ", "),
                    call. = FALSE)
        search_strings[!is_valid] <- NA_character_

        search_strings <- gsub("^([^\\*])", "(^|\\\\s|\\\\W)\\1", search_strings)
        search_strings <- gsub("([^\\*])$", "\\1($|\\\\s|\\\\W)", search_strings)
        search_strings <- gsub("^\\*", "", search_strings)
        search_strings <- gsub("\\*$", "", search_strings)
        search_strings
    }
    search_strings <- lapply(search_strings, eval, envir = regex_types)

    search_strings <- vapply(search_strings, function(s) as_ora_regex(s),
                             FUN.VALUE = character(1))
    search_strings <- Filter(function(x) !is.na(x) && nchar(x) > 0, search_strings)
    if (length(search_strings) <= 0)
        stop("was unable to process search request")

    single_search_string <- search_concat(search_strings)

    match_parameter <- "i"
    .call <- list(quote(regexp_like),
                  as.name(field_name),
                  single_search_string,
                  match_parameter)
    as.call(.call)
}

search_concat <- function(search_strings) {
    paste("(", search_strings, ")",
          sep = "", collapse = "|")
}
