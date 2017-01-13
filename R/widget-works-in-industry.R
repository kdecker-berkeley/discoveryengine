#' Find people who work in a particular industry
#'
#' This widget is based on the 6-digit NAICS code found on the employer's
#' "Industry Codes" screen.
#'
#' @param ... NAICS code(s)
#' @param include_former Should non-current employment data be included in the
#' search? If FALSE (the default) only current employment will be searched
#'
#' @return A definition of type \code{entity_id}
#'
#' @examples
#' ## find people who work in investment banking
#' works_in_industry(523110)
#'
#' @export
works_in_industry <- function(..., include_former = FALSE) {
    reroute(works_in_industry_(prep_dots(...), include_former))
}

works_in_industry_ <- function(industries, include_former = FALSE) {

    if (include_former) industry_switch <- NULL
    else industry_switch <- string_switch("job_status_code", "C")

    widget_builder(
        table = "d_bio_employment_mv",
        id_field = "entity_id",
        id_type = "entity_id",
        parameter = string_param(
            field_name = "sic_code",
            arguments = industries,
            default = quote(sic_code %is not% null),
            width = 6
        ),
        switches = industry_switch
    )
}
