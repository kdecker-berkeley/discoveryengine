#' @rdname address
#' @export
works_in_msa <- function(...,
                         include_alternate = FALSE,
                         include_past = FALSE,
                         include_self_employed = TRUE,
                         type = "business") {
    msas <- prep_dots(...)
    reroute(works_in_msa_(msas,
                          include_alternate = include_alternate,
                          include_past = include_past,
                          include_self_employed = include_self_employed,
                          type = type))
}

works_in_msa_ <- function(msas,
                          include_alternate = FALSE,
                          include_past = FALSE,
                          include_self_employed = TRUE,
                          type = "business") {
    address_widget("geo_metro_area_code", msas,
                   type = type,
                   include_alternate = include_alternate,
                   include_past = include_past,
                   include_self_employed = include_self_employed,
                   include_seasonal = FALSE,
                   include_student_local = FALSE,
                   include_student_permanent = FALSE)
}


