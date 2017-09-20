#' Search by capacity rating researcher(s) and/or date(s)
#'
#' This widget allows you to search for entities who have been rated, by the
#' researcher who rated them and/or the date range during which the entity
#' was rated. If no researcher IDs are entered, then the widget will look for
#' anyone who was rated (or, if \code{from} and \code{to} dates are entered, just
#' those rated during the specified daterange).
#'
#' @return A definition of type \code{entity_id}
#'
#' @param ... (optional) One or more entity IDs of researcher(s). If no
#' researchers are entered, then the widget will look for anyone who was rated
#' (during the given dates).
#' @param from (optional) date, Enter as an integer of the form YYYYMMDD
#' @param to (optional) date, Enter as an integer of the form YYYYMMDD
#' @param include_inactive TRUE or FALSE: Should widget look through just active ratings (FALSE),
#' or all ratings (TRUE)?
#' @param comment (Optional) Supply one or more search terms to search through
#' the comment field
#'
#' @examples
#' ## find anyone ever rated by Lucila
#' rated_by(3221525)
#'
#' ## find anyone rated by Lucila since 1/1/2017
#' rated_by(3221525, from = 20170101)
#'
#' ## find anyone rated by Lucila during calendar year 2016
#' rated_by(3221525, from = 20160101, to = 20161231)
#'
#' ## find anyone rated by Lucila or Mallory on or before June 30, 2016
#' ## including ratings that are no longer active
#' rated_by(3221525, 923406, to = 20160630, include_inactive = TRUE)
#'
#' @export
rated_by <- function(..., from = NULL, to = NULL, include_inactive = FALSE, comment = NULL) {
    researchers <- prep_integer_param(...)
    reroute(rated_by_(researchers,
                      from = from, to = to,
                      include_inactive = include_inactive,
                      comment = comment))
}

rated_by_ <- function(researchers, from = NULL, to = NULL,
                      include_inactive = FALSE, comment = NULL) {
    if (include_inactive)
        active_flag <- c("Y", "N")
    else active_flag <- "Y"

    widget_builder(
        table = "d_prospect_evaluation_mv",
        id_field = "entity_id",
        id_type = "entity_id",
        parameter = integer_param("evaluator_entity_id", researchers),
        switches = list(
            daterange("evaluation_date", from, to),
            string_switch("evaluation_type", c("CI", "CC", "CM")),
            string_switch("active_ind", active_flag),
            regex_switch("xcomment", comment)
        )
    )
}
