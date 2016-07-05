#' Entities in a unit portfolio
#'
#' @param ... Office code(s)
#' @param include_inactive Include inactive proposals/assignments?
#'
#' @export
in_unit_portfolio <- function(..., include_inactive = FALSE) {
    offices <- prep_dots(...)
    reroute(in_unit_portfolio_(offices, include_inactive))
}

in_unit_portfolio_ <- function(offices, include_inactive = FALSE) {

    proposals <- proposal_widget(offices = offices,
                                 include_inactive = include_inactive)

    # inactive flag can be on proposal or assignment
    if (include_inactive)
        active_ind <- c("Y", "N")
    else active_ind <- "Y"

    converter_builder(proposals,
                      table = "f_proposal_mv",
                      from = "proposal_id",
                      to = "entity_id",
                      switches = string_switch("active_ind", active_ind))
}
