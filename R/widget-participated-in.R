#' Student Activity widget
#'
#' @details If no student activities are entered, then widget will look for
#' people who participated in any student activity.
#'
#' @return A definition of type \code{entity_id}
#'
#' @param ... Student activity codes/synonyms
#' @param leaders_only Pull only leaders of student groups (TRUE) or all
#' participants (FALSE)? Defaults to FALSE (all participants)
#'
#' @examples
#' ## Nick once needed to find parents of band members who graduated in
#' ## the last 5 years. so, start with recently graduated band members:
#' recent_band_members = participated_in(MSMB) %and% has_reunion_year(2010:2015)
#'
#' ## then get their parents
#' recent_band_parents = parent_of(recent_band_members)
#'
#' display(recent_band_parents)
#'
#' @export
participated_in <- function(..., leaders_only = FALSE) {
    activities <- prep_dots(...)
    reroute(participated_in_(activities, leaders_only))
}

participated_in_ <- function(activities, leaders_only = FALSE) {
    if (leaders_only) participation <- "L" else participation <- c("P", "L")

    entity_widget("d_bio_student_activity_mv",
                  parameter = string_param("student_activity_code", activities),
                  switches = string_switch("student_particip_code", participation))
}
