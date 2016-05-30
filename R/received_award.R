#' @export
received_award <- function(..., env = parent.frame()) {
    awards <- pryr::dots(...)
    received_award_(awards, env = env)
}

received_award_ <- function(awards, env = parent.frame()) {
    d_bio_widget("award",
                 parameter = string_param("awd_honor_code", awards, env = env),
                 env = env)
}

