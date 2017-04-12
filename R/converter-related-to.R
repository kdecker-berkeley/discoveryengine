related_to_ <- function(savedlist, relation_type) {
    converter_builder(savedlist,
                      table = "d_bio_relationship_mv",
                      from = "entity_id",
                      from_type = "entity_id",
                      to = "relation_entity_id",
                      to_type = "entity_id",
                      parameter = string_param("relation_type_code", relation_type))

}

#' A relation of a person
#'
#' For an existing disco engine list definition, get relations of those entities.
#' Not entering any relationship type codes results in finding all relations
#' (brothers, sisters, colleagues, spouses, etc.).
#'
#' Many relationship types in CADS have multiple codes, to represent each side
#' of the relationship type. For instance, "Mother" is encoded by both "SM"
#' (presumably for "Son-Mother") and "DM" ("Daughter-Mother"). This can lead to
#' confusion and frustration. We are looking for better ways to work with
#' relationships, but are constrained by how data exists in \code{CADS}. Make
#' sure to check TMS code tables to get all of the correct codes.
#'
#' @param savedlist A discoveryengine definition
#' @param ... Relationship type codes (\code{relation_type_code}). Leave empty
#' to search for all relationships.
#'
#'
#' @seealso \code{\link{parent_of}}, \code{\link{child_of}}
#'
#'
#' @examples
#' ## say we want to identify siblings of founders
#' ## start by identifying founders, via the founders pledge
#' founder = has_affiliation(founders_pledge)
#'
#' ## brother and sister each have two different codes (see details above)
#' founder_sibling = related_to(founder, SB, BS, SS, BB)
#' display(founder_sibling)
#'
#' @export
related_to <- function(savedlist, ...) {
    relation_type <- prep_dots(...)
    reroute(related_to_(savedlist, relation_type))
}
