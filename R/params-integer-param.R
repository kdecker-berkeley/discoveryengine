integer_param <- function(field_name, ints, default = NULL) {
    codelist <- prep_integer_param(ints)
    if (length(codelist) <= 0) {
        if (is.language(default)) return(default)
        else codelist <- default
    }
    operator <- param_operator(codelist)

    # params will be of the form x %in% y
    if (length(codelist) > 0) {
        .call <- list(
            operator,
            as.name(field_name),
            codelist
        )
        return(list(as.call(.call)))
    }

    # null when no parameters
    NULL
}
