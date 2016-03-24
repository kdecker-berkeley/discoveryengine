related_to_ <- function(savedlist, relation_type, env = parent.frame()) {
    stopifnot(listbuilder:::get_id_type(savedlist) == "cads_id")
    param <- relation_type
    #param <- resolve_codes(param, "relation_type_code")
    flist_(savedlist, table = "d_bio_relationship_mv",
           from = "entity_id", to = "relation_entity_id",
           id_type = "cads_id",
           list(substitute(relation_type_code %in% param)))
}

related_to <- function(savedlist, ..., env = parent.frame()) {
    param <- pryr::dots(...)
    param <- prep_string_param(param, env = env)
    related_to_(savedlist, param, env = env)
}
