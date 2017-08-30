reformat_columns <- function(res, column_formats) {
    if (length(column_formats) == 0L) return(res)
    cols_to_modify <- names(column_formats)

    if (length(cols_to_modify[cols_to_modify != ""]) != length(column_formats))
        stop("All column_formats must be named")

    unidentified_cols <- !cols_to_modify %in% colnames(res)
    if (any(unidentified_cols))
        stop("Not all column formats understood: ", paste(unidentified_cols, collapse = ", "))

    for (i in seq_along(column_formats)) {
        res <- dplyr::mutate_at(
            res,
            .vars = names(column_formats)[[i]],
            .funs = column_formats[[i]]
        )
    }
    res
}
