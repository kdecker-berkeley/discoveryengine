#' Affiliation widget
#' @param ... affiliation code(s)
#' @param status affilition status codes ("C" for current, "F" for former)
#' @export
has_affiliation <- function(..., include_former = TRUE) {
    affiliations <- prep_dots(...)
    reroute(has_affiliation_(affiliations, include_former))
}

has_affiliation_ <- function(affiliations, include_former = TRUE) {
    if (include_former) status <- c("C", "F")
    else status <- "C"
    entity_widget("d_bio_affiliation_mv",
                  parameter = string_param("affil_code", affiliations),
                  switches = string_switch("affil_status_code", status))
}
