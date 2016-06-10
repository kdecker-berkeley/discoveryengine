#' Implied capacity widget
#' @param ... Predictive model score descriptions (most, more, etc)
#' @export
has_implied_capacity <- function(...) {
    has_implied_capacity_(prep_dots(...))
}

#' @rdname has_implied_capacity
#' @export
has_implied_capacity_ <- function(likelihood) {
    predictive_model_widget(likelihood, type = "CAP")
}
