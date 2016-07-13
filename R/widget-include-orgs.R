#' @export
include_orgs <- function(..., person = TRUE,
                         org = TRUE)
    reroute(include_orgs_(
        prep_dots(...), person = person,
        org = org))

include_orgs_ <- function(person = TRUE,
                          org = TRUE) {

    type = NULL
    if (person) {
        type <- c(type, "P")
    }

    if (org) {
        type <- c(type, "O")
    }

    widget_builder(
        table = "d_entity_mv",
        id_field = "entity_id",
        id_type = "entity_id",
        switches = list(string_switch("person_or_org", type))
    )
}
