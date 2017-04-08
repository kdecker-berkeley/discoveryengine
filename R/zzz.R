.onAttach <- function(libname, pkgname) {
    msg <- "Welcome to the Disco Engine! If you're not sure where to start, check out the cheat sheet: https://tarakc02.github.io/discodocs/cheat-sheet.html"
    msg <- paste0(
        msg, "  You are using version ", packageVersion("discoveryengine"),
        " of the Disco Engine. To see what the latest version number is, ",
        "and to see the list of updates and bugfixes in each version, ",
        "see https://github.com/tarakc02/discoveryengine/blob/master/NEWS.md")

    packageStartupMessage(
        paste(
            strwrap(
                msg, exdent = 2,
                width = pmin(.9 * getOption("width"), 80)),
            collapse = "\n"
        )
    )
}
