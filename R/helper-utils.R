prep_dots <- function(...) {
    res <- lazyeval::lazy_dots(..., .follow_symbols = TRUE)

    # dots should not be named, usually happens b/c user was trying to use
    # a switch but had a typo or said switch doesn't exist.

    argnames <- unique(names(res))
    argnames <- Filter(function(x) x != "", argnames)
    if (length(argnames) > 0)
        stop("Unrecognized argument(s): ", paste(argnames, collapse = ", "),
             call. = FALSE)
    res
}

partial_sub <- function(.dots) {
    reenv <- function(env) {
        newenv <- as.environment(as.list(env))
        parent.env(newenv) <- emptyenv()
        newenv
    }
    lapply(.dots,
           function(x) dplyr::partial_eval(x$expr, env = reenv(x$env)))
}
