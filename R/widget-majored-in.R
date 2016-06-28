#' Academic major widget
#'
#' Find entities who graduated with a particular major(s).
#' @export
majored_in <- function(...) reroute(majored_in_(prep_dots(...)))

majored_in_ <- function(majors) {
    widget_builder(
        table = "d_bio_degrees_mv",
        id_field = "entity_id",
        id_type = "entity_id",
        param = string_param("major_code1", majors, width = 3),
        switches = string_switch("local_ind", "Y")
    )
}
