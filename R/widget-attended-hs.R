#' Attended high school widget
#'
#' Find entities who attended a particular high school
#'
#' @return A discoveryengine list definition of type \code{entity_id}
#'
#' @param ... high-school institution codes
#'
#' @examples
#' attended_hs(050656)
#'
#' @export
attended_hs <- function(...) {
    hs = prep_dots(...)
    reroute(attended_hs_(hs))
}

attended_hs_ <- function(hs) {
    entity_widget("d_bio_degrees_mv",
                  parameter = string_param("institution_code", hs, width = 6),
                  switches = list(
                      string_switch("degree_code", "HS")
                  ))
}
