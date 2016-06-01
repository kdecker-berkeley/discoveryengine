related_to_ <- function(savedlist, relation_type) {
    stopifnot(listbuilder::get_id_type(savedlist) == "entity_id")
    listbuilder::flist_(savedlist,
                        table = "d_bio_relationship_mv",
                        from = "entity_id",
                        to = "relation_entity_id",
                        id_type = "entity_id",
                        where = string_param("relation_type_code", relation_type),
                        schema = "CDW")
}

#' @export
related_to <- function(savedlist, ...) {
    relation_type <- prep_dots(...)
    related_to_(savedlist, relation_type)
}
