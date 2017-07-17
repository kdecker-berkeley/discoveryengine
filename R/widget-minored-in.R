#' @rdname academic
#' @export
minored_in <- function(..., undergraduates = TRUE,
                       graduates = TRUE, attendees= FALSE,
                       from = NULL, to = NULL)
    reroute(minored_in_(
        prep_dots(...), undergraduates = undergraduates,
        graduates = graduates, attendees = attendees,
        from = from, to = to))

minored_in_ <- function(minors, undergraduates = TRUE,
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

    date_switch <- daterange(
        dbplyr::sql("case when degree_level_code in ('U', 'G') then grad_dt else stop_dt end"),
        from = from, to = to
    )

    if (!graduates && !undergraduates && attendees) {
        warning("minored_in: you selected attendees but not undergraduates or graduates. Both undergrad and grad attendees (but not degreeholders) will be selected", call. = FALSE)
        levels <- c("L", "A")
    }
    #select minor_code1 from cdw.d_bio_degrees_mv where trim(minor_code1) is not null
    widget_builder(
        table = "d_bio_degrees_mv",
        id_field = "entity_id",
        id_type = "entity_id",
        param = string_param("minor_code1", minors, width = 3,
                             default = quote(trim(minor_code1) %is not% null)),
        switches = list(string_switch("degree_level_code", levels),
                        date_switch,
                        string_switch("local_ind", "Y"))
    )
}
