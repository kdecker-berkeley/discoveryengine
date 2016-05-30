#' @export
participated_in <- function(..., participation = c("P", "L"), env = parent.frame()) {
    activities <- pryr::dots(...)
    participated_in_(activities, participation, env)
}


participated_in_ <- function(activities, participation = c("P", "L"),
                             env = parent.frame()) {
    d_bio_widget("student_activity",
                 parameter = string_param("student_activity_code", activities, env),
                 switches = string_switch("student_particip_code", participation),
                 env = env)
}
