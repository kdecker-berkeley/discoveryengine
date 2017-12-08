#' Giving widgets
#'
#' Find entities who have given to specific types of funds
#'
#' @details giving is calculated on a pledged basis, and includes soft credits.
#' For dates, the giving record date is used. If no area/department is entered,
#' widget will find donors to anything.
#'
#' @return A definition of type \code{entity_id}
#'
#' @param ... Area(s)/Department(s) of giving
#' @param at_least minimum total giving
#' @param from begin and end dates (gave between those dates). Enter as an integer of the form YYYYMMDD
#' @param to begin and end dates (gave between those dates). Enter as an integer of the form YYYYMMDD
#'
#' @examples
#' ## gave at least $5,000 to cal performances during FY 2016
#' gave_to_area(cal_performances, at_least = 5000, from = 20150701, to = 20161231)
#'
#' ## has given at least $100,000 lifetime to engineering
#' gave_to_area(engineering, at_least = 100000)
#'
#' @seealso \code{\link{gave_to_fund}}
#' @name giving
NULL

#' @rdname giving
#' @export
gave_to_area <- function(..., at_least = 0.01, from = NULL,
                         to = NULL) {
    aogs <- prep_dots(...)
    reroute(gave_to_area_(aogs, at_least = at_least,
                          from = from, to = to))
}

gave_to_area_ <- function(aogs, at_least = 0.01, from = NULL, to = NULL) {
    funds <- fund_area_(aogs)
    gave_to_fund(funds, at_least = at_least, from = from, to = to)
}
