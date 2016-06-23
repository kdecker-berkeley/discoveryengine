zipcode_param <- function(field_name, zips, default = NULL) {
    zips <- prep_zip_param(zips)
    if (requireNamespace("preprocessr", quietly = TRUE)) {
        zips <- preprocessr::tidy_zip(zips, length = 5)
    } else {
        warning('For safe handling of zipcodes, install the preprocessr package:',
                "\n", 'devtools::install_github("tarakc02/preprocessr")')
        zips <- as.character(zips)
    }

    zips <- zips[!is.na(zips)]

    if (length(zips) <= 0) {
        if (is.language(default)) return(default)
        else zips <- default
    }

    if (length(zips) > 0) {
        .call <- list(
            quote(`%in%`),
            as.name(field_name),
            zips
        )
        return(list(as.call(.call)))
    }
}
