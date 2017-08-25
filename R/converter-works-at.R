#' Find entities who work for a given employer(s)
#'
#' Note that you can specify one or more employers, as plain entity IDs or as
#' disco engine definitions. See examples.
#'
#' @param ... one or more entity IDs, or discovery engine definition(s) of type \code{entity_id}
#' @param include_former Should former employment be considered (default is FALSE)
#'
#' @examples
#' # anyone who works at google corporate
#' works_at(2090340)
#'
#' # anyone who works at google or any of its subsidiaries
#' works_at(2090340, corp_subsidiary(2090340))
#'
#' # works at google or facebook, including any of their subsidiaries
#' works_at(2090340, 2145589, corp_subsidiary(2090340, 2145589))
#'
#' @export
works_at <- function(..., include_former = FALSE) {
    reroute(works_at_(entity_id_param(...), include_former = include_former))
}

works_at_ <- function(corp, include_former = FALSE) {
    if (is.null(corp)) corp <- is_a(organization, include_deceased = include_former)
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
