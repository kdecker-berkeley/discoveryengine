#' Find contact reports
#'
#' This pulls contact report IDs based on characteristics of the contact report(s).
#' To get the associated entities, see \code{\link{contacted_entity_of}}. For
#' \code{\link{contact_date}}, both \code{from} and \code{to} are optional arguments,
#' with the same behavior as every other widget that uses \code{from} and \code{to}
#' daterange. You can also search the text of contact reports using
#' \code{\link{contact_text_contains}}.
#'
#' @param ... contact unit, type, purpose, etc (depending on widget)
#' @param from date range: find contact reports between these dates
#' @param to date range: find contact reports between these dates
#'
#' @return a disco engine definition of type \code{contact_report_id}
#'
#' @examples
#' # find any contact reports from the school of business
#' business_contact = contact_unit(business)
#'
#' # find the people who were contacted in those contact reports
#' contacted_entity_of(business_contact)
#'
#' @seealso \code{\link{contact_text_contains}}, \code{\link{contacted_entity_of}}
#' @name contact_reports
#' @export
contact_unit <- function(...) {
    reroute(contact_unit_(prep_dots(...)))
}

contact_unit_ <- function(units) {
    widget_builder(
        table = "f_contact_reports_mv",
        id_field = "report_id",
        id_type = "contact_report_id",
        parameter = string_param("unit_code", units)
    )
}
