corp_parent <- function(...) {
    ent_id <- entity_id_param(...)
    converter_builder(
        ent_id,
        table = "d_entity_mv",
        from = "entity_id",
        from_type = "entity_id",
        to = "parent_corp_id",
        to_type = "entity_id"
    )
}
