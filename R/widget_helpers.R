d_bio_widget <- function(table, parameter = NULL, switches = NULL, env) {
    tablename = paste("d_bio_", table, "_mv", sep = "")
    widget_builder(
        table = tablename,
        id_field = "entity_id",
        id_type = "entity_id",
        parameter = parameter,
        switches = switches,
        env = env
    )
}

d_entity_widget <- function(parameter = NULL, switches = NULL, env) {
    widget_builder(
        table = "d_entity_mv",
        id_field = "entity_id",
        id_type = "entity_id",
        parameter = parameter,
        switches = switches,
        env = env
    )
}

predictive_model_widget <- function(..., type, env = parent.frame()) {
    likelihood <- pryr::dots(...)
    predictive_model_widget_(likelihood, type, env)
}

predictive_model_widget_ <- function(likelihood, type, env = parent.frame()) {
    d_bio_widget("demographic_profile",
                 parameter = string_param("dp_interest_code", likelihood,
                                          default = NULL, env = env),
                 switches = string_switch("dp_rating_type_code", type),
                 env = env)
}

proposal_widget <- function(offices = NULL, development_officers = NULL,
                            include_inactive, env = parent.frame()) {

    stopifnot(is.null(offices) || is.null(development_officers))

    if (!is.null(offices))
        parameter <- string_param("office_code", offices, default = NULL)
    else parameter <- integer_param("assignment_entity_id", development_officers,
                                    default = NULL)

    if (include_inactive)
        active_ind <- c("Y", "N")
    else active_ind <- "Y"

    widget_builder(
        table = "f_assignment_mv",
        id_field = "proposal_id",
        id_type = "proposal_id",
        parameter = parameter,
        switches = string_switch("active_ind", active_ind),
        env = env
    )
}


address_widget <- function(filter_field, filter_val,
                           type, env = parent.frame()) {
    d_bio_widget("address",
                 parameter = string_param(filter_field, filter_val,
                                          default = NULL, env = env),
                 switches = string_switch("addr_type_code", type),
                 env = env)
}
