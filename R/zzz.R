.onLoad <- function(libname, pkgname) {
    msg <- "Welcome to the Disco Engine! If you're not sure where to start, check out the cheat sheet: https://tarakc02.github.io/discodocs/cheat-sheet.html"

    packageStartupMessage(paste(strwrap(msg), collapse = "\n"))
}
