#' @rdname academic
#' @export
has_degree <- function(..., undergraduates = TRUE,
                       graduates = TRUE, attendees= FALSE,
                       from = NULL, to = NULL) {
    codes <- prep_dots(...)
    reroute(has_degree_(codes, undergraduates = undergraduates,
                        graduates = graduates, attendees = attendees,
                        from = from, to = to))
}

has_degree_ <- function(codes, undergraduates = TRUE,
                        graduates = TRUE, attendees = FALSE,
                        from = NULL, to = NULL) {
    levels = NULL

    ## can't use the normal daterange tool here,
    ## because we want conditional date field: use grad_dt for alumni,
    ## use stop_dt for attendees

    date_switch <- daterange(
        dbplyr::sql("case when degree_level_code in ('U', 'G') then grad_dt else stop_dt end"),
        from = from, to = to
    )

    if (undergraduates) {
        levels <- c(levels, "U")
        if (attendees) levels <- c(levels, "A")
    }

    if (graduates) {
        levels <- c(levels, "G")
        if (attendees) levels <- c(levels, "L")
    }

    if (!graduates && !undergraduates && attendees) {
        warning("has_degree_from: you selected attendees but not undergraduates or graduates. Both undergrad and grad attendees (but not degreeholders) will be selected", call. = FALSE)
        levels <- c("L", "A")
    }

    entity_widget("d_bio_degrees_mv",
                  parameter = string_param("degree_code", codes),
                  switches = list(
                      string_switch("degree_level_code", levels),
                      date_switch,
                      quote(local_ind == "Y")
                  ))
}
