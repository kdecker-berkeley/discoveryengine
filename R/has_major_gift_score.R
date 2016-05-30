#' Major gift score widget
#' @param ... major gift score descriptors (more, most, etc)
#' @export
has_major_gift_score <- function(..., env = parent.frame()) {
    predictive_model_widget(..., type = "MGS", env = env)
}

#' @rdname has_major_gift_score
#' @export
has_major_gift_score_ <- function(likelihood, env = parent.frame()) {
    predictive_model_widget_(likelihood, type = "MGS", env = env)
}
