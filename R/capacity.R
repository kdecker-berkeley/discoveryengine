has_capacity <- function(...) {
    param <- prep_integer_param(...)
    param <- list(substitute(capacity_rating_code %in% param))
    people_(param)
}

has_capacity_ <- function(...) {
    has_capacity(...)
}
