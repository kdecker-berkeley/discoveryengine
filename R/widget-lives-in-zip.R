#' @rdname address
#' @export
lives_in_zip <- function(...,
                         include_alternate = FALSE,
                         include_past = FALSE,
                         include_seasonal = FALSE,
                         include_student_local = FALSE,
                         include_student_permanent = FALSE,
                         type = "home") {
    zips <- prep_dots(...)
    reroute(lives_in_zip_(zips,
                          include_alternate = include_alternate,
                          include_past = include_past,
                          include_seasonal = include_seasonal,
                          include_student_local = include_student_local,
                          include_student_permanent = include_student_permanent,
                          type = type))
}

lives_in_zip_ <- function(zips,
                          include_alternate = FALSE,
                          include_past = FALSE,
                          include_seasonal = FALSE,
                          include_student_local = FALSE,
                          include_student_permanent = FALSE,
                          type = "home") {
    address_widget("zipcode5", zips,
                   type = type, param_fn = zipcode_param,
                   include_alternate = include_alternate,
                   include_past = include_past,
                   include_seasonal = include_seasonal,
                   include_student_local = include_student_local,
                   include_student_permanent = include_student_permanent)
}
