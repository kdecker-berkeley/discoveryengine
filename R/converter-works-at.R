#' @export
works_at <- function(..., include_former = TRUE) {
    reroute(works_at_(entity_id_param(...), include_former = include_former))
}

works_at_ <- function(corp, include_former = FALSE) {
    if (include_former) fmr_switch <- NULL
    else fmr_switch <- string_switch("job_status_code", "C")
    converter_builder(
        corp,
        table = "d_bio_employment_mv",
        from = "employer_entity_id",
        from_type = "entity_id",
        to = "entity_id",
        to_type = "entity_id",
        switches = fmr_switch
    )
}
