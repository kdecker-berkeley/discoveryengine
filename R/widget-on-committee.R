#' @export
on_committee <- function(..., status = c("A", "D")) {
    committees <- prep_dots(...)
    on_committee_(committees, status = status)
}

on_committee_ <- function(committees, status = c("A", "D")) {
    entity_widget("d_bio_committee_mv",
                  parameter = string_param("committee_code", committees),
                  switches = string_switch("status_code", status))
}

## add role as another level
