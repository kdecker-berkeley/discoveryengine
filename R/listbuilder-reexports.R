#' @importFrom listbuilder get_cdw
#' @export
get_cdw <- listbuilder::get_cdw

#' @importFrom listbuilder to_sql
#' @export
to_sql <- listbuilder::to_sql

#' @importFrom listbuilder %and%
#' @export
`%and%` <- listbuilder::`%and%`

#' @importFrom listbuilder %or%
#' @export
`%or%` <- listbuilder::`%or%`

#' @importFrom listbuilder %minus%
`%minus%` <- function(...) {
    warning("%minus% is deprecated, use %but_not% instead")
    listbuilder::`%minus%`(...)
}

#' @importFrom listbuilder %minus%
#' @export
`%but_not%` <- listbuilder::`%minus%`

