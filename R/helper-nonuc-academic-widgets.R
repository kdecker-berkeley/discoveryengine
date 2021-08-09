nonuc_academic_widget <- function(
    param,
    undergraduates, graduates, attendees, current_students, degreeholders,
    from, to) {

    levels = NULL
    student_levels <- NULL
    date_switch <- daterange(
        dbplyr::sql("case when degree_level_code in ('U', 'G') then grad_dt else stop_dt end"),
        from = from, to = to
    )

    if (!undergraduates && !graduates)
        stop("You must include at least one of undergraduates or graduates, ",
             "but they are both FALSE")

    if (!attendees && !current_students && !degreeholders)
        stop("You must include at least one of attendees, ",
             "current_students, or degreeholders, but they are all FALSE")

    if (undergraduates) {
        if (degreeholders) levels <- c(levels, "U")
        if (attendees) levels <- c(levels, "A")
        if (current_students) student_levels <- c(student_levels, "A")
    }

    if (graduates) {
        if (degreeholders) levels <- c(levels, "G")
        if (attendees) levels <- c(levels, c("L", "V", "P"))
        if (current_students) student_levels <- c(student_levels, "L")
    }

    if (any(degreeholders, attendees)) {
        alum <- entity_widget("d_bio_degrees_mv",
                              parameter = param,
                              switches = list(
                                  string_switch("degree_level_code", levels),
                                  date_switch
                              ))
    } else {
        alum <- NULL
    }
    if (current_students) {
        if (is.list(param)) st_param <- param[[1]] else st_param <- param
        if (!is.null(st_param) && st_param[[2]] == quote(degree_code))
            st_param[[2]] <- quote(case_code)
        st <- entity_widget("d_bio_degrees_mv",
                            parameter = st_param,
                            switches = list(
                                string_switch("degree_level_code", student_levels),
                                string_switch("non_grad_code", c("C", "N", "R"))
                            ))
    } else {
        st <- NULL
    }

    res <- Filter(function(x) !is.null(x), list(alum, st))
    Reduce(`%or%`, res)
}
