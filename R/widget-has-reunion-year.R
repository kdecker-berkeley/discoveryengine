#' Reunion year widget
#'
#' This widget looks specifically at the \code{class_campaign_year} field, which
#' is used by the Reunion Campaigns to place alumni in reunion years. Note that
#' only undergraduate degree holders have a \code{class_campaign_year}. If no
#' years are entered, widget will find anyone who has a \code{class_campaign_year}.
#'
#' @return A definition of type \code{entity_id}
#'
#' @param ... reunion year(s) (eg: 1980, 1990:2000)
#'
#' @examples
#' ## prospecting for a class campaigns officer who has classes of '80, '85, and '90
#' has_reunion_year(1980, 1985, 1990)
#'
#' ## use the colon for a continuous range
#' has_reunion_year(1998:2008)
#'
#' @export
has_reunion_year <- function(...) {
    entity_widget(
        table = "d_entity_mv",
        parameter = integer_param("class_campaign_year", ...,
                                  default = quote(class_campaign_year %is not% null))
    )
}
