#' Interest code widget
#'
#' Find entities with a given interest(s)
#'
#' If no interests are entered, widget will search for entities with any interest
#' code.
#'
#' @return A definition of type \code{entity_id}
#'
#' @param ... Interest code(s)
#'
#' @examples
#' has_interest(data_science)
#'
#' ## same as
#' has_interest(DAT)
#'
#' @export
has_interest <- function(...) {
    interests <- prep_dots(...)
    reroute(has_interest_(interests))
}

has_interest_ <- function(interests) {
    entity_widget("d_bio_interest_mv",
                  parameter = string_param("interest_code", interests))
}
