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


#' @export
publish <- function(single, ...) UseMethod("publish")

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

#' @export
publish.listbuilder <- function(single, ...) {
    single <- disco_single(single, ...)
    publish(single)
}


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
                      order = list(list(1, "asc"))
                  ))
}

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

#' @export
check_out <- function(...) {
    check_out_(prep_dots(...))
}

check_out_ <- function(single) {
    s <- partial_sub(single)
    if (length(s) != 1L) stop("Must specify exactly one single to check out")
    s <- s[[1]]
    s <- deparse(s)
    s <- get(s, envir = singles_db())
    s$predicate
}
