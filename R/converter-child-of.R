#' @rdname parent_child
#' @export
child_of <- function(...) {
    related_to_(entity_id_param(...), c("CP"))
}
