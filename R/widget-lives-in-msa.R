#' @rdname address
#' @export
lives_in_msa <- function(...,
                         include_alternate = TRUE,
                         include_past = FALSE,
                         include_seasonal = FALSE,
                         include_student_local = FALSE,
                         include_student_permanent = FALSE,
                         type = "home") {
    msa <- prep_dots(...)
    reroute(lives_in_msa_(msa,
                          include_alternate = include_alternate,
                          include_past = include_past,
                          include_seasonal = include_seasonal,
                          include_student_local = include_student_local,
                          include_student_permanent = include_student_permanent,
                          type = type))
}

lives_in_msa_ <- function(msa,
                          include_alternate = TRUE,
                          include_past = FALSE,
                          include_seasonal = FALSE,
                          include_student_local = FALSE,
                          include_student_permanent = FALSE,
                          type = "home") {
    address_widget("geo_metro_area_code", msa,
                   type = type,
                   include_alternate = include_alternate,
                   include_past = include_past,
                   include_seasonal = include_seasonal,
                   include_student_local = include_student_local,
                   include_student_permanent = include_student_permanent)
}
