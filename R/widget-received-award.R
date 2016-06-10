#' @export
received_award <- function(...) {
    awards <- prep_dots(...)
    received_award_(awards)
}

received_award_ <- function(awards) {
    entity_widget("d_bio_award_mv",
                  parameter = string_param("awd_honor_code", awards))
}

