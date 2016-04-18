#' @export
parent_of <- function(savedlist) {
    related_to_(savedlist, c("SF", "SM", "DF", "DM"))
}

#' @export
child_of <- function(savedlist) {
    related_to_(savedlist, c("MS", "FD", "MD", "FS"))
}
