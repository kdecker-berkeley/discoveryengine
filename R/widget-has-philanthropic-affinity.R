#' Philanthropic affinity widget
#'
#' @param ... Philanthropic affinity type code(s)
#' @param at_least Minimum total giving to the selected philanthropic affinity type(s)
#' @export
has_philanthropic_affinity <- function(..., at_least = 0) {
    types <- prep_dots(...)
    reroute(has_philanthropic_affinity_(types, at_least))
}

has_philanthropic_affinity_ <- function(types, at_least = 0) {
    widget_builder(
        table = "d_oth_phil_affinity_mv",
        id_field = "entity_id",
        id_type = "entity_id",
        parameter = string_param("other_affinity_type", types),
        aggregate_switches = sum_switch("gift_amt", at_least)
    )
}
