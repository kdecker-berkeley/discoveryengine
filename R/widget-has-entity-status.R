#' @export
has_entity_status <- function(...) {
    status <- prep_dots(...)
    reroute(has_entity_status_(status))
}

has_entity_status_ <- function(status) {
    entity_widget("d_entity_mv",
                  parameter = string_param("record_status_code", status))
}

