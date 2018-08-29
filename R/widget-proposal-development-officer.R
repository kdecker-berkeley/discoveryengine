#' Find proposals assigned to a given development officer
#'
#' @param ... A discoveryengine definition of type entity_id, and/or individual entity ids
#' @param include_inactive whether inactive assignments/proposals should be included
#'
#' @export
proposal_development_officer <- function(..., include_inactive = TRUE) {
    reroute(
        proposal_development_officer_(entity_id_param(...),
                                      include_inactive = include_inactive))
}

proposal_development_officer_ <- function(officers, include_inactive = TRUE) {
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

    converter_builder(
        proposals, table = "f_assignment_mv",
        from = "proposal_id", to = "assignment_id"
    )
}
