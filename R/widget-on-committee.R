#' Committee participation widget
#'
#' Find entities on a particular committee(s)
#'
#' @details By default former committee memberships are included. To only look
#' for current committee memberships, use \code{include_former = FALSE}. If no
#' committees are entered, then the widget will look for people on any committee.
#'
#' @return A definition of type \code{entity_id}
#'
#' @param ... Committee code(s)
#' @param include_former Should former committee memberships be included (TRUE), or just current ones (FALSE)? Defaults to TRUE
#' @param comment (Optional) Supply one or more search terms to search through
#' the comment field
#'
#' @examples
#' ## anyone who has ever been on the BAM/Cal Performance board of trustees
#' on_committee(bam_board_of_trustees, cal_perf_board_of_trustees)
#'
#' ## current UCBF members
#' on_committee(uc_berkeley_foundation, include_former = FALSE)
#' @export
on_committee <- function(..., include_former = TRUE, comment = NULL) {
    committees <- prep_dots(...)
    reroute(on_committee_(committees, include_former = include_former))
}

on_committee_ <- function(committees, include_former = TRUE, comment = NULL) {
    if (!is.logical(include_former))
        stop("include_former must be TRUE or FALSE")
    if (include_former) status_code <- NULL
    else status_code <- c("C", "T")

    entity_widget("d_bio_committee_mv",
                  parameter = string_param("committee_code", committees),
                  switches = list(
                      string_switch("committee_status_code", status_code),
                      regex_switch("xcomment", comment)))
}
