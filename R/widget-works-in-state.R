#' @rdname address
#' @export
works_in_state <- function(...,
                           include_alternate = TRUE,
                           include_past = FALSE,
                           include_self_employed = TRUE,
                           type = "business") {
    state <- prep_dots(...)
    reroute(works_in_state_(state,
                            include_alternate = include_alternate,
                            include_past = include_past,
                            include_self_employed = include_self_employed,
                            type = type))
}

works_in_state_ <- function(state,
                            include_alternate = TRUE,
                            include_past = FALSE,
                            include_self_employed = TRUE,
                            type = "business") {
    address_widget("state_code", state,
                   type = type,
                   include_alternate = include_alternate,
                   include_past = include_past,
                   include_self_employed = include_self_employed)
}
