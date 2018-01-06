#' The spouse of a person
#'
#' @param ... one or more existing discoveryengine definition(s), and/or individual entity id(s)
#'
#' @examples
#' ## looking for CNR donors who are not degreeholders,
#' ## but this doesn't work, because it returns the spouses
#' ## of CNR degreeholders who receive credit for household gifts
#' gave_to_area(CNR) %but_not% has_degree_from(NR)
#'
#' ## want to also exclude anyone married to a CNR degreeholder:
#' cnr_degreeholder = has_degree_from(NR)
#' gave_to_area(CNR) %but_not%
#'     (cnr_degreeholder %or% married_to(cnr_degreeholder))
#'
#' @seealso \code{\link{household}}
#' @export
married_to <- function(...) {
    reroute(married_to_(entity_id_param(...)))
}

married_to_ <- function(savedlist) {
    converter_builder(savedlist,
                      table = "d_entity_mv",
                      from = "entity_id",
                      to = "spouse_entity_id", to_type = "entity_id")
}
