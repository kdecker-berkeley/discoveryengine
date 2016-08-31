#' Predictive model widgets
#'
#' Find entities who have selected scores on predictive models
#'
#' Use score descriptions (more_likely, most_likely, etc). If no score descriptions
#' are entered, widget will look for anyone with a score on the predictive model.
#'
#' @return A definition of type \code{entity_id}
#'
#' @param ... score descriptors(more, most, etc)
#'
#' @examples
#' has_implied_capacity(more_likely, most_likely, somewhat_likely)
#' has_major_gift_score(most_likely, more_likely)
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
