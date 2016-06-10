#' @export
household <- function(savedlist) {
    stopifnot(listbuilder::get_id_type(savedlist) == "entity_id")

    converter_builder(savedlist,
                      table = "d_entity_mv",
                      from = "entity_id",
                      to = "hh_corp_entity_id", to_type = "entity_id")
}
