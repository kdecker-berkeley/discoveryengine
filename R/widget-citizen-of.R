#' Citizenship/Visa widgets
#'
#' These widgets are based on what is found in the "Biographical Detail
#' (Birth & Death)" screen in CADSbase. More recent student/alumni often have
#' a Visa code recorded (including cases where the status is "US Citizen"), but
#' most other records have no information in this field. Be aware that the data
#' selectively missing.
#'
#' @return A definition of type \code{entity_id}
#'
#' @param ... country code(s) (for \code{citizen_of}) or visa codes (for \code{has_visa})
#'
#' @examples
#' ## find citizens of Japan
#' citizen_of(JAPAN)
#'
#' ## find people with a student visa
#' has_visa(F1)
#'
#' @name citizenship
#' @export
citizen_of <- function(...) {
    reroute(citizen_of_(prep_dots(...)))
}

citizen_of_ <- function(countries) {
    a <- widget_builder(
        table = "d_entity_mv",
        id_field = "entity_id", id_type = "entity_id",
        parameter = string_param("citizen_cntry_code1", countries,
                                 default = quote(trim(citizen_cntry_code1) %is not% null))
    )

    b <- widget_builder(
        table = "d_entity_mv",
        id_field = "entity_id", id_type = "entity_id",
        parameter = string_param("citizen_cntry_code2", countries,
                                 default = quote(trim(citizen_cntry_code2) %is not% null))
    )

    a %or% b
}
