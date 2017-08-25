#' The parent or child of a person
#'
#' This uses just "Son" and "Daughter" for the definition of child, and just
#' "Mother" and "Father" for the definition of parent. For a more custom use of
#' relationship codes, use \code{\link{related_to}}.
#'
#' @param ... A discoveryengine definition of type \code{entity_id}, and/or individual entity ids
#'
#' @examples
#' ## finding the children of wealthy parents
#' is_wealthy = has_capacity(1:9) %or% has_implied_capacity(more, most)
#' child_of(is_wealthy)
#'
#' ## or the parents of wealthy children
#' parent_of(is_wealthy)
#' @name parent_child
#' @seealso \code{\link{related_to}}
NULL

#' @rdname parent_child
#' @export
parent_of <- function(...) {
    related_to_(entity_id_param(...), c("SF", "SM", "DF", "DM"))
}
