string_param <- function(field_name, arguments, default = NULL) {
    validated_arguments <- prep_string_param(arguments)
    codelist <- resolve_codes(validated_arguments, type = field_name)

    if (length(codelist) <= 0) {
        if (is.language(default)) return(default)
        else codelist <- default
    }


    # string params will be of the form x %in% y
    if (length(codelist) > 0) {
        .call <- list(
            quote(`%in%`),
            as.name(field_name),
            codelist
        )
        return(list(as.call(.call)))
    }

    # null when no parameters
    NULL
}
