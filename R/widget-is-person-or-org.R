#' @export
is_person_or_org <- function(...) {
    type <- prep_dots(...)
    reroute(is_person_or_org_(type))
}

is_person_or_org_ <- function(type) {
    entity_widget("d_entity_mv",
                  parameter = string_param("person_or_org", type))
}

