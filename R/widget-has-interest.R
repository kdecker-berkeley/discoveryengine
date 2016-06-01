#' Interest code widget
#' @param ... Interest code(s)
#' @export
has_interest <- function(...) {
    interests <- prep_dots(...)
    has_interest_(interests)
}

#' @rdname has_interest
#' @export
has_interest_ <- function(interests) {
    d_bio_widget("interest",
                 parameter = string_param("interest_code", interests))
}
