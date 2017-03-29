#' @rdname academic
#' @export
majored_in <- function(..., undergraduates = TRUE,
                       graduates = TRUE, attendees= FALSE,
                       from = NULL, to = NULL)
    reroute(majored_in_(
        prep_dots(...), undergraduates = undergraduates,
        graduates = graduates, attendees = attendees,
        from = from, to = to))

majored_in_ <- function(majors, undergraduates = TRUE,
                        graduates = TRUE, attendees= FALSE,
                        from = NULL, to = NULL) {

    levels = NULL
    if (undergraduates) {
        levels <- c(levels, "U")
        if (attendees) levels <- c(levels, "A")
    }

    if (graduates) {
        levels <- c(levels, "G")
        if (attendees) levels <- c(levels, "L")
    }

    widget_builder(
        table = "d_bio_degrees_mv",
        id_field = "entity_id",
        id_type = "entity_id",
        param = string_param("major_code1", majors, width = 3),
        switches = list(string_switch("degree_level_code", levels),
                        daterange("grad_dt", from, to),
                        string_switch("local_ind", "Y"))
    )
}
