#' @rdname academic
#' @export
majored_in <- function(..., undergraduates = TRUE,
                       graduates = TRUE, attendees= FALSE,
                       current_students = FALSE,
                       degreeholders = TRUE,
                       from = NULL, to = NULL,
                       advisor = NULL)
    reroute(majored_in_(
        prep_dots(...), undergraduates = undergraduates,
        graduates = graduates, attendees = attendees,
        current_students = current_students,
        degreeholders = degreeholders,
        from = from, to = to,
        advisor = advisor))

majored_in_ <- function(majors, undergraduates = TRUE,
                        graduates = TRUE, attendees= FALSE,
                        current_students = FALSE,
                        degreeholders = TRUE,
                        from = NULL, to = NULL,
                        advisor = NULL) {

    academic_widget(param = string_param("major_code1", majors, width = 3),
                    undergraduates = undergraduates,
                    graduates = graduates,
                    attendees = attendees,
                    current_students = current_students,
                    degreeholders = degreeholders,
                    from = from, to = to,
                    advisor = advisor)
}
