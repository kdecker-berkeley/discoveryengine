bio_ <- function(table, .dots, env = parent.frame()) {
    table = paste("d_bio", table, "mv", sep = "_")
    simple_q_(table = table, where = .dots,
              id_field = "entity_id", id_type = "cads_id",
              schema = "CDW")
}
