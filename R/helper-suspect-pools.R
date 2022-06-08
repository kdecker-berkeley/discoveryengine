#' Browse all suspect pools
#'
#' Pops up an interactive table that allows you to sort and search through a
#' listing of all suspect pools.
#'
#' @seealso \code{\link{in_suspect_pool}}
#' @export
show_suspect_pools <- function() {
    if (!requireNamespace("DT", quietly = TRUE)) {
        stop('DT package needed for show_suspect_pools to work.\n',
             'To install: install.packages("DT")',
             call. = FALSE)
    }

    pools <- suspect_pools()
    DT::datatable(pools, rownames = FALSE,
                  options = list(
                                        order = list(list(2, "asc"),
                                                       list(4, "asc")),
                                         pageLength = 10,
                                         scrollY = TRUE

                  ))
}

suspect_pools <- function () {
    sql <- "
select
  pool_type,
    pool_id,
    max(unit_code) as unit_code,
    max(unit_desc) as unit_desc,
    max(xcomment) as description,
    max(last_updated) as last_updated,
    count(distinct entity_id) as entities from (
    select
    case when prospect_interest_code = 'PP' then 'Pipeline' else 'Regular' end as pool_type,
    case when prospect_interest_code = 'PP' then ora_hash(unit_code || interest_amt, 2000000000, 19800401)
    else ora_hash(unit_code || xcomment, 2000000000, 19800401) end as pool_id,
    interest_amt,
    unit_code,
    unit_desc,
    operator_name,
    case when prospect_interest_code = 'PP' then unit_desc || ' (' || interest_amt || ')' else xcomment end as xcomment,
    date_added as last_updated,
    entity_id
    from CDW.d_prospect_interest_mv)
    group by
    pool_type,
    pool_id
    "
    # get it
    res <- getcdw::get_cdw(sql)
    res$last_updated <- as.Date(res$last_updated)
    res
}
