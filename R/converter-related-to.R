related_to_ <- function(savedlist, relation_type) {
    converter_builder(savedlist,
                      table = "d_bio_relationship_mv",
                      from = "entity_id",
                      from_type = "entity_id",
                      to = "relation_entity_id",
                      to_type = "entity_id",
                      parameter = string_param("relation_type_code", relation_type))

}

#' @export
related_to <- function(savedlist, ...) {
    relation_type <- prep_dots(...)
    related_to_(savedlist, relation_type)
}
