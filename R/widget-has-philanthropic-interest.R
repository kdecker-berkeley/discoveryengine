#' Philanthropic interest widget
#'
#' Find entities with a given philanthropic interests.
#'
#' @return A definition of type \code{entity_id}
#'
#' @param ... UCB Interest Codes or synonyms
#' @param unit Look only for philanthropic interests associated with a given unit.
#' Leave blank (the default) to search only on phil. interest codes
#' @param active If TRUE (default), will include only philanthropic interests
#' without a stop date. If FALSE, will include only philanthropic interests
#' WITH a stop date -- the stop date is used here as a disqualifier, to signify negative
#' interest/inclination.
#'
#' @export
has_philanthropic_interest <- function(..., unit = NULL, active = TRUE) {
    interests <- prep_dots(...)
    reroute(has_philanthropic_interest_(interests, unit = unit, active = active))
}

has_philanthropic_interest_ <- function(interests, unit = NULL, active = TRUE) {
    if (active) active_switch <- quote(stop_date %is% null)
    else active_switch <- quote(stop_date %is not% null)

    entity_widget("d_philanthropic_interest_mv",
                  parameter = string_param("affinity_type", interests),
                  switches = list(active_switch,
                                  string_switch("affinity_purpose_code", unit))
    )
}
