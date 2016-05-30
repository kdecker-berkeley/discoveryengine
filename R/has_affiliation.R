#' Affiliation widget
#' @param ... affiliation code(s)
#' @param status affilition status codes ("C" for current, "F" for former)
#' @importFrom pryr dots
#' @export
has_affiliation <- function(..., status = c("C", "F"), env = parent.frame()) {
    affiliations <- pryr::dots(...)
    has_affiliation_(affiliations, status, env)
}

#' @rdname has_affiliation
#' @export
has_affiliation_ <- function(affiliations, status = c("C", "F"),
                             env = parent.frame()) {
    d_bio_widget("affiliation",
                 parameter = string_param("affil_code", affiliations,
                                          default = NULL),
                 switches = string_switch("affil_status_code", status),
                 env = env)
}
