#' Find proposals based on type
#'
#' @param ... proposal type code(s)
#'
#' @export
proposal_type <- function(...) {
    reroute(proposal_type_(prep_dots(...)))
}

proposal_type_ <- function(types) {
    widget_builder_custom(
        custom = proposal_query(),
        id_field = "assignment_id",
        id_type = "assignment_id",
        parameter = string_param("proposal_type", types)
    )
}

