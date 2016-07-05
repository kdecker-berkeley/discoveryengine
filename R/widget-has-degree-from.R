#' Degree widget
#'
#' @param ... degree-granting schools
#' @param levels degree level codes (undergrad/grad, attendee/degreeholder)
#' @export
has_degree_from <- function(..., undergraduates = TRUE,
                            graduates = TRUE, attendees= FALSE) {
    schools <- prep_dots(...)
    reroute(has_degree_from_(schools, undergraduates = undergraduates,
                             graduates = graduates, attendees = attendees))
}

has_degree_from_ <- function(schools, undergraduates = TRUE,
                             graduates = TRUE, attendees = FALSE) {
    levels = NULL
    if (undergraduates) {
        levels <- c(levels, "U")
        if (attendees) levels <- c(levels, "A")
    }

    if (graduates) {
        levels <- c(levels, "G")
        if (attendees) levels <- c(levels, "L")
    }

    entity_widget("d_bio_degrees_mv",
                 parameter = string_param("school_code", schools),
                 switches = list(
                     string_switch("degree_level_code", levels),
                     quote(local_ind == "Y")
                 ))
}
