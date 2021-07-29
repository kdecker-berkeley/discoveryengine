#' Select entities that have been coded as "High Net Worth" Parents

#'
#' @details
#' No arguments necessary; this function calls all entities with an active code
#' of "High Net Worth Parent"
#' @rdname high_net_worth_parent

#' @export
is_high_net_worth_parent <- function(...) {
    reroute(is_high_net_worth_parent_(prep_dots(...)))
}

is_high_net_worth_parent_ <- function() {
    widget_builder(
        table = "d_bio_demographic_profile_mv",
        id_field = "entity_id",
        id_type = "entity_id",
        parameter = string_param("dp_rating_type_code", "HWP")
    )
    }
