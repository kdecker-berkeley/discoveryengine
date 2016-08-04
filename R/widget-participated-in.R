#' @export
participated_in <- function(..., participation = c("P", "L")) {
    activities <- prep_dots(...)
    reroute(participated_in_(activities, participation))
}

participated_in_ <- function(activities, participation = c("P", "L")) {
    entity_widget("d_bio_student_activity_mv",
                  parameter = string_param("student_activity_code", activities),
                  switches = string_switch("student_particip_code", participation))
}
