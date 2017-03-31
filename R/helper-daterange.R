date_operator <- function(from, to) {
    if (is.null(from) && is.null(to)) NULL
    else if (is.null(from)) quote(`<=`)
    else if (is.null(to)) quote(`>=`)
    else dateop <- quote(between)
}

daterange <- function(field_name, from, to) {
    from <- resolve_date(from)
    to <- resolve_date(to)

    dateop <- date_operator(from, to)
    if (is.null(dateop)) return(NULL)

    ## allow arbitrary SQL in addition to plain character field names:
    if (inherits(field_name, "sql")) fld <- field_name
    else fld <- as.name(field_name)

    .call <- list(
        dateop,
        fld
    )

    if (!is.null(from)) {
        from <- substitute(to_date(from, 'yyyymmdd'))
        .call <- c(.call, from)
    }
    if(!is.null(to)) {
        to <- substitute(to_date(to, 'yyyymmdd'))
        .call <- c(.call, to)
    }

    as.call(.call)
}
