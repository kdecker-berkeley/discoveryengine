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
                                   list(4, "asc"))
                  ))
}

suspect_pools <- function () {
    sql <- "
    select
      pool_id,
      max(unit_code) as unit_code,
      max(unit_desc) as unit_desc,
      listagg(operator_name, '; ') within group (order by NULL) as operator_name,
      max(xcomment) as xcomment,
      max(last_updated) as last_updated,
      sum(entities) as entities from (
    select
      ora_hash(unit_code || xcomment, 2000000000, 19800401) as pool_id,
      unit_code,
      unit_desc,
      operator_name,
      xcomment,
      max(date_added) as last_updated,
      count(distinct entity_id) as entities
    from CDW.d_prospect_interest_mv
    where prospect_interest_code not in ('PP')
    group by
      unit_code,
      unit_desc,
      operator_name,
      xcomment
      )
    group by
      pool_id
    "
    # get it
    res <- getcdw::get_cdw(sql)
    res$last_updated <- as.Date(res$last_updated)
    res
}
