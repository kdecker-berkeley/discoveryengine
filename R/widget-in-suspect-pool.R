#' Find entities in a given suspect pool
#'
#' The disco engine creates unique, persistent IDs for the suspect pools, in
#' order to make them queryable. To find the ID of your suspect pool, use
#' \code{\link{show_suspect_pools}}.
#'
#' @param ... Suspect Pool ID(s) -- see \code{\link{show_suspect_pools}}
#'
#' @return A definition of type \code{entity_id}
#'
#' @seealso \code{\link{show_suspect_pools}}
#' @export
in_suspect_pool <- function(...) {
    reroute(in_suspect_pool_(prep_dots(...)))
}

in_suspect_pool_ <- function(sp) {
    ids <- prep_integer_param(sp)
    if (length(ids) <= 0L) {
        parameter <- list()
    } else {
        operator <- param_operator(ids)
        parameter <- list(
            as.call(list(
                operator,
                substitute(
                    case_when(prospect_interest_code == 'PP' ~ ora_hash(unit_code %||% interest_amt, 2000000000L, 19800401L),
                              1L == 1L ~ ora_hash(unit_code %||% xcomment, 2000000000L, 19800401L))
                ),
                ids
            ))
        )
    }

    widget_builder(
        table = "d_prospect_interest_mv",
        id_field = "entity_id",
        id_type = "entity_id",
        parameter = parameter
    )
}
