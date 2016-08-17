#' Specify entity type and status
#'
#' The \code{\link{display}} function has built-in options to include/exclude
#' organizations and deceased or out of business corporations, so you will
#' usually not need to use this function.
#'
#' @param ... entity type (person, organization)
#' @param include_deceased Should deceased individuals and out of business
#' corporations be included? (See details)
#'
#' @details
#' By default, deceased individuals and out of business corporations are
#' excluded.
#' @export
is_a <- function(..., include_deceased = FALSE)
    reroute(is_a_(prep_dots(...), include_deceased = include_deceased))

is_a_ <- function(entity_type, include_deceased) {

    if (include_deceased)
        status <- c("A", "D", "R", "B", "O")
    else
        status <- "A"

    widget_builder(
        table = "d_entity_mv",
        id_field = "entity_id",
        id_type = "entity_id",
        parameter = string_param("person_or_org", entity_type),
        switches = string_switch("record_status_code", status)
    )
}

person_or_org_synonyms <- function() {
    c(
        "person" = "P",
        "human" = "P",
        "organization" = "O",
        "org" = "O"
    )
}
