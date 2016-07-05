#' Implied capacity widget
#' @param ... Predictive model score descriptions (most, more, etc)
#' @export
has_implied_capacity <- function(...) {
    reroute(has_implied_capacity_(prep_dots(...)))
}

has_implied_capacity_ <- function(likelihood) {
    predictive_model_widget(likelihood, type = "CAP")
}
