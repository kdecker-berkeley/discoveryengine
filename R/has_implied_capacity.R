#' Implied capacity widget
#' @param ... Predictive model score descriptions (most, more, etc)
#' @export
has_implied_capacity <- function(..., env = parent.frame()) {
    predictive_model_widget(..., type = "CAP", env = env)
}

#' @rdname has_implied_capacity
#' @export
has_implied_capacity_ <- function(likelihood, env = parent.frame()) {
    predictive_model_widget_(likelihood, type = "CAP", env = env)
}
