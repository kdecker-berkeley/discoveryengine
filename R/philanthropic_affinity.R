philanthropic_affinity_ <- function(types, atleast = 0, env = parent.frame()) {
    param <- types
    atleast <- atleast
    param1 <- substitute(other_affinity_type %in% param)
    atleast <- substitute(sum(gift_amt) >= atleast)
    aggregate_q_(table = "d_oth_phil_affinity_mv",
                 where = list(param1),
                 having = list(atleast),
                 id_field = "entity_id",
                 id_type = "cads_id",
                 schema = "CDW", env = env)
}

philanthropic_affinity <- function(..., atleast = 0, env = parent.frame()) {
    param <- pryr::dots(...)
    param <- prep_string_param(param, env = env)
    philanthropic_affinity_(param, atleast = atleast, env = env)
}
