#' Predictive model widgets
#'
#' Find entities who have selected scores on predictive models
#'
#' @param ... score descriptors(more, most, etc)
#'
#' @name predictive_model
NULL

#' @rdname predictive_model
#' @export
has_major_gift_score <- function(...) {
    reroute(has_major_gift_score_(prep_dots(...)))
}

has_major_gift_score_ <- function(likelihood) {
    predictive_model_widget(likelihood, type = "MGS")
}
