#' Household a list of entities
#'
#' The \code{\link{display}} function has a built-in option to household, so
#' you will usually not need to use this function.
#'
#' Will return just the primary ID for a household, instead of both spouses. Note
#' that it will not household additional parts of the definition that are added
#' after the `household` command (see examples).
#'
#'
#' @param savedlist an existing discoveryengine definition
#'
#' @examples
#' is_wealthy = has_capacity(1:7)
#' is_wealthy_hh = household(is_wealthy)
#'
#' ## this will NOT household the additional part of the definition
#' is_wealthy_hh %or% lives_in_msa(san_francisco)
#'
#' ## better to get everything together, then household:
#' household(is_wealthy %or% lives_in_msa(san_francisco))
#'
#' @export
household <- function(savedlist) {
    stopifnot(listbuilder::get_id_type(savedlist) == "entity_id")

    converter_builder(savedlist,
                      table = "d_entity_mv",
                      from = "entity_id",
                      to = "hh_corp_entity_id", to_type = "entity_id")
}
