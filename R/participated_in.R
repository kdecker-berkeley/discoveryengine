participated_in_ <- function(activities, participation = c("P", "L"), env = parent.frame()) {
  param <- activities
  param <- resolve_codes(param, "student_activity_code")
  p2 <- participation
  param1 <- substitute(student_activity_code %in% param)
  param2 <- substitute(student_particip_code %in% p2)
  bio_("student_activity", list(param1))
}

participated_in <- function(..., participation = c("P", "L"), env = parent.frame()) {
  param <- pryr::dots(...)
  param <- prep_string_param(param, env = env)
  participated_in_(param, participation = participation, env = env)
}
