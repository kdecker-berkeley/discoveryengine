has_major_gift_score_ <- function(likelihood, env = parent.frame()) {
    predictive_model_(likelihood, type = "MGS", env = env)
}

#' @export
has_major_gift_score <- function(..., env = parent.frame()) {
    param <- pryr::dots(...)
    param <- prep_string_param(param, env = env)
    has_major_gift_score_(param, env = env)
}
