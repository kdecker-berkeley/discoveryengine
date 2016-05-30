#' Degree widget
#'
#' @param ... degree-granting schools
#' @param levels degree level codes (undergrad/grad, attendee/degreeholder)
#' @importFrom pryr dots
#' @export
has_degree_from <- function(..., levels = c("A", "U", "G", "L"),
                            env = parent.frame()) {
    schools <- pryr::dots(...)
    has_degree_from_(schools, levels, env)
}

#' @rdname has_degree_from
#' @export
has_degree_from_ <- function(schools, levels = c("A", "U", "G", "L"),
                             env = parent.frame()) {
    d_bio_widget("degrees",
                 parameter = string_param("school_code", schools,
                                          default = NULL),
                 switches = list(
                     string_switch("degree_level_code", levels),
                     quote(local_ind == "Y")
                 ),
                 env = env)
}
