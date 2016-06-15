daterange <- function(field_name, from, to) {
    from <- resolve_date(from)
    to <- resolve_date(to)

    if (is.null(from) && is.null(to)) {
        return(NULL)
    } else if (is.null(from)) {
        dateop <- quote(`<=`)
        date1 <- to
    } else if (is.null(to)) {
        dateop <- quote(`>=`)
        date1 <- from
    } else {
        dateop <- quote(between)
        date1 <- from
    }

    .call <- list(
        dateop,
        as.name(field_name)
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
