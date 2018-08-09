#' @export
proposal_office <- function(..., include_inactive = TRUE) {
    reroute(proposal_office_(prep_dots(...), include_inactive = include_inactive))
}

proposal_office_ <- function(offices, include_inactive = TRUE) {
    props <- proposal_widget(offices = offices, include_inactive = include_inactive)
    converter_builder(
        props, table = "f_assignment_mv",
        from = "proposal_id", to = "assignment_id"
    )
}

