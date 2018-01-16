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

address_widget <- function(filter_field, filter_val, type, param_fn = string_param,
                           include_alternate = TRUE,
                           include_past = FALSE,
                           include_self_employed = FALSE,
                           include_seasonal = FALSE,
                           include_student_local = FALSE,
                           include_student_permanent = FALSE) {
    default <- as.call(
        list(
            quote(`%is not%`),
            as.call(list(
                quote(trim),
                as.name(filter_field)
            )),
            quote(null)
        )
    )

    if (!include_past) status_switch <- c("A", "K")
    else status_switch <- NULL

    type <- address_type_builder(
        type = type,
        include_alternate = include_alternate,
        include_past = include_past,
        include_self_employed = include_self_employed,
        include_seasonal = include_seasonal,
        include_student_local = include_student_local,
        include_student_permanent = include_student_permanent
    )

    entity_widget(
        "d_bio_address_mv",
        parameter = param_fn(filter_field, filter_val, default = default),
        switches = list(
            string_switch("addr_type_code", type),
            string_switch("contact_type_desc", "ADDRESS"),
            string_switch("addr_status_code", status_switch)
        )
    )
}

address_type_builder <- function(
    type,
    include_alternate,
    include_past,
    include_self_employed = FALSE,
    include_seasonal = FALSE,
    include_student_local = FALSE,
    include_student_permanent = FALSE
) {
    if (length(type) != 1 || !type %in% c("home", "business")) {
        if (any(toupper(type) != type)) stop("Problem with address 'type' argument")
        return(type)
    }

    res <- c("home" = "H", "business" = "B")[[type]]
    if (include_self_employed) res <- c(res, "I")
    if (include_seasonal) res <- c(res, "S")
    if (include_student_local) res <- c(res, "E")
    if (include_student_permanent) res <- c(res, "C")

    if (include_past) {
        if ("H" %in% res) res <- c(res, "P")
        if ("B" %in% res) res <- c(res, "Q")
        if ("I" %in% res) res <- c(res, "J")
        if ("S" %in% res) res <- c(res, "SP")
        if ("C" %in% res) res <- c(res, "O")
        if ("E" %in% res) res <- c(res, "L")
    }

    if (include_alternate) {
        # alternate home/past home
        if ("H" %in% res) res <- c(res, "6")
        if ("P" %in% res) res <- c(res, "6P")

        # alternate business/past business
        if ("B" %in% res) res <- c(res, "N")
        if ("Q" %in% res) res <- c(res, "NP")
    }

    res
}
