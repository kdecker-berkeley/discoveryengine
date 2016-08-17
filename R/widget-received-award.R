#' @export
received_award <- function(...) {
    awards <- prep_dots(...)
    reroute(received_award_(awards))
}

received_award_ <- function(awards) {
    entity_widget("d_bio_awards_and_honors_mv",
                  parameter = string_param("awd_honor_code", awards))
}

