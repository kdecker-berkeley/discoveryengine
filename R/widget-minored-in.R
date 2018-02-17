#' @rdname academic
#' @export
minored_in <- function(..., undergraduates = TRUE,
                       graduates = TRUE, attendees= FALSE,
                       current_students = FALSE,
                       degreeholders = TRUE,
                       from = NULL, to = NULL)
    reroute(minored_in_(
        prep_dots(...), undergraduates = undergraduates,
        graduates = graduates, attendees = attendees,
        current_students = current_students,
        degreeholders = degreeholders,
        from = from, to = to))

minored_in_ <- function(minors, undergraduates = TRUE,
                        graduates = TRUE, attendees= FALSE,
                        current_students = FALSE,
                        degreeholders = TRUE,
                        from = NULL, to = NULL) {

    academic_widget(param = string_param("minor_code1", minors, width = 3,
                                         default = quote(trim(minor_code1) %is not% null)),
                    undergraduates = undergraduates,
                    graduates = graduates,
                    attendees = attendees,
                    current_students = current_students,
                    degreeholders = degreeholders,
                    from = from, to = to)
}
