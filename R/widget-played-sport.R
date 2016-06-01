#' @export
played_sport <- function(...) {
    sports <- prep_dots(...)
    played_sport_(sports)
}

played_sport_ <- function(sports) {
    d_bio_widget("sport",
                 parameter = string_param("sport_code", sports))
}

