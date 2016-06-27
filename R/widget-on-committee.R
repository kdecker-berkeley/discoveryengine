#' @export
on_committee <- function(..., include_former = TRUE) {
    committees <- prep_dots(...)
    reroute(on_committee_(committees, include_former = include_former))
}

on_committee_ <- function(committees, include_former = TRUE) {
    if (!is.logical(include_former))
        stop("include_former must be TRUE or FALSE")
    if (include_former) status_code <- c("C", "F")
    else status_code <- "C"

    entity_widget("d_bio_committee_mv",
                  parameter = string_param("committee_code", committees),
                  switches = string_switch("committee_status_code", status_code))
}

## add role as another level
