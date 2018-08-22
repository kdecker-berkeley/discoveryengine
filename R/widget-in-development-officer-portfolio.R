#' @rdname portfolio
#' @export
in_development_officer_portfolio <- function(..., include_inactive = FALSE) {
    officers <- entity_id_param(...)
    reroute(in_development_officer_portfolio_(officers, include_inactive))
}

in_development_officer_portfolio_ <- function(officers, include_inactive = FALSE) {
    # inactive flag can be on proposal or assignment
    if (include_inactive)
        active_ind <- c("Y", "N")
    else active_ind <- "Y"

    proposals <- converter_builder(
        officers, table = "f_assignment_mv",
        from = "assignment_entity_id", from_type = "entity_id",
        to = "proposal_id", to_type = "proposal_id",
        switches = list(string_switch("active_ind", active_ind),
                        quote(proposal_id %is not% null))
    )

    converter_builder(proposals,
                      table = "f_proposal_mv",
                      from = "proposal_id",
                      to = "entity_id",
                      switches = string_switch("active_ind", active_ind))
}
