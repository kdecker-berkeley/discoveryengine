portfolio_ <- function(offices = NULL, development_officers = NULL,
                       active = "Y", env = parent.frame()) {

    params <- NULL
    officeparam <- offices
    doparam <- development_officers
    if (!is.null(offices))
        params <- c(params, list(substitute(office_code %in% officeparam)))
    if (!is.null(development_officers))
        params <- c(params, list(substitute(assignment_entity_id %in% doparam)))

    simple_q_("f_assignment_mv",
              where = params,
              id_field = "proposal_id",
              id_type = "proposal_id",
              schema = "CDW",
              env = env)
}
