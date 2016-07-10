#' @rdname predictive_model
#' @export
has_implied_capacity <- function(...) {
    reroute(has_implied_capacity_(prep_dots(...)))
}

has_implied_capacity_ <- function(likelihood) {
    predictive_model_widget(likelihood, type = "CAP")
}
