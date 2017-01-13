# has_music_interest <- has_interest(
#     band_music,
#     music,
#     recital_music,
#     world_music,
#     classical_music,
#     contemporary_music,
#     early_music
# )

disco_single <- function(
    predicate,
    author = "Tarak",
    date = Sys.Date(),
    description = "Dummy description",
    keywords = c("key", "words", "etc"),
    name = NULL
) {
    stopifnot(
        inherits(predicate, "listbuilder"),
        is.character(author),
        is.character(description),
        is.character(keywords),
        length(author) == 1L,
        length(description) == 1L,
        !is.na(author),
        !is.na(description)
    )

    if (is.null(name)) name <- deparse(substitute(predicate))

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

print.disco_single <- function(x, ...) {

}

new_archive <- function() {
    structure(
        new.env(parent = emptyenv()),
        class = c("archive", "environment")
    )
}

push_single <- function(archive, single) UseMethod("push_single")
list_singles <- function(archive) UseMethod("list_singles")
find_singles <- function(archive, search_term) UseMethod("find_singles")

push_single.archive <- function(archive, single) {
    stopifnot(inherits(single, "disco_single"))
    key <- digest::digest(single$predicate, algo = "md5")
    key <- stringr::str_sub(key, -7)
    if (exists(key, archive)) {
        old_single <- get(key, archive)
        msg <- paste0("It seems this single already exists! It was created by ",
                      old_single$author,  " on ", old_single$date)
        stop(msg)
    }
    assign(key, single, pos = archive)
    return(key)
}

list_singles.archive <- function(archive) {
    ids <- ls(archive)
    singles <- mget(ids, archive)
    summarize_single <- function(single)
        paste0(single$name, ": ", single$description, sep = "")
    res <- vapply(singles, summarize_single,
                  FUN.VALUE = character(1),
                  USE.NAMES = FALSE)
    res
}

find_singles.archive <- function(archive, search_term) {
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
