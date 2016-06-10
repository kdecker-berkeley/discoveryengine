#' Capacity widget
#' @param ... capacity rating codes (eg: 1, 10, 99)
#' @export
has_capacity <- function(...) {
    entity_widget(
        table = "d_entity_mv",
        parameter = integer_param("capacity_rating_code", ...,
                                  default = 1:14)
    )
}
