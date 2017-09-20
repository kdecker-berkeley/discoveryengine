#' Find entities who've received an award
#'
#' @param ... award/honor codes
#' @param comment (Optional) Supply one or more search terms to search through
#' the comment field
#'
#' @examples
#' ## find anyone who has won a nobel prize in physics
#' received_award(nobel_prize, comment = "physics")
#'
#' @export
received_award <- function(..., comment = NULL) {
    awards <- prep_dots(...)
    reroute(received_award_(awards, comment = comment))
}

received_award_ <- function(awards, comment = NULL) {
    entity_widget("d_bio_awards_and_honors_mv",
                  parameter = string_param("awd_honor_code", awards),
                  switches = regex_switch("comment1 || comment2", comment))
}

