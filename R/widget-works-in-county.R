#' @rdname address
#' @export
works_in_county <- function(...,
                            include_alternate = TRUE,
                            include_past = FALSE,
                            include_self_employed = TRUE,
                            type = "business") {
    counties <- prep_dots(...)
    reroute(works_in_county_(counties,
                             include_alternate = include_alternate,
                             include_past = include_past,
                             include_self_employed = include_self_employed,
                             type = type))
}

works_in_county_ <- function(counties,
                             include_alternate = TRUE,
                             include_past = FALSE,
                             include_self_employed = TRUE,
                             type = "business") {
    address_widget("county_code", counties,
                   type = type,
                   include_alternate = include_alternate,
                   include_past = include_past,
                   include_self_employed = include_self_employed,
                   include_seasonal = FALSE,
                   include_student_local = FALSE,
                   include_student_permanent = FALSE)
}
