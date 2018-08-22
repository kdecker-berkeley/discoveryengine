#' Capacity widget
#'
#' Find entities with specific researched capacity ratings.
#'
#' This widget will only look for current (active) capacity ratings. Enter one
#' or more ratings using just the integer code (eg: 1, 5), not the description.
#' Use the colon to indicate a range (eg: 1:10 for $100K+). If no ratings are
#' entered, then by default the widget will find people who have any rating between
#' 1 and 14 (note that 99s are not included by default).
#'
#' @return A definition of type \code{entity_id}
#'
#' @param ... capacity rating codes (eg: 1, 10, 99, 1:9)
#'
#' @examples
#' ## $250K+ prospects
#' has_capacity(1:9)
#'
#' ## this would do the same thing
#' has_capacity(1, 2, 3, 4, 5, 6, 7, 8, 9)
#'
#' @export
has_capacity <- function(...) {
    reroute(has_capacity_(prep_dots(...)))
}

has_capacity_ <- function(caps) {
    entity_widget(
        table = "d_entity_mv",
        parameter = integer_param("capacity_rating_code", caps, default = 1:14)
    )
}
