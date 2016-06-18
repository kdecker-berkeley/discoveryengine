#' @export
has_philanthropic_affinity <- function(..., atleast = 0) {
    types <- prep_dots(...)
    reroute(has_philanthropic_affinity_(types, atleast))
}

has_philanthropic_affinity_ <- function(types, atleast = 0) {
    widget_builder(
        table = "d_oth_phil_affinity_mv",
        id_field = "entity_id",
        id_type = "entity_id",
        parameter = string_param("other_affinity_type", types),
        aggregate_switches = sum_switch("gift_amt", atleast)
    )
}
