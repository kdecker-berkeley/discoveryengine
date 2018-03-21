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
