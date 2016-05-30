#' Entities in a unit portfolio
#'
#' @param ... Office code(s)
#' @param include_inactive Include inactive proposals/assignments?
#'
#' @export
in_unit_portfolio <- function(..., include_inactive = FALSE, env = parent.frame()) {
    offices <- pryr::dots(...)
    in_unit_portfolio_(offices, include_inactive, env)
}


#' @rdname in_unit_portfolio
#' @export
in_unit_portfolio_ <- function(offices, include_inactive = FALSE,
                               env = parent.frame()) {

    proposals <- proposal_widget(offices = offices,
                                 include_inactive = include_inactive,
                                 env = env)

    flist_(proposals, "f_proposal_mv", from = "proposal_id",
           to = "entity_id", id_type = "entity_id",
           .dots = NULL, schema = "CDW", env = env)
}
