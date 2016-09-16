#' @rdname predictive_model
#' @export
has_gift_planning_score <- function(...) {
    reroute(has_gift_planning_score_(prep_dots(...)))
}

has_gift_planning_score_ <- function(likelihood) {
    predictive_model_widget(likelihood, type = "GPS")
}
