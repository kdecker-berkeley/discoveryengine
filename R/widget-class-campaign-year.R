#' Reunion year widget
#' @param ... reunion year(s) (eg: 1980, 1990:2000)
#' @export
class_campaign_year <- function(...) {
    entity_widget(
        table = "d_entity_mv",
        parameter = integer_param("class_campaign_year", ...,
                                  default = quote(class_campaign_year %is not% null))
    )
}
