#' Major gift score widget
#' @param ... major gift score descriptors (more, most, etc)
#' @export
has_major_gift_score <- function(...) {
    predictive_model_widget(..., type = "MGS")
}

#' @rdname has_major_gift_score
#' @export
has_major_gift_score_ <- function(likelihood) {
    predictive_model_widget_(likelihood, type = "MGS")
}
