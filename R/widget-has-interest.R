#' Interest code widget
#'
#' Find entities with a given interest(s)
#'
#' If no interests are entered, widget will search for entities with any interest
#' code.
#'
#' @return A definition of type \code{entity_id}
#'
#' @param ... Interest code(s)
#' @param include_former If TRUE (default), will include all interest codes,
#' even if they have a stop date. If FALSE, will exclude codes with a stop date.
#' @param comment (Optional) Supply one or more search terms to search through
#' the comment fields of the interest area
#'
#' @examples
#' has_interest(data_science)
#'
#' ## prospects for cancer research can be interest coded with "cancer"
#' ## or with the more general "health"
#' has_interest(cancer) %or% has_interest(health, comment = "cancer")
#'
#' @export
has_interest <- function(..., include_former = TRUE, comment = NULL) {
    interests <- prep_dots(...)
    reroute(has_interest_(interests, include_former = include_former,
                          comment = comment))
}

has_interest_ <- function(interests, include_former = TRUE, comment = NULL) {
    if (include_former) former_switch <- NULL
    else former_switch <- quote(stop_dt %is% null)

    comment_switch <- regex_switch("comment1 || comment2", comment)

    entity_widget("d_bio_interest_mv",
                  parameter = string_param("interest_code", interests),
                  switches = list(former_switch,
                                  comment_switch))
}
