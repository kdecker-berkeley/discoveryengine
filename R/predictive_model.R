predictive_model_ <- function(likelihood, type, env = parent.frame()) {
    param <- likelihood
    param <- resolve_codes(param, "dp_interest_code")
    p2 <- type
    param1 <- substitute(dp_interest_code %in% param)
    param2 <- substitute(dp_rating_type_code %in% p2)
    bio_("demographic_profile", list(param1, param2))
}

predictive_model <- function(..., type, env = parent.frame()) {
    param <- pryr::dots(...)
    param <- prep_string_param(param, env = env)
    predictive_model_(param, type = type, env = env)
}
