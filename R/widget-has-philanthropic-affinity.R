#' Philanthropic affinity widget
#'
#' @details
#' This widget allows you to search by the Org Type, and not by specific
#' philanthropic organizations. Use \code{at_least} to find just those who have
#' given over a certain amount to such organizations. \code{at_least} uses total
#' giving to the selected org types. If no codes are entered,
#' widget will find anyone with any philanthropic affinity.
#'
#' @return A definition of type \code{entity_id}
#'
#' @param ... Philanthropic affinity type code(s)
#' @param at_least Minimum total giving to the selected philanthropic affinity type(s)
#'
#' @examples
#' has_philanthropic_affinity(health_medicine)
#'
#' ## people who have given at least $10K TOTAL to
#' ## human rights and social welfare organizations
#' has_philanthropic_affinity(human_rights, social_welfare, at_least = 10000)
#'
#' @export
has_philanthropic_affinity <- function(..., at_least = 0) {
    types <- prep_dots(...)
    reroute(has_philanthropic_affinity_(types, at_least))
}

has_philanthropic_affinity_ <- function(types, at_least = 0) {
    widget_builder(
        table = "d_oth_phil_affinity_mv",
        id_field = "entity_id",
        id_type = "entity_id",
        parameter = string_param("other_affinity_type", types),
        aggregate_switches = sum_switch("gift_amt", at_least)
    )
}
