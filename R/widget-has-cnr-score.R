#' @rdname predictive_model
#' @export
has_cnr_score <- function(...) {
    reroute(has_cnr_score_(prep_dots(...)))
}

has_cnr_score_ <- function(likelihood) {
    predictive_model_widget(likelihood, type = "CNR")
}
