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
#' @param include_former If TRUE (default), will include all interest codes,
#' even if they have a stop date. If FALSE, will exclude codes with a stop date.
#'
#' @examples
#' has_interest(data_science)
#'
#' ## same as
#' has_interest(DAT)
#'
#' @export
has_interest <- function(..., include_former = TRUE) {
    interests <- prep_dots(...)
    reroute(has_interest_(interests, include_former = include_former))
}

has_interest_ <- function(interests, include_former = TRUE) {
    if (include_former) former_switch <- NULL
    else former_switch <- quote(stop_dt %is% null)
    entity_widget("d_bio_interest_mv",
                  parameter = string_param("interest_code", interests),
                  switches = former_switch)
}
