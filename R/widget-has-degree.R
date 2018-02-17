#' @rdname academic
#' @export
has_degree <- function(..., undergraduates = TRUE,
                       graduates = TRUE, attendees= FALSE,
                       current_students = FALSE,
                       degreeholders = TRUE,
                       from = NULL, to = NULL) {
    codes <- prep_dots(...)
    reroute(has_degree_(codes, undergraduates = undergraduates,
                        graduates = graduates, attendees = attendees,
                        current_students = current_students,
                        degreeholders = degreeholders,
                        from = from, to = to))
}

has_degree_ <- function(codes, undergraduates = TRUE,
                        graduates = TRUE, attendees = FALSE,
                        current_students = FALSE,
                        degreeholders = TRUE,
                        from = NULL, to = NULL) {
    academic_widget(param = string_param("degree_code", codes),
                    undergraduates = undergraduates,
                    graduates = graduates,
                    attendees = attendees,
                    current_students = current_students,
                    degreeholders = degreeholders,
                    from = from, to = to)
}
