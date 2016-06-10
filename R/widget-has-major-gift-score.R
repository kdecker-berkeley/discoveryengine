#' Major gift score widget
#' @param ... major gift score descriptors (more, most, etc)
#' @export
has_major_gift_score <- function(...) {
    has_major_gift_score_(prep_dots(...))
}

#' @rdname has_major_gift_score
#' @export
has_major_gift_score_ <- function(likelihood) {
    predictive_model_widget(likelihood, type = "MGS")
}
