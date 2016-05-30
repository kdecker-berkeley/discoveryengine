#' @export
played_sport <- function(..., env = parent.frame()) {
    sports <- pryr::dots(...)
    played_sport_(sports, env = env)
}

played_sport_ <- function(sports, env = parent.frame()) {
    d_bio_widget("sport",
                 parameter = string_param("sport_code", sports, env = env),
                 env = env)
}

