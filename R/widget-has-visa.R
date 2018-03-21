#' @rdname citizenship
#' @export
has_visa <- function(...) {
    reroute(has_visa_(prep_dots(...)))
}

has_visa_ <- function(visa) {
    widget_builder(
        table = "d_entity_mv",
        id_field = "entity_id", id_type = "entity_id",
        parameter = string_param("religion_code", visa,
                                 default = quote(trim(religion_code) %is not% null))
    )
}
