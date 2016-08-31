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
#'
#' @examples
#' ## anyone who has ever been on the BAM/Cal Performance board of trustees
#' on_committee(bam_board_of_trustees, cal_perf_board_of_trustees)
#'
#' ## current UCBF members
#' on_committee(uc_berkeley_foundation, include_former = FALSE)
#' @export
on_committee <- function(..., include_former = TRUE) {
    committees <- prep_dots(...)
    reroute(on_committee_(committees, include_former = include_former))
}

on_committee_ <- function(committees, include_former = TRUE) {
    if (!is.logical(include_former))
        stop("include_former must be TRUE or FALSE")
    if (include_former) status_code <- c("C", "F")
    else status_code <- "C"

    entity_widget("d_bio_committee_mv",
                  parameter = string_param("committee_code", committees),
                  switches = string_switch("committee_status_code", status_code))
}
