prep_integer_param <- function(...) {
    param <- list(...)
    param <- as.integer(unlist(param))
    param <- param[!is.na(param)]
    param <- unique(param)
    param
}

prep_string_param <- function(param, field_name) {
    param <- Filter(function(x) !is.null(x), param)
    if (length(param) <= 0) return(character(0))

    # some codes have a integer/numeric form, eg activity codes
    param <- lapply(param,
                    function(x) if (is.numeric(x)) as.character(x) else x)

    # if input included quoted 0xxx, that will be evaluated by the interpreter
    # as an integer and the leading zeroes will drop.

    leading_zero_indices <- grepl("^0", param)
    param <- lapply(param, lazyeval::as.lazy)

    # can hijack the interpreter to have custom commands within
    # widgets with string params. eg widget_name(?search) to look
    # for synonyms
    check_for_instructions(field_name, param)

    interpreted_param <- partial_sub(param)

    # just replace with the original "0xx"
    if (any(leading_zero_indices))
        interpreted_param[leading_zero_indices] <- param[leading_zero_indices]
    interpreted_param <- as.character(unlist(interpreted_param))
    interpreted_param <- interpreted_param[!is.na(interpreted_param)]
    interpreted_param <- unique(interpreted_param)
    interpreted_param
}
