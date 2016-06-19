prep_dots <- function(...) {
    lazyeval::lazy_dots(..., .follow_symbols = TRUE)
}

partial_sub <- function(.dots) {
    lapply(.dots,
           function(x) dplyr::partial_eval(x$expr, env = x$env))
}
