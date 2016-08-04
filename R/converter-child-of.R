#' @rdname parent_child
#' @export
child_of <- function(savedlist) {
    related_to_(savedlist, c("MS", "FD", "MD", "FS"))
}
