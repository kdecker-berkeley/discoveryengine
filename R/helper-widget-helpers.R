entity_widget <- function(table, id_field = "entity_id",
                          parameter = NULL, switches = NULL) {
    widget_builder(table = table,
                   id_field = id_field,
                   id_type = "entity_id",
                   parameter = parameter,
                   switches = switches)
}

predictive_model_widget <- function(likelihood, type) {
    entity_widget("d_bio_demographic_profile_mv",
                  parameter = string_param("dp_interest_code", likelihood),
                  switches = string_switch("dp_rating_type_code", type))
}

proposal_widget <- function(offices = NULL, development_officers = NULL,
                            include_inactive) {

    stopifnot(is.null(offices) || is.null(development_officers))

    if (!is.null(offices))
        parameter <- string_param("office_code", offices)
    else parameter <- integer_param("assignment_entity_id", development_officers)

    if (include_inactive)
        active_ind <- c("Y", "N")
    else active_ind <- "Y"

    widget_builder(
        table = "f_assignment_mv",
        id_field = "proposal_id",
        id_type = "proposal_id",
        parameter = parameter,
        switches = string_switch("active_ind", active_ind)
    )
}

address_widget <- function(filter_field, filter_val, type, param_fn = string_param) {
    default <- as.call(
        list(
            quote(`%is not%`),
            filter_field,
            quote(null)
        )
    )

    entity_widget(
        "d_bio_address_mv",
        parameter = param_fn(filter_field, filter_val, default = default),
        switches = string_switch("addr_type_code", type))
}
