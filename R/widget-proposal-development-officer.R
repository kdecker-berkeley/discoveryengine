#' @export
proposal_development_officer <- function(..., include_inactive = TRUE) {
    reroute(
        proposal_development_officer_(prep_integer_param(...),
                                      include_inactive = include_inactive))
}

proposal_development_officer_ <- function(officers, include_inactive = TRUE) {
    props <- proposal_widget(development_officers = officers, include_inactive = include_inactive)
    converter_builder(
        props, table = "f_assignment_mv",
        from = "proposal_id", to = "assignment_id"
    )
}
