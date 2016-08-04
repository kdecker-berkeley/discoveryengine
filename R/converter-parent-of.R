#' The parent or child of a person
#'
#' This uses just "Son" and "Daughter" for the definition of child, and just
#' "Mother" and "Father" for the definition of parent. For a more custom use of
#' relationship codes, use \code{\link{related_to}}.
#'
#' @param savedlist A discoveryengine definition
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
parent_of <- function(savedlist) {
    related_to_(savedlist, c("SF", "SM", "DF", "DM"))
}
