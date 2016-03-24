parents_of <- function(savedlist) {
    related_to_(savedlist, c("SF", "SM", "DF", "DM"))
}

children_of <- function(savedlist) {
    related_to_(savedlist, c("MS", "FD", "MD", "FS"))
}
