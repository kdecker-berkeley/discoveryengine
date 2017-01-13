#' Find people with a given occupation_code
#'
#' This widget is based on the "Occupational Spec" fields on an entity's
#' Employment screen.
#'
#' @param ... Occupation code(s)
#' @param include_former Should non-current employment data be included in the
#' search? If FALSE (the default) only current employment will be searched
#'
#' @return A definition of type \code{entity_id}
#'
#' @export
has_occupation <- function(..., include_former = FALSE) {
    reroute(has_occupation_(prep_dots(...), include_former))
}

has_occupation_ <- function(occupations, include_former = FALSE) {

    if (include_former) my_switch <- NULL
    else my_switch <- string_switch("job_status_code", "C")

    f <- function(fld)
        widget_builder(
            table = "d_bio_employment_mv",
            id_field = "entity_id",
            id_type = "entity_id",
            parameter = string_param(
                field_name = fld,
                arguments = occupations,
                default = quote(fld_of_spec_code1 %is not% null),
                width = 4
            ),
            switches = my_switch
        )

    f("fld_of_spec_code1") %or%
        f("fld_of_spec_code2") %or%
        f("fld_of_spec_code3")
}
