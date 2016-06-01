#' Implied capacity widget
#' @param ... Predictive model score descriptions (most, more, etc)
#' @export
has_implied_capacity <- function(...) {
    predictive_model_widget(..., type = "CAP")
}

#' @rdname has_implied_capacity
#' @export
has_implied_capacity_ <- function(likelihood) {
    predictive_model_widget_(likelihood, type = "CAP")
}
