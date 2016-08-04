prep_dots <- function(...) {
    lazyeval::lazy_dots(..., .follow_symbols = TRUE)
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
