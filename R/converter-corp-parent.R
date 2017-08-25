#' Get the parent/subsidiary corporation(s) associated with corporate entity ID(s)
#'
#' Every corporate record is included as its own own parent and subsidiary,
#' including standalone corporate records (where there is no additional hierarchy).
#' Otherwise, parent/subsidiary records will match what you see in the
#' corporate hierarchy screen in CADS. Person records do not have corporate
#' parents or subsidiaries.
#'
#' @param ... one or more entity IDs, or disco engine definitions of type \code{entity_id}
#'
#' @note If you want to \code{\link{display}} a definition that includes
#' corporate records, be sure to include the argument
#' \code{include_organizations = TRUE}, because organization records are
#' excluded by default (along with deceased records) when using \code{\link{display}}
#' (see examples).
#'
#' @examples
#' # general mills is the parent record of annie's homegrown:
#' corp_parent(3038697)
#'
#' # can enter multiple IDs
#' corp_subsidiary(2090340, 2000407)
#'
#' # can also enter other definitions
#' # this just gets me back to 2090340
#' google = corp_parent(corp_subsidiary(2090340))
#'
#' # note that i have to use include_organizations = TRUE when displaying
#' display(google, include_organizations = TRUE)
#'
#' @seealso \code{\link{works_at}}
#'
#' @name corp_hierarchy
#' @export
corp_parent <- function(...) {
    ent_id <- entity_id_param(...)
    converter_builder(
        ent_id,
        table = "d_entity_mv",
        from = "entity_id",
        from_type = "entity_id",
        to = "parent_corp_id",
        to_type = "entity_id"
    )
}
