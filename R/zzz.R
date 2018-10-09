.onAttach <- function(libname, pkgname) {
    msg <- paste0(
        "Welcome to Disco Engine version ", packageVersion("discoveryengine"), "\n",
        "Cheat sheet: https://cwolfsonseeley.github.io/discodocs/cheat-sheet.html", "\n",
        "News and bugfixes: https://github.com/cwolfsonseeley/discoveryengine/blob/master/NEWS.md"
    )
    packageStartupMessage(msg)
}
