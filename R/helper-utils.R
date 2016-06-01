prep_dots <- function(...) {
    lazyeval::lazy_dots(..., .follow_symbols = TRUE, .ignore_empty = FALSE)
}

partial_sub <- function(.dots) {
    conds <- lapply(.dots, lazyeval::as.lazy)
    lapply(conds,
           function(x) dplyr::partial_eval(x$expr, env = x$env))
}
