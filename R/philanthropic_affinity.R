#' @export
has_philanthropic_affinity <- function(..., atleast = 0, env = parent.frame()) {
    types <- pryr::dots(...)
    has_philanthropic_affinity_(types, atleast, env)
}

has_philanthropic_affinity_ <- function(types, atleast = 0, env = parent.frame()) {
    widget_builder(
        table = "d_oth_phil_affinity_mv",
        id_field = "entity_id",
        id_type = "entity_id",
        parameter = string_param("other_affinity_type", types, env = env),
        aggregate_switches = sum_switch("gift_amt", atleast),
        env = env
    )
}
