d_bio_widget <- function(table, parameter = NULL, switches = NULL) {
    tablename = paste("d_bio_", table, "_mv", sep = "")
    widget_builder(
        table = tablename,
        id_field = "entity_id",
        id_type = "entity_id",
        parameter = parameter,
        switches = switches
    )
}

d_entity_widget <- function(parameter = NULL, switches = NULL) {
    widget_builder(
        table = "d_entity_mv",
        id_field = "entity_id",
        id_type = "entity_id",
        parameter = parameter,
        switches = switches
    )
}

predictive_model_widget <- function(..., type) {
    likelihood <- prep_dots(...)
    predictive_model_widget_(likelihood, type)
}

predictive_model_widget_ <- function(likelihood, type) {
    d_bio_widget("demographic_profile",
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


address_widget <- function(filter_field, filter_val, type) {
    d_bio_widget("address",
                 parameter = string_param(filter_field, filter_val),
                 switches = string_switch("addr_type_code", type))
}
