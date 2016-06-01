#' @export
received_award <- function(...) {
    awards <- prep_dots(...)
    received_award_(awards)
}

received_award_ <- function(awards) {
    d_bio_widget("award",
                 parameter = string_param("awd_honor_code", awards))
}

