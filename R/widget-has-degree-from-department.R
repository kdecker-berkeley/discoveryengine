#' @rdname academic
#' @export
has_degree_from_department <- function(..., undergraduates = TRUE,
                       graduates = TRUE, attendees= FALSE,
                       current_students = FALSE,
                       degreeholders = TRUE,
                       from = NULL, to = NULL,
                       advisor = NULL)
    reroute(has_degree_from_department_(
        prep_dots(...), undergraduates = undergraduates,
        graduates = graduates, attendees = attendees,
        current_students = current_students,
        degreeholders = degreeholders,
        from = from, to = to,
        advisor = advisor))

has_degree_from_department_ <- function(departments, undergraduates = TRUE,
                        graduates = TRUE, attendees= FALSE,
                        current_students = FALSE,
                        degreeholders = TRUE,
                        from = NULL, to = NULL,
                        advisor = NULL) {

    academic_widget(param = string_param("dept_code", departments),
                    undergraduates = undergraduates,
                    graduates = graduates,
                    attendees = attendees,
                    current_students = current_students,
                    degreeholders = degreeholders,
                    from = from, to = to,
                    advisor = advisor)
}

