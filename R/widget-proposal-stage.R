#' Find proposals based on current stage
#'
#' @param ... stage code(s)
#'
#' @export
proposal_stage <- function(...) {
    reroute(proposal_stage_(prep_dots(...)))
}

proposal_stage_ <- function(stages) {
    widget_builder_custom(
        custom = proposal_query(),
        id_field = "assignment_id",
        id_type = "assignment_id",
        parameter = string_param("current_stage", stages)
    )
}
