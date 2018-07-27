#' @rdname academic
#' @export
has_degree <- function(...,
                       attendees= FALSE,
                       current_students = FALSE,
                       degreeholders = TRUE,
                       from = NULL, to = NULL,
                       advisor = NULL) {
    codes <- prep_dots(...)
    reroute(has_degree_(codes,
                        attendees = attendees,
                        current_students = current_students,
                        degreeholders = degreeholders,
                        from = from, to = to,
                        advisor = advisor))
}

has_degree_ <- function(codes,
                        attendees = FALSE,
                        current_students = FALSE,
                        degreeholders = TRUE,
                        from = NULL, to = NULL,
                        advisor = NULL) {

    academic_widget(param = string_param("degree_code", codes),
                    undergraduates = TRUE,
                    graduates = TRUE,
                    attendees = attendees,
                    current_students = current_students,
                    degreeholders = degreeholders,
                    from = from, to = to,
                    advisor = advisor)
}
