synonyms_for <- function(type) {
    dict <- cdw_tms_dictionary()
    dict <- as.data.frame(lapply(dict, tolower), stringsAsFactors = FALSE)
    dict_row <- dplyr::filter(dict, cdw_column_name == type)

    if (nrow(dict_row) >= 1L) {
        tms <- unique(dict_row[["tms"]])[[1]]

        if (tms == "geo_code") {
            qry <- "
            select distinct
                geo_code as code,
                lower(regexp_replace(regexp_replace(trim(geo_code_description), '([^A-Za-z0-9 //_-])', ''), '((( )+)|-|(\\/))+', '_')) as syn
            from cdw.d_geo_metro_area_mv where geo_type = 1"
            syn_df <- getcdw::get_cdw(qry)
        } else {
            qry <-
                "select distinct
            tms_type_code as code,
            lower(regexp_replace(regexp_replace(trim(tms_type_desc), '([^A-Za-z0-9 //_-])', ''), '((( )+)|-|(\\/))+', '_')) as syn
            from CDW.d_tms_type_mv
            where tms_view_name = '##tms##'
            and tms_type_desc not like '*%'"

            qry <- getcdw::parameterize_template(qry)
            syn_df <- getcdw::get_cdw(qry(tms = tms))
        }

        # these are synonyms automatically generated from tms table
        res <- structure(syn_df$code, names = syn_df$syn)
    } else res <- character(0)

    # add in any additional synonyms that were manually defined
    # (eg: business or natural_resources)
    function_name <- paste0(type, "_synonyms")

    if (!existsFunction(function_name))
        return(res)
    additional_res <- do.call(function_name, list())
    res <- c(res, additional_res)
    dupes <- duplicated(names(res)) & duplicated(res)
    res[!dupes]
}
