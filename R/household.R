#' @export
household <- function(savedlist) {
    stopifnot(get_id_type(savedlist) == "entity_id")
    listbuilder::flist_(savedlist, table = "d_entity_mv",
                        from = "entity_id", to = "hh_corp_entity_id",
                        id_type = "entity_id", .dots = NULL,
                        schema = "CDW", env = parent.frame())
}
