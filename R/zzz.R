.onAttach <- function(libname, pkgname) {
    msg <- paste0(
        "Welcome to Disco Engine version ", packageVersion("discoveryengine"), "\n",
        "Cheat sheet: https://tarakc02.github.io/discodocs/cheat-sheet.html", "\n",
        "News and bugfixes: https://github.com/tarakc02/discoveryengine/blob/master/NEWS.md"
    )
    packageStartupMessage(msg)
}
