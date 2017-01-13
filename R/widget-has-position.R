#' Find people who have a specific position level code
#'
#' This widget is based on the "position level" code in CADS, which is entered
#' by Prospect Research and identifies Director-level and above employment
#' positions
#'
#' @param ... position level code(s). If left empty, will look for any
#' non-blank position level code
#' @param include_former Should non-current employment data be included in the
#' search? If FALSE (the default) only current employment will be searched
#'
#' @return A definition of type \code{entity_id}
#'
#' @export
has_position <- function(..., include_former = FALSE) {
    reroute(has_position_(prep_dots(...), include_former))
}

has_position_ <- function(positions, include_former = FALSE) {

    if (include_former) position_switch <- NULL
    else position_switch <- string_switch("job_status_code", "C")

    widget_builder(
        table = "d_bio_employment_mv",
        id_field = "entity_id",
        id_type = "entity_id",
        parameter = string_param(
            field_name = "position_level_code",
            arguments = positions,
            default = quote(position_level_desc %is not% null)
        ),
        switches = position_switch
    )
}
