#' @export
played_sport <- function(...) {
    sports <- prep_dots(...)
    reroute(played_sport_(sports))
}

played_sport_ <- function(sports) {
    entity_widget("d_bio_sport_mv",
                  parameter = string_param("sport_code", sports))
}

