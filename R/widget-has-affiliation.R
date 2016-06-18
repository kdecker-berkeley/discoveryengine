#' Affiliation widget
#' @param ... affiliation code(s)
#' @param status affilition status codes ("C" for current, "F" for former)
#' @export
has_affiliation <- function(..., status = c("C", "F")) {
    affiliations <- prep_dots(...)
    reroute(has_affiliation_(affiliations, status))
}

#' @rdname has_affiliation
#' @export
has_affiliation_ <- function(affiliations, status = c("C", "F")) {
    entity_widget("d_bio_affiliation_mv",
                  parameter = string_param("affil_code", affiliations),
                  switches = string_switch("affil_status_code", status))
}
