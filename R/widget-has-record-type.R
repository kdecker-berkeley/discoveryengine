#' Find entities with a given record type(s)
#'
#' This widget looks at all record types (not just the primary record type).
#' If no record types are entered, the widget will find every entity ID,
#' regardless of type. However, please pay attention to the default settings
#' on \code{\link{display}}, which excludes organizations and the deceased
#' unless you specify otherwise.
#'
#' @param ... record type code(s)
#'
#' @return A definition of type \code{entity_id}
#'
#' @examples
#' ## find trustees
#' has_record_type(ucbf_trustee)
#'
#' ## or if you want to include former trustees
#' has_record_type(ucbf_trustee, former_ucbf_trustee)
#'
#' @export
has_record_type <- function(...)
    reroute(has_record_type_(prep_dots(...)))

has_record_type_ <- function(types) {
    widget_builder(
        table = "d_bio_entity_record_type_mv",
        id_field = "entity_id",
        id_type = "entity_id",
        parameter = string_param("record_type_code", types)
    )
}
