#' Browse all saved lists
#'
#' Pops up an interactive table that allows you to sort and search through a
#' listing of all saved lists.
#'
#' @seealso \code{\link{in_savedlist}}
#' @export
show_savedlists <- function() {
    if (!requireNamespace("DT", quietly = TRUE)) {
        stop('DT package needed for show_savedlists to work.\n',
             'To install: install.packages("DT")',
             call. = FALSE)
    }

    lists <- savedlists()
    DT::datatable(lists, rownames = FALSE, fillContainer = FALSE)
}

savedlists <- function () {
    sql <- "
select
  sa.list_id as savedlist_id,
    max(sa.user_group) as user_group,
    max(ent.first_name || ' ' || ent.last_name || ' (' || ent.entity_id || ')') as list_creator,
    max(sa.name) as savedlist_name,
    count(distinct sa.subject_id) as entities
    from cdw.sa_subject_key_mv sa
    inner join cdw.d_entity_mv ent on to_number(sa.owner_id_number) = ent.entity_id
    where sa.subject_type = 'E'
    group by sa.list_id
    order by user_group, list_creator, savedlist_name
    "

    getcdw::get_cdw(sql)
}
