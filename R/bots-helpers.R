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

#' Turn Bot results into valid disco-engine code
#'
#' This is a useful helper function for when you want to use several of the
#' results from the \code{\link{braistorm_bot}} or \code{\link{matrix_bot}} as
#' part of a Disco Engine definition.
#'
#' @param bot_results Results from a disco engine bot, such as
#' \code{\link{brainstorm_bot}} or \code{\link{matrix_bot}}.
#'
#' @examples
#' bb = brainstorm_bot("robot*")
#' bot_as_code(bb)
#'
#' @export
as_code <- function(bot_results) UseMethod("as_code")

#' @rdname as_code
#' @export
bot_as_code <- as_code

#' @export
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

#' @export
print.bot_result_code <- function(x, ...) {
    cat(x)
    invisible(x)
}
