#' @export
print.bot_results <- function(bigmap, ...) {
    printres <- function(df) {
        cat(df[["widget"]][[1]], "\n")
        codes <- df$code
        descr <- df$description
        for (index in seq_along(codes))
            cat("    ", codes[[index]], ": ", descr[[index]], "\n", sep = "")
    }

    lapply(attr(bigmap, "bot_results"), printres)
    invisible(bigmap)
}

as_code <- function(bot_results) UseMethod("as_code")
as_code.bot_results <- function(bot_results) {
    bigmap <- attr(bot_results, "bot_results")

    f <- function(widget, codes) {
        exdent <- stringr::str_length(widget) + 1L
        if (widget != names(bigmap)[[1]]) exdent <- exdent + 4L
        args <- paste(codes, collapse = ", ")
        args <- stringr::str_wrap(args, width = 80L, exdent = exdent)
        args
    }

    res <- paste(purrr::imap(bigmap, ~paste0(.y, "(", f(.y, .x$code), ")")),
                 collapse = " %or% \n    ")
    structure(res, class = c("bot_result_code", class(res)))
}

print.bot_result_code <- function(x, ...) {
    cat(x)
    invisible(x)
}
