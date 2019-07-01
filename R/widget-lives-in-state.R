#' @rdname address
#' @export
lives_in_state <- function(...,
                           include_alternate = FALSE,
                           include_past = FALSE,
                           include_seasonal = FALSE,
                           include_student_local = FALSE,
                           include_student_permanent = FALSE,
                           type = "home") {
    state <- prep_dots(...)
    reroute(lives_in_state_(state,
                            include_alternate = include_alternate,
                            include_past = include_past,
                            include_seasonal = include_seasonal,
                            include_student_local = include_student_local,
                            include_student_permanent = include_student_permanent,
                            type = type))
}

lives_in_state_ <- function(state,
                            include_alternate = FALSE,
                            include_past = FALSE,
                            include_seasonal = FALSE,
                            include_student_local = FALSE,
                            include_student_permanent = FALSE,
                            type = "home") {
    address_widget("state_code", state,
                   type = type,
                   include_alternate = include_alternate,
                   include_past = include_past,
                   include_seasonal = include_seasonal,
                   include_student_local = include_student_local,
                   include_student_permanent = include_student_permanent)
}
