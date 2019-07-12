#' @rdname address
#' @export
works_in_zip <- function(...,
                         include_alternate = FALSE,
                         include_past = FALSE,
                         include_self_employed = TRUE,
                         type = "business") {
    zips <- prep_dots(...)
    reroute(works_in_zip_(zips,
                          include_alternate = include_alternate,
                          include_past = include_past,
                          include_self_employed = include_self_employed,
                          type = type))
}

works_in_zip_ <- function(zips,
                          include_alternate = FALSE,
                          include_past = FALSE,
                          include_self_employed = TRUE,
                          type = "business") {
    address_widget("zipcode5", zips,
                   type = type, param_fn = zipcode_param,
                   include_alternate = include_alternate,
                   include_past = include_past,
                   include_self_employed = include_self_employed,
                   include_seasonal = FALSE,
                   include_student_local = FALSE,
                   include_student_permanent = FALSE)
}


