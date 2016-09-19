#' @rdname portfolio
#' @export
in_development_officer_portfolio <- function(..., include_inactive = FALSE) {
    officers <- prep_integer_param(...)
    reroute(in_development_officer_portfolio_(officers, include_inactive))
}

in_development_officer_portfolio_ <- function(officers, include_inactive = FALSE) {

    proposals <- proposal_widget(development_officers = officers,
                                 include_inactive = include_inactive)

    # inactive flag can be on proposal or assignment
    if (include_inactive)
        active_ind <- c("Y", "N")
    else active_ind <- "Y"

    converter_builder(proposals,
                      table = "f_proposal_mv",
                      from = "proposal_id",
                      to = "entity_id",
                      switches = string_switch("active_ind", active_ind))
}
