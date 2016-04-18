in_unit_portfolio_ <- function(offices, active = "Y", env = parent.frame()) {
    pf <- portfolio_(offices, development_officers = NULL,
                     active = active, env = env)
    flist_(pf, "f_proposal_mv", from = "proposal_id",
           to = "entity_id", id_type = "entity_id",
           .dots = NULL, schema = "CDW", env = env)
}

#' @export
in_unit_portfolio <- function(..., active = "Y", env = parent.frame()) {
    param <- pryr::dots(...)
    param <- prep_string_param(param, env = env)
    param <- resolve_codes(param, "office_code")
    in_unit_portfolio_(param, active = active, env = env)
}
