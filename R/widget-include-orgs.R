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
        switches = list(string_switch("person_or_org", type))
    )
}

include_orgs(perosn = TRUE, orgs = FALSE)

devtools::install_github("tarakc02/getcdw")
devtools::install_github("tarakc02/listbuilder")
devtools::install_github("tarakc02/discoveryengine")
