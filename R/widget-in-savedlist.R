#' Find entities in a given savedlist
#'
#' To find the ID of a savedlist, use \code{\link{show_savedlists}}.
#'
#' @param ... Savedlist ID(s) -- see \code{\link{show_savedlists}}
#'
#' @return A definition of type \code{entity_id}
#'
#' @seealso \code{\link{show_savedlists}}
#' @export
in_savedlist <- function(...) {
    reroute(in_savedlist_(prep_dots(...)))
}

in_savedlist_ <- function(sl) {
    custom_sql <-"
    select list_id, to_number(trim(subject_id)) as entity_id
    from cdw.sa_subject_key_mv
    where subject_type = 'E' and regexp_like(trim(subject_id), '^[0-9]+$')
    "

    widget_builder_custom(
        custom = custom_sql,
        id_field = "entity_id",
        id_type = "entity_id",
        parameter = integer_param("list_id", sl)
    )
}
