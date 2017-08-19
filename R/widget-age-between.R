#' Age widget
#'
#' Find entities based on age
#'
#' If an entity has a birth date, then that will be used to calculate their age.
#' If there is no birth date, then the degree year of their first degree is used.
#' In order to calculate age from degree year, the widget adds 22 to the number of
#' years since an undergraduate degree, and 25 to the number of years since a
#' graduate degree. Entities without a birthday or degree year are completely
#' ignored.
#'
#' `from` and `to` are optional, but you must provide at least one of them.
#'
#' @param from Minimum age, as a number
#' @param to Maximum age, as a number
#'
#' @examples
#' ## entities between the age of 35 and 40
#' age_between(from = 35, to = 40)
#'
#' ## entities who are exactly 37 years old
#' age_between(from = 37, to = 37)
#'
#' ## anyone over the age of 55
#' age_between(from = 55)
#'
#' ## anyone under the age of 65
#' age_between(to = 65)
#'
#' @export
age_between <- function(from = NULL, to = NULL) {

    if (!is.null(from)) assertthat::assert_that(assertthat::is.scalar(from))
    if (!is.null(to)) assertthat::assert_that(assertthat::is.scalar(to))
    if (!is.null(from) && !is.null(to)) assertthat::assert_that(to >= from)

    # <=, >=, or between, based on if from and/or to are NULL
    op <- date_operator(from, to)
    if (is.null(op)) stop("to use age_between, you must supply at least one of from, to")
    fld <- dbplyr::sql(
        "case
when birth_dt is not null then round(months_between(sysdate, birth_dt) / 12)
when degree1_degree_level_code in ('U', 'A') and trim(degree1_degree_year) is not null then extract(year from sysdate) - to_number(trim(degree1_degree_year)) + 22
when degree1_degree_level_code in ('L', 'G') and trim(degree1_degree_year) is not null then extract(year from sysdate) - to_number(trim(degree1_degree_year)) + 25
else null end")

    .call <- list(
        op,
        fld
    )

    if (!is.null(from)) .call <- c(.call, from)
    if (!is.null(to)) .call <- c(.call, to)

    widget_builder(
        table = "d_entity_mv",
        id_field = "entity_id",
        id_type = "entity_id",
        parameter = NULL,
        switches = list(as.call(.call))
    )
}
