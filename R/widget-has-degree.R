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

    param <- string_param("degree_code", codes)
    attendees <- check_vis_postdocs(param[[1]][[3]], attendees)

    academic_widget(param = param,
                    undergraduates = TRUE,
                    graduates = TRUE,
                    attendees = attendees,
                    current_students = current_students,
                    degreeholders = degreeholders,
                    from = from, to = to,
                    advisor = advisor)
}

check_vis_postdocs <- function(codes, attendees) {
    if (any(c("VSCH", "PDOC") %in% codes)) {
        if (!attendees)
            warning("Visiting Scholars and Postdocs are considered attendees for the purposes of this widget.\n",
                    "Therefore, 'attendees' is being set to TRUE", call. = FALSE)
        return(TRUE)
    }
    attendees
}
