has_implied_capacity_ <- function(likelihood, env = parent.frame()) {
    predictive_model_(likelihood, type = "CAP", env = env)
}

has_implied_capacity <- function(..., env = parent.frame()) {
    param <- pryr::dots(...)
    param <- prep_string_param(param, env = env)
    has_implied_capacity_(param, env = env)
}
