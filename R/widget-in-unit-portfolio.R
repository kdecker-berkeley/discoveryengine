#' Entities in a unit portfolio
#'
#' @param ... Office code(s)
#' @param include_inactive Include inactive proposals/assignments?
#'
#' @export
in_unit_portfolio <- function(..., include_inactive = FALSE) {
    offices <- prep_dots(...)
    in_unit_portfolio_(offices, include_inactive)
}


#' @rdname in_unit_portfolio
#' @export
in_unit_portfolio_ <- function(offices, include_inactive = FALSE) {

    proposals <- proposal_widget(offices = offices,
                                 include_inactive = include_inactive)

    converter_builder(proposals,
                      table = "f_proposal_mv",
                      from = "proposal_id", from_type = "proposal_id",
                      to = "entity_id", to_type = "entity_id")
}
