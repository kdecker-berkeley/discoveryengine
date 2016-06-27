#' Interest code widget
#' @param ... Interest code(s)
#' @export
has_interest <- function(...) {
    interests <- prep_dots(...)
    reroute(has_interest_(interests))
}

#' @rdname has_interest
#' @export
has_interest_ <- function(interests) {
    entity_widget("d_bio_interest_mv",
                  parameter = string_param("interest_code", interests))
}
