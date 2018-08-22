#' Create a definition based on specific IDs
#'
#' Other widgets build pools based on definitions, where the pool is anyone who
#' satisfies the definition. These widgets, on the other hand, allow you to
#' select specific individuals -- this can come in handy if you've been
#' hand-curating a list of entities or funds through other means and need to
#' be able to combine that with Disco Engine widgets.
#'
#' @param ... IDs, separated by commas
#'
#' @examples
#' entities(1234, 640993)
#' funds(FW5142000, S00038000)
#'
#' ## note that these are just like any other disco definition
#' ## for example, you can combine them with other widgets
#' entities(1234, 640993) %and% majored_in(mathematics)
#'
#' @name manual
#' @export
entities <- function(...) {
    reroute(entities_(prep_dots(...)))

}

entities_ <- function(ids) {
    ids <- prep_integer_param(ids)
    if (length(ids) <= 0) return(is_a(include_deceased = TRUE))
    negation <- attr(ids, "negation")

    res <- listbuilder::idlist(ids, id_type = "entity_id", quoted = FALSE)

    if (!is.null(negation) && negation)
        return(is_a(include_deceased = TRUE) %but_not% res)
    else return(res)

}
