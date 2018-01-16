#' @rdname address
#' @export
works_in_foreign_country <- function(...,
                                     include_alternate = TRUE,
                                     include_past = FALSE,
                                     include_self_employed = TRUE,
                                     type = "business") {
    countries <- prep_dots(...)
    reroute(works_in_foreign_country_(countries,
                                      include_alternate = include_alternate,
                                      include_past = include_past,
                                      include_self_employed = include_self_employed,
                                      type = type))
}


works_in_foreign_country_ <- function(countries,
                                      include_alternate = TRUE,
                                      include_past = FALSE,
                                      include_self_employed = TRUE,
                                      type = "business") {
    address_widget("country_code", countries,
                   type = type,
                   include_alternate = include_alternate,
                   include_past = include_past,
                   include_self_employed = include_self_employed,
                   include_seasonal = FALSE,
                   include_student_local = FALSE,
                   include_student_permanent = FALSE)
}
