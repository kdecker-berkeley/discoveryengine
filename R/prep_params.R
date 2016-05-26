prep_integer_param <- function(...) {
    param <- list(...)
    param <- as.integer(unlist(param))
    param <- param[!is.na(param)]
    param <- unique(param)
    param
}

#' @importFrom lazyeval interp
prep_string_param <- function(param, env = parent.frame()) {
    param <- lapply(param, lazyeval::interp, .values = env)
    param <- as.character(unlist(param))
    param <- param[!is.na(param)]
    param <- unique(param)
    param
}
