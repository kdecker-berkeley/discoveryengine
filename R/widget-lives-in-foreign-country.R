#' @rdname address
#' @export
lives_in_foreign_country <- function(...,
                                     include_alternate = TRUE,
                                     include_past = FALSE,
                                     include_seasonal = FALSE,
                                     include_student_local = FALSE,
                                     include_student_permanent = FALSE,
                                     type = "home") {
    countries <- prep_dots(...)
    reroute(lives_in_foreign_country_(countries,
                                      include_alternate = include_alternate,
                                      include_past = include_past,
                                      include_seasonal = include_seasonal,
                                      include_student_local = include_student_local,
                                      include_student_permanent = include_student_permanent,
                                      type = type))
}


lives_in_foreign_country_ <- function(countries,
                                      include_alternate = TRUE,
                                      include_past = FALSE,
                                      include_seasonal = FALSE,
                                      include_student_local = FALSE,
                                      include_student_permanent = FALSE,
                                      type = "home") {
    address_widget("country_code", countries,
                   type = type,
                   include_alternate = include_alternate,
                   include_past = include_past,
                   include_seasonal = include_seasonal,
                   include_student_local = include_student_local,
                   include_student_permanent = include_student_permanent)
}


# tms_country
