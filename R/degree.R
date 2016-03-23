degree_ <- function(schools, levels = c("A", "U", "G", "L"), env = parent.frame()) {
    param <- schools
    param <- resolve_codes(param, "school_code")
    p2 <- levels
    param1 <- substitute(school_code %in% param)
    param2 <- substitute(degree_level_code %in% p2)
    bio_("degrees", list(param1, param2))
}

degree <- function(..., levels = c("A", "U", "G", "L"), env = parent.frame()) {
    param <- pryr::dots(...)
    param <- prep_string_param(param, env = env)
    degree_(param, levels = levels, env = env)
}

resolve_codes <- function(codes, type) {
  codes
}