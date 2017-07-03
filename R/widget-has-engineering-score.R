#' @rdname predictive_model
#' @export
has_engineering_score <- function(...) {
    reroute(has_engineering_score_(prep_dots(...)))
}

has_engineering_score_ <- function(likelihood) {
    predictive_model_widget(likelihood, type = "ENG")
}
