#' Major gift score widget
#' @param ... major gift score descriptors (more, most, etc)
#' @export
has_major_gift_score <- function(...) {
    reroute(has_major_gift_score_(prep_dots(...)))
}

has_major_gift_score_ <- function(likelihood) {
    predictive_model_widget(likelihood, type = "MGS")
}
