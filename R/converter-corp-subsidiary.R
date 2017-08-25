#' @rdname corp_hierarchy
#' @export
corp_subsidiary <- function(...) {
    ent_id <- entity_id_param(...)
    converter_builder(
        ent_id,
        table = "d_entity_mv",
        from = "parent_corp_id",
        from_type = "entity_id",
        to = "entity_id",
        to_type = "entity_id"
    )
}
