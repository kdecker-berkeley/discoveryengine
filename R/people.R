#' @rdname people
#' @export
people_ <- function(.dots, env = parent.frame()) {
    simple_q_(table = "d_entity_mv",
              where = .dots, id_field = "entity_id",
              id_type = "entity_id", schema = "CDW")
}

#' Basic entity query
#'
#' @param ... any conditions
#' @param include_deceased should deceased individuals be included? (Defaults to FALSE)
#' @param env evaluation environment
#'
#' @importFrom pryr dots
#' @export
people <- function(..., env = parent.frame()) {
    l <- pryr::dots(...)
    people_(l, env = env)
}
