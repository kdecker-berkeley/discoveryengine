#' Interest code widget
#' @param ... Interest code(s)
#' @export
has_interest <- function(..., env = parent.frame()) {
    interests <- pryr::dots(...)
    has_interest_(interests, env)
}

#' @rdname has_interest
#' @export
has_interest_ <- function(interests, env = parent.frame()) {
    d_bio_widget("interest",
                 parameter = string_param("interest_code", interests,
                                          default = NULL, env = env),
                 env = env)
}
