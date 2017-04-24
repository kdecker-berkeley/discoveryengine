#' @rdname predictive_model
#' @export
has_haas_score <- function(...) {
    reroute(has_haas_score_(prep_dots(...)))
}

has_haas_score_ <- function(likelihood) {
    predictive_model_widget(likelihood, type = "HSB")
}
