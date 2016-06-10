#' Degree widget
#'
#' @param ... degree-granting schools
#' @param levels degree level codes (undergrad/grad, attendee/degreeholder)
#' @export
has_degree_from <- function(..., levels = c("A", "U", "G", "L")) {
    schools <- prep_dots(...)
    has_degree_from_(schools, levels)
}

#' @rdname has_degree_from
#' @export
has_degree_from_ <- function(schools, levels = c("A", "U", "G", "L")) {
    entity_widget("d_bio_degrees_mv",
                 parameter = string_param("school_code", schools),
                 switches = list(
                     string_switch("degree_level_code", levels),
                     quote(local_ind == "Y")
                 ))
}
