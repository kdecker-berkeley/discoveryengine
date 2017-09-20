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
#' @param comment (Optional) Supply one or more search terms to search through
#' the comment fields of the philanthropic interests area
#'
#' @examples
#' ## find people with an interest in funding scholarships
#' has_philanthropic_interest(scholarships)
#'
#' ## can also be used to exclude disqualified prospects
#' donor = gave_to_area(at_least = 100000)
#' disqualified = has_philanthropic_interest(UC, active = FALSE)
#' donor %but_not% disqualified
#'
#' @export
has_philanthropic_interest <- function(..., unit = NULL, active = TRUE, comment = NULL) {
    interests <- prep_dots(...)
    reroute(has_philanthropic_interest_(interests, unit = unit, active = active,
                                        comment = comment))
}

has_philanthropic_interest_ <- function(interests, unit = NULL, active = TRUE, comment = NULL) {
    if (active) active_switch <- quote(stop_date %is% null)
    else active_switch <- quote(stop_date %is not% null)

    comment_switch <- regex_switch("xcomment", comment)

    entity_widget("d_philanthropic_interest_mv",
                  parameter = string_param("affinity_type", interests),
                  switches = list(active_switch,
                                  string_switch("affinity_purpose_code", unit),
                                  comment_switch)
    )
}
