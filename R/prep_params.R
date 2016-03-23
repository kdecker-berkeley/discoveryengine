prep_integer_param <- function(...) {
    param <- list(...)
    param <- as.integer(unlist(param))
    param <- param[!is.na(param)]
    param <- unique(param)
    param
}

prep_string_param <- function(param, env = parent.frame()) {
    l <- param
    param <- partial_sub(substitute(l), env)
    param <- as.character(unlist(param))
    param <- param[!is.na(param)]
    param <- unique(param)
    param
}
