synonyms_for <- function(type) {
    function_name <- paste0(type, "_synonyms")

    if (!existsFunction(function_name))
        stop("no synonyms defined for ", type,
             call. = FALSE)
    do.call(function_name, list())
}
