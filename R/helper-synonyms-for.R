synonyms_for <- function(type) {
    dict <- cdw_tms_dictionary()
    dict <- as.data.frame(lapply(dict, tolower), stringsAsFactors = FALSE)
    dict_row <- dplyr::filter(dict, cdw_column_name == type)

    if (nrow(dict_row) >= 1L) {
        tms <- unique(dict_row[["tms"]])[[1]]

        qry <- code_query(tms)
        syn_df <- getcdw::get_cdw(qry)
        keep <- which(syn_df[["view_name"]] == tms & !grepl("^\\*", syn_df[["description"]]))
        syn_df <- syn_df[keep, c("code", "syn"), drop = FALSE]

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
