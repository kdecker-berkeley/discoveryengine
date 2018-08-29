#' Portfolio widgets
#'
#' Find entities in a given portfolio
#'
#' Uses the office associated with the proposal assignment to define portfolios.
#' If no offices are entered, then anyone in any portfolio will be included.
#'
#' @return A definition of type \code{entity_id}
#'
#' @param ... Office code(s)
#' @param include_inactive Should include inactive proposals/assignments? Defaults to FALSE
#'
#' @examples
#' in_unit_portfolio(governmental_studies, greater_good_science_center)
#'
#' @name portfolio
NULL

#' @rdname portfolio
#' @export
in_unit_portfolio <- function(..., include_inactive = FALSE) {
    offices <- prep_dots(...)
    reroute(in_unit_portfolio_(offices, include_inactive))
}

in_unit_portfolio_ <- function(offices, include_inactive = FALSE) {
    if (include_inactive)
        active_ind <- c("Y", "N")
    else active_ind <- "Y"

    proposals <- widget_builder(
        table = "f_assignment_mv",
        id_field = "proposal_id",
        id_type = "proposal_id",
        parameter = string_param("office_code", offices),
        switches = string_switch("active_ind", active_ind)
    )

    converter_builder(proposals,
                      table = "f_proposal_mv",
                      from = "proposal_id",
                      to = "entity_id",
                      switches = string_switch("active_ind", active_ind))
}
