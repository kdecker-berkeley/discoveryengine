has_interest_ <- function(interests, env = parent.frame()) {
  param <- interests
  param <- resolve_codes(param, "interest_code")
  param1 <- substitute(interest_code %in% param)
  if (length(param) > 0)
      params <- list(param1)
  else params <- NULL
  bio_("interest", params)
}

#' @export
has_interest <- function(..., env = parent.frame()) {
  param <- pryr::dots(...)
  param <- prep_string_param(param, env = env)
  has_interest_(param, env = env)
}
