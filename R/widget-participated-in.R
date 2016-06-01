#' @export
participated_in <- function(..., participation = c("P", "L")) {
    activities <- prep_dots(...)
    participated_in_(activities, participation)
}


participated_in_ <- function(activities, participation = c("P", "L")) {
    d_bio_widget("student_activity",
                 parameter = string_param("student_activity_code", activities),
                 switches = string_switch("student_particip_code", participation))
}
