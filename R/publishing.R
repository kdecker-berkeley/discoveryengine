new_archive <- function() {
    db <- structure(
        new.env(parent = emptyenv()),
        class = c("archive", "environment")
    )

}

singles_db <- function() readRDS("R:/Prospect Development/Prospect Analysis/disco-singles/db.discoveryengine")
save_singles_db <- function(db) saveRDS(db, file = "R:/Prospect Development/Prospect Analysis/disco-singles/db.discoveryengine")

#' @export
disco_single <- function(
    predicate,
    author = NULL,
    date = Sys.Date(),
    description = NULL,
    keywords = NULL,
    name = NULL
) {
    stopifnot(inherits(predicate, "listbuilder"))

    if (is.null(author))
        author <- readline("Enter the author's name: ")
    assertthat::assert_that(assertthat::is.string(author), !is.na(author))

    if (is.null(name)) {
        cat(stringr::str_wrap(paste(
            "Your single will need a name. Names should be valid R names, so
            no spaces or names starting with numbers."),
            width = 80L))
        name <- readline("Give your new single a catchy name: ")
    }
    assertthat::assert_that(assertthat::is.string(name), !is.na(name))
    goodname <- make.names(name)
    if (goodname != name)
        stop("Invalid name. Maybe something like: ", goodname, "?")

    if (is.null(description))
        description <- readline("Briefly describe what the single does: ")
    assertthat::assert_that(assertthat::is.string(description), !is.na(description))

    if (is.null(keywords))
        keywords <- trimws(strsplit(readline("Enter some keywords (separated by commas) to help find your single: "), ",")[[1]], "both")
    stopifnot(is.character(keywords), !any(is.na(keywords)))

    structure(
        list(
            name = name,
            predicate = predicate,
            author = author,
            date = date,
            description = description,
            keywords = keywords
        ), class = c("disco_single", "list")
    )
}

# print.disco_single <- function(x, ...) {
#     cat(x$name, ": A disco single, by ", x$author, "\n", sep = "")
#     cat("What it does:", x$description, "\n")
#     invisible(x)
# }

#' Publish a Disco Engine single
#'
#' Publishing a definition created in the Discovery Engine makes it easier to
#' share it with other users and helps build standards around constituency
#' definitions. Publish your own definitions (or "singles") using the
#' \code{publish} function, and view all singles that have already been
#' published using \code{show_singles()}.
#'
#' @details Publishing requires you to supply some metadata that will make it
#' easier for others to find your single when they need it (things like author's
#' name, description, and keywords). When you use \code{publish}, you'll be
#' prompted to enter each item of metadata, so read and follow the prompts.
#'
#' @param single The definition to be published
#' @param ... Can be used to specify metadata. You can leave this blank and follow
#' the interactive prompts.
#'
#' @examples
#' \dontrun{
#' ## Start by creating a definition
#' band_member = participated_in(MSMB)
#'
#' ## then just use the publish function and answer the prompts
#' publish(band_member)
#' }
#'
#' @seealso \code{\link{show_singles}} to view existing singles,
#' \code{\link{check_out}} to check out a published single.
#' @export
publish <- function(single, ...) UseMethod("publish")

#' @rdname publish
#' @export
publish.disco_single <- function(single, ...) {
    # note: if two people try to do this at the same time, only one write
    # will happen -- need to lock the file
    archive <- singles_db()
    if (exists(single$name, archive)) {
        old_single <- get(single$name, archive)
        msg <- paste0("It seems this single already exists! It was created by ",
                      old_single$author,  " on ", old_single$date)
        stop(msg)
    }
    assign(single$name, single, pos = archive)
    save_singles_db(archive)
    message("Congrats!")
    invisible(NULL)
}

#' @rdname publish
#' @export
publish.listbuilder <- function(single, ...) {
    single <- disco_single(single, ...)
    publish(single)
}

#' @rdname show_singles
#' @export
list_singles <- function() {
    archive <- singles_db()
    ids <- ls(archive)
    singles <- mget(ids, archive)
    summarize_single <- function(single)
        data.frame(
            name = single$name,
            description = single$description,
            author = single$author,
            keywords = paste(single$keywords, collapse = ","),
            stringsAsFactors = FALSE
        )
    rb <- function(...) rbind(..., make.row.names = FALSE,
                              stringsAsFactors = FALSE)
    do.call("rb", lapply(singles, summarize_single))
}

#' Browse available singles
#'
#' Any time a user \code{\link{publish}}es a new single, it gets listed and stored
#' along with keywords and a description that should make it easier to find.
#' \code{show_singles} allows you to view singles that have been published and
#' search through them.
#'
#' @seealso \code{\link{publish}}, \code{\link{check_out}}, \code{\link{find_singles}}
#' @export
show_singles <- function() {
    if (!requireNamespace("DT", quietly = TRUE)) {
        stop('DT package needed for show_singles to work.\n',
             'To install: install.packages("DT")',
             call. = FALSE)
    }

    singles_list <- list_singles()
    DT::datatable(singles_list, rownames = FALSE,
                  options = list(
                                order = list(list(1, "asc")),
                                pageLength = 10,
                                scrollY = TRUE
                  ))
}

#' Search for a particular single using keywords
#'
#' @param search_term A string to search for in the singles database
#'
#' @seealso \code{\link{show_singles}} for an interactive browser,
#' \code{\link{check_out}} to check out a single
#' @export
find_singles <- function(search_term) {
    archive <- singles_db()
    ids <- ls(archive)
    singles <- mget(ids, archive)

    search_index <- function(single)
        paste(single$description, paste(single$keywords, collapse = " "))
    indexed <- vapply(singles, search_index,
                      FUN.VALUE = character(1),
                      USE.NAMES = TRUE)
    matching <- grepl(search_term, indexed, ignore.case = TRUE)
    summarize_single <- function(single)
        paste0(single$name, ": ", single$description, sep = "")
    res <- vapply(singles[matching], summarize_single,
                  FUN.VALUE = character(1),
                  USE.NAMES = FALSE)
    if (length(res) <= 0L) stop("No singles found that match the search term '",
                                search_term, "'")
    res
}

#' @rdname find_singles
#' @export
single_for <- find_singles

#' Check out a single
#'
#' Check out a previously published single. Use \code{\link{show_singles}} to
#' find the single you're interested in, and check it out by name. In order to
#' use a single you've checked out, you'll probably want to assign it a name
#' (see examples).
#'
#' @details Note that \code{check_out} will return a single, but will not save it
#' in your current working environment. So in order to actually use the single,
#' you should assign it a name (see examples)
#'
#' @param ... The name of the single to check out
#'
#' @examples
#' \dontrun{
#' ## note how i assign the single a name (it can be the same as the published
#' ## name, but doesn't have to be).
#' ## i'll check out the in_bay_area single (found by browsing using show_singles)
#' in_bay_area = check_out(in_bay_area)
#'
#' ## the name i assign does not have to be the same as the published name:
#' bay = check_out(in_bay_area)
#'
#' ## use the checked out single like you'd use any other definition you created
#' ## example: display
#' display(bay)
#'
#' ## example: combine with other widgets
#' bay_math = bay %and% majored_in(mathematics)
#' }
#' @export
check_out <- function(...) {
    check_out_(prep_dots(...))
}

check_out_ <- function(single) {
    s <- partial_sub(single)
    if (length(s) != 1L) stop("Must specify exactly one single to check out")
    s <- s[[1]]
    s <- deparse(s)
    if (!exists(s, envir = singles_db()))
        stop("Single ", s, " not found! Are you sure you spelled it correctly? Use show_singles() to view available singles to check out", call. = FALSE)
    s <- get(s, envir = singles_db())
    s$predicate
}
